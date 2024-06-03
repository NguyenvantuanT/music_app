import 'package:flutter/material.dart';
import 'package:music_app/themes/color.dart';

class AppSearchBox extends StatelessWidget {
  const AppSearchBox({super.key, this.controller, this.onChanged, this.focusNode});

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          border: Border.all(color: AppColor.black, width: 1.2),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIconConstraints: BoxConstraints(minWidth: 28.0),
            prefixIcon: Icon(
              Icons.search,
              color: AppColor.red,
              size: 22.0,
            ),
            hintText: 'Search music',
            hintStyle: TextStyle(color: AppColor.grey , fontSize: 15),
            ),
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
