import 'package:flutter/material.dart';

class EndMessage extends StatelessWidget {
  const EndMessage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.black26,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'FÉLICITATIONS !',
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Bravo, vous avez réussi à revenir en ${DateTime.now().year} !',
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
}
