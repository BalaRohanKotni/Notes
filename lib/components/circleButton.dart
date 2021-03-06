import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData iconTD;
  final Color colorTD;
  final VoidCallback onTap;
  final Color bgTD;
  CircleButton(
      {required this.iconTD,
      required this.colorTD,
      required this.onTap,
      required this.bgTD});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
        radius: 25,
        backgroundColor: bgTD,
        child: Icon(
          iconTD,
          color: colorTD,
          size: 28,
        ),
      ),
      onTap: onTap,
    );
  }
}
