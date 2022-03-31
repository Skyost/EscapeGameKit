import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:just_audio/just_audio.dart' as lib;

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
  final Function(lib.AudioPlayer)? pause;

  /// The pause button callback.
  ///
  /// Defaults : `(player) => player.play()`.
  final Function(lib.AudioPlayer)? play;

  /// The pause button callback.
  ///
  /// Defaults : `(player, duration) => player.seek(duration)`.
  final Function(lib.AudioPlayer, Duration)? seek;

  /// Creates a player.
  const AudioPlayer(
    this.asset, {
    this.autoplay = false,
    Key? key,
    this.loop = false,
    this.muted = false,
    this.preload = true,
    this.pause,
    this.play,
    this.seek,
  }) : super(key: key);

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  late final lib.AudioPlayer _player;
  late final StreamSubscription _processingStateStreamSub;

  @override
  void initState() {
    super.initState();

    _player = lib.AudioPlayer();
    _processingStateStreamSub = _player.processingStateStream.listen((processingState) {
      if (!mounted) {
        return;
      }

      if (processingState == lib.ProcessingState.completed) {
        _player.pause();
        _player.seek(Duration.zero);
      }
    });

    _player
      ..setAsset(widget.asset, preload: widget.preload)
      ..setLoopMode(widget.loop ? lib.LoopMode.one : lib.LoopMode.off);

    if (widget.autoplay) {
      _player.play();
    }

    if (widget.muted) {
      _player.setVolume(0);
    }
  }

  @override
  void dispose() {
    _processingStateStreamSub.cancel();
    _player.dispose();
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
                  pause: widget.pause != null ? () => widget.pause!(_player) : _player.pause,
                  play: widget.play != null ? () => widget.play!(_player) : _player.play,
                  size: iconSize,
                  stream: _player.playingStream,
                ),
                _PositionText(
                  durationStream: _player.durationStream,
                  isNarrow: isNarrow,
                  positionStream: _player.positionStream,
                  size: iconSize,
                ),
                Expanded(
                  child: _PositionSlider(
                    durationStream: _player.durationStream,
                    positionStream: _player.positionStream,
                    seek: widget.seek != null ? (duration) => widget.seek!(_player, duration) : _player.seek,
                    size: iconSize,
                  ),
                ),
              ],
            ),
          );
        },
      );
}

class PlayButton extends StatelessWidget {
  final VoidCallback pause;
  final VoidCallback play;
  final double size;
  final Stream<bool> stream;

  const PlayButton({
    Key? key,
    required this.pause,
    required this.play,
    required this.size,
    required this.stream,
  }) : super(key: key);

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

class _PositionText extends StatelessWidget {
  final Stream<Duration?> durationStream;
  final bool isNarrow;
  final Stream<Duration> positionStream;
  final double size;

  const _PositionText({
    Key? key,
    required this.durationStream,
    required this.isNarrow,
    required this.positionStream,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext _) => StreamBuilder<Duration?>(
        builder: (_, duration) => StreamBuilder<Duration>(
          builder: (_, position) {
            final max = duration.data?.inSeconds ?? -1;
            final value = position.data?.inSeconds ?? -1;
            final remaining = max > value ? max - value : 0;
            final text = isNarrow
                ? '-${_secondsToString(remaining)}'
                : '${_secondsToString(value)} / '
                    '${_secondsToString(max)}';
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

  String _secondsToString(int value) {
    if (value < 0) {
      return '0:00';
    }

    final m = value ~/ 60;
    final s = value % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }
}

class _PositionSlider extends StatelessWidget {
  final Stream<Duration?> durationStream;
  final Stream<Duration> positionStream;
  final void Function(Duration) seek;
  final double size;

  const _PositionSlider({
    Key? key,
    required this.durationStream,
    required this.positionStream,
    required this.seek,
    required this.size,
  }) : super(key: key);

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

  void onChanged(double ms) => seek(Duration(milliseconds: ms.toInt()));
}
