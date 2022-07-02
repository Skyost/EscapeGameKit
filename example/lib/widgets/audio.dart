import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:just_audio/just_audio.dart' as audio;

/// An audio player.
/// Thanks [https://github.com/daohoangson/flutter_widget_from_html/blob/master/packages/fwfh_just_audio/lib/src/audio_player/audio_player.dart](fwfh_just_audio) !
class AudioPlayer extends StatefulWidget {
  /// The source.
  final String asset;

  /// Controls whether to play audio automatically.
  ///
  /// Default: `false`.
  final bool autoplay;

  /// Controls whether to play audio in loops.
  ///
  /// Default: `false`.
  final bool loop;

  /// Controls whether to mute initially.
  ///
  /// Default: `false`.
  final bool muted;

  /// Controls whether to preload audio data.
  ///
  /// Default: `false`.
  final bool preload;

  /// The pause button callback.
  ///
  /// Defaults : `(player) => player.pause()`.
  final Function(audio.AudioPlayer)? pause;

  /// The pause button callback.
  ///
  /// Defaults : `(player) => player.play()`.
  final Function(audio.AudioPlayer)? play;

  /// The pause button callback.
  ///
  /// Defaults : `(player, duration) => player.seek(duration)`.
  final Function(audio.AudioPlayer, Duration)? seek;

  /// Creates a player.
  const AudioPlayer(
    this.asset, {
    this.autoplay = false,
    super.key,
    this.loop = false,
    this.muted = false,
    this.preload = true,
    this.pause,
    this.play,
    this.seek,
  });

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

/// The [AudioPlayer] state.
class _AudioPlayerState extends State<AudioPlayer> {
  /// The player.
  late final audio.AudioPlayer player;

  /// The state subscription.
  late final StreamSubscription processingStateStreamSubscription;

  @override
  void initState() {
    super.initState();

    player = audio.AudioPlayer();
    processingStateStreamSubscription = player.processingStateStream.listen((processingState) {
      if (!mounted) {
        return;
      }

      if (processingState == audio.ProcessingState.completed) {
        player.pause();
        player.seek(Duration.zero);
      }
    });

    player
      ..setAsset(widget.asset, preload: widget.preload)
      ..setLoopMode(widget.loop ? audio.LoopMode.one : audio.LoopMode.off);

    if (widget.autoplay) {
      player.play();
    }

    if (widget.muted) {
      player.setVolume(0);
    }
  }

  @override
  void dispose() {
    processingStateStreamSubscription.cancel();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, bc) {
          final isNarrow = bc.hasBoundedWidth && bc.maxWidth <= 320;
          final theme = Theme.of(context);
          final iconSize = DefaultTextStyle.of(context).style.fontSize! * MediaQuery.of(context).textScaleFactor;

          return Container(
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.light ? const Color.fromRGBO(0, 0, 0, .1) : const Color.fromRGBO(255, 255, 255, .1),
              borderRadius: BorderRadius.circular(iconSize * 2),
            ),
            child: Row(
              children: [
                PlayButton(
                  pause: widget.pause != null ? () => widget.pause!(player) : player.pause,
                  play: widget.play != null ? () => widget.play!(player) : player.play,
                  size: iconSize,
                  stream: player.playingStream,
                ),
                _PositionText(
                  durationStream: player.durationStream,
                  isNarrow: isNarrow,
                  positionStream: player.positionStream,
                  size: iconSize,
                ),
                Expanded(
                  child: _PositionSlider(
                    durationStream: player.durationStream,
                    positionStream: player.positionStream,
                    seek: widget.seek != null ? (duration) => widget.seek!(player, duration) : player.seek,
                    size: iconSize,
                  ),
                ),
              ],
            ),
          );
        },
      );
}

/// A player / pause button.
class PlayButton extends StatelessWidget {
  /// Called when the user clicks on _Pause_.
  final VoidCallback pause;

  /// Called when the user clicks on _Play_.
  final VoidCallback play;

  /// The button size.
  final double size;

  /// The audio stream.
  final Stream<bool> stream;

  /// Creates a new [PlayButton] instance.
  const PlayButton({
    super.key,
    required this.pause,
    required this.play,
    required this.size,
    required this.stream,
  });

  @override
  Widget build(BuildContext context) => StreamBuilder<bool>(
        builder: (_, snapshot) {
          final isPlaying = snapshot.data ?? false;
          return IconButton(
            onPressed: isPlaying ? pause : play,
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            iconSize: size * 2,
          );
        },
        stream: stream,
      );
}

/// Allows to display the current position in the audio playing.
class _PositionText extends StatelessWidget {
  /// The duration stream.
  final Stream<Duration?> durationStream;

  /// Whether to display the remaining time or no.
  final bool isNarrow;

  /// The position stream.
  final Stream<Duration> positionStream;

  /// The position text size.
  final double size;

  /// Creates a new [_PositionText] instance.
  const _PositionText({
    required this.durationStream,
    required this.isNarrow,
    required this.positionStream,
    required this.size,
  });

  @override
  Widget build(BuildContext _) => StreamBuilder<Duration?>(
        builder: (_, duration) => StreamBuilder<Duration>(
          builder: (_, position) {
            final max = duration.data?.inSeconds ?? -1;
            final value = position.data?.inSeconds ?? -1;
            final remaining = max > value ? max - value : 0;
            final text = isNarrow
                ? '-${secondsToString(remaining)}'
                : '${secondsToString(value)} / '
                    '${secondsToString(max)}';
            return Text(
              text,
              style: TextStyle(fontSize: size),
              textScaleFactor: 1,
            );
          },
          stream: positionStream,
        ),
        stream: durationStream,
      );

  /// Converts a specified seconds [value] to a string.
  String secondsToString(int value) {
    if (value < 0) {
      return '0:00';
    }

    final min = value ~/ 60;
    final sec = value % 60;
    return '$min:${sec.toString().padLeft(2, '0')}';
  }
}

/// The position slider widget.
class _PositionSlider extends StatelessWidget {
  /// The duration stream.
  final Stream<Duration?> durationStream;

  /// The position stream.
  final Stream<Duration> positionStream;

  /// Triggered when the user seeks to a specified duration.
  final void Function(Duration) seek;

  /// The position size.
  final double size;

  /// Creates a new [_PositionSlider] instance.
  const _PositionSlider({
    required this.durationStream,
    required this.positionStream,
    required this.seek,
    required this.size,
  });

  @override
  Widget build(BuildContext context) => StreamBuilder<Duration?>(
        builder: (_, duration) => StreamBuilder<Duration>(
          builder: (_, position) {
            final max = duration.data?.inMilliseconds.toDouble();
            if (max == null) {
              return widget0;
            }

            final value = position.data?.inMilliseconds.toDouble() ?? 0.0;

            return SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: size / 2),
              ),
              child: Slider.adaptive(
                max: max,
                onChanged: onChanged,
                value: value,
              ),
            );
          },
          stream: positionStream,
        ),
        stream: durationStream,
      );

  /// Triggered when the user seeks to the specified [ms].
  void onChanged(double ms) => seek(Duration(milliseconds: ms.toInt()));
}
