import 'package:flutter/material.dart';

class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
   AppTabBar(
      {super.key,
      required this.text,
      this.onTap,
      this.icon});
  final Icon? icon;
  final String text;
  final Function()? onTap;
  @override
  Size get preferredSize => const Size.fromHeight(90.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0)
          .copyWith(top: MediaQuery.of(context).padding.top + 10, bottom: 10),
      color: Theme.of(context).colorScheme.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style:const TextStyle(fontSize: 20),
          ),
          GestureDetector(
            onTap: onTap,
            child: icon,
          )
        ],
      ),
    );
  }
}
