import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final IconData? icon;

  const TextFieldWidget({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFE4E4E4),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:15.0),
              child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: Color(0xFF848484)),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Icon(
              icon,
              color: Color(0xFF848484),
            ),
          ),
        ],
      ),
    );
  }
}
