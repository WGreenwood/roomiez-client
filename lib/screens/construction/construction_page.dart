
import 'package:flutter/material.dart';

class UnderConstructionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Transform.rotate(
            angle: 0.2,
            child: Text(
              'Under Construction',
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontSize: 34,
                decoration: TextDecoration.underline
              ),
            ),
          ),
        ],
      ),
    );
  }
}