import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? icon;
  final textInputType;
  final String? Function(String?)? validator;

  const TextFormFieldWidget({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.icon,
    this.textInputType,
    this.validator,
    Key? key,
  }) : super(key: key);

  // String? defaultValidator(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return "this field is required";
  //   } else {
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final customValidator = validator ?? defaultValidator;

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
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextFormField(
                validator: validator,
                controller: controller,
                obscureText: obscureText,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: Color(0xFF848484)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: OutlineInputBorder(),
                ),
              ),
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
