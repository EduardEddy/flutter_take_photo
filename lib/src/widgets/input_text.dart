import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final TextInputType keyBoardType;
  final bool obscureText;
  final double fontSize;
  final void Function(String text) onChanged;
  final String? Function(String? text) validator;
  final int maxLines;

  const InputText({
    Key? key,
    this.label = '',
    this.keyBoardType = TextInputType.text,
    this.obscureText = false,
    this.fontSize = 15,
    required this.onChanged,
    required this.validator,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBoardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0.5),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.grey,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.red,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      ),
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines,
    );
  }
}
