import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class TiInput extends StatelessWidget {
  final double width;
  final double? height;
  final String? hintText;
  final Color? hintColor;
  final Color? textColor;
  late String inputValue;
  late FluIcon? suffixIcon;
  final int? maxLines;

  late TextEditingController? inputController;
  final TextInputType? keyboardType;
  final String? icon;
  final Color color;
  final BoxBorder? border;
  late bool readonly = false;

  TiInput(
      {super.key,
      required this.color,
      this.hintText,
      this.height,
      this.icon,
      this.textColor,
      this.inputController,
      this.hintColor,
      this.border,
      this.suffixIcon,
      this.maxLines,
      this.keyboardType,
      required this.readonly,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      // margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: border,
      ),
      child: TextField(
          maxLines: maxLines,
          readOnly: readonly,
          keyboardType: keyboardType,
          controller: inputController,
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
          // controller: _username,

          onChanged: ((value) {
            inputValue = value;
            print("Saisie__$inputValue");
          }),
          decoration: InputDecoration(
            filled: true,
            fillColor: color,
            suffixIcon: suffixIcon,
            hintText: hintText,
            // contentPadding: EdgeInsets.only(bottom: 2, left: 20),
            hintStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(width: .15)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(width: .15, color: Theme.of(context).primaryColor)),
          )),
    );
  }
}
