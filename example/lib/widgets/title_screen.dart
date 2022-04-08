import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

/// The title screen, shown before the game starts.
class TitleScreen extends StatelessWidget {
  /// The child widget.
  final Widget child;

  /// Creates a new [TitleScreen] instance.
  const TitleScreen({
    Key? key,
    required this.child,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          Flash(
            duration: const Duration(seconds: 1),
            child: Image.asset(
              'assets/backgrounds/title.png',
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            top: 60,
            child: FadeIn(
              delay: const Duration(seconds: 2),
              duration: const Duration(seconds: 1),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AboutDialog(
                      applicationName: 'ERROR 1980',
                      applicationVersion: 'v1.0.0',
                      applicationIcon: Image.asset(
                        'assets/icon.png',
                        height: 60,
                      ),
                      applicationLegalese: "Copyright © 2022 Hugo Delaunay. All rights reserved.\nThanks to FreePik for the icon, and thanks to upklyak for the sets and the objects.",
                    ),
                  );
                },
                child: Image.asset(
                  'assets/logo.png',
                  scale: 1.5,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            child: FadeIn(
              delay: const Duration(seconds: 3),
              child: child,
            ),
          ),
        ],
      );
}
