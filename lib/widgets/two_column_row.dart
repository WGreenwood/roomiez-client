
import 'package:flutter/material.dart';

class TwoColumnRow extends StatelessWidget {
  final Widget leftChild;
  final int leftFlex;
  final Widget rightChild;
  final int rightFlex;
  final double middingSpacing;

  TwoColumnRow({this.leftChild, this.rightChild, this.leftFlex = 1, this.rightFlex = 1, this.middingSpacing = 8});

  @override
  Widget build(BuildContext context)
    => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          flex: leftFlex,
          child: leftChild
        ),
        SizedBox(width: middingSpacing),
        Expanded(
          flex: rightFlex,
          child: rightChild
        ),
      ],
    );
}