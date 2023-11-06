import 'package:flutter/material.dart';
import 'package:ride_app/helpers/constants.dart';

class RoundedTextField extends StatelessWidget {
  final String? hint;
  String? label;
  Color? focusedColor;
  Color? disabledColor;
  Color? enabledColor;
  Color? iconColor;
  TextEditingController? controller;
  TextInputType? type;
  bool? obsecureText;
  Icon? icon;
  Function? onEditingComplete;
  Function(String)? onChange;
  int? maxLines;
  String? Function(String?)? validator;

  RoundedTextField(
      {this.controller,
      this.disabledColor,
      this.enabledColor,
      this.focusedColor,
      this.hint,
      this.icon,
      this.iconColor,
      this.label,
      this.obsecureText,
      this.onChange,
      this.onEditingComplete,
      this.type,
      this.maxLines,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (text) {
        onChange!(text);
      },
      controller: controller,
      keyboardType: type ?? TextInputType.text,
      obscureText: obsecureText ?? false,
      decoration: new InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          //alignLabelWithHint: false,
          //floatingLabelBehavior: FloatingLabelBehavior.auto,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedColor ?? mycolor, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mycolor, width: 1.0),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          hintText: hint ?? 'Your Value',
          //labelText: label ?? null,
          //labelStyle: TextStyle(fontFamily: "Nunito", color: mycolor),
          hintStyle: TextStyle(fontFamily: "Nunito")),
      validator: validator ?? null,
    );
  }
}
