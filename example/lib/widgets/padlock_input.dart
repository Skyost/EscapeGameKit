import 'package:flutter/material.dart';

class PadlockInputWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Function? tryUnlock;

  const PadlockInputWidget({
    Key? key,
    this.controller,
    this.tryUnlock,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          labelText: 'Entrer le code ici',
          icon: Icon(Icons.key),
        ),
        onSubmitted: tryUnlock == null ? null : (string) => tryUnlock!(),
      );
}
