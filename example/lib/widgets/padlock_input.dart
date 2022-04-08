import 'package:flutter/material.dart';

/// A simple text field widget.
class PadlockInputWidget extends StatelessWidget {
  /// The text field controller.
  final TextEditingController? controller;

  /// Triggered when the submit the field.
  final Function? tryUnlock;

  /// Creates a new [PadlockInputWidget] instance.
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
          labelText: 'Enter the code here',
          icon: Icon(Icons.key),
        ),
        onSubmitted: tryUnlock == null ? null : (string) => tryUnlock!(),
      );
}
