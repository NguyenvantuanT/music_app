import 'package:flutter/material.dart';
import 'package:music_app/themes/color.dart';

class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTabBar(
      {super.key, this.color = AppColor.white, required this.text, this.onTap});

  final Color color;
  final String text;
  final Function()? onTap;
  @override
  Size get preferredSize => const Size.fromHeight(90.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0)
          .copyWith(top: MediaQuery.of(context).padding.top + 15, bottom: 15),
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          GestureDetector(
            onTap: onTap,
            child: Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
