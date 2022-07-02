import 'package:flutter/material.dart';

/// The widget shown at the end of the game.
class EndMessage extends StatelessWidget {
  /// Creates a new [EndMessage] instance.
  const EndMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.black26,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'CONGRATULATIONS !',
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Well done, you got back to ${DateTime.now().year} with success !',
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
}
