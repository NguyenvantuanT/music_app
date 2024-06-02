import 'package:flutter/material.dart';

class AppMediumbutton extends StatelessWidget {
  const AppMediumbutton({super.key, required this.icon, this.onTap});

  final Icon icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: icon,
      ),
    );
  }
}