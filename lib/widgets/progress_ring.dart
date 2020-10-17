import 'package:flutter/material.dart';

class ProgressRing extends StatelessWidget {
  final bool enabled;
  ProgressRing({
    this.enabled = false
  });
  @override
  Widget build(BuildContext context)
    => CircularProgressIndicator(
      strokeWidth: 3,
      value: enabled ? null : 0.0,
    );
}