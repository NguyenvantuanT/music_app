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
          color: AppColor.white,
          border: Border.all(color: AppColor.black, width: 1.2)),
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
            ),
            hintText: 'Search music',
            ),
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
