import 'package:flutter/material.dart';

import '../../utility/constents.dart';


class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool? isPassword;
  final bool? isNum;
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

   const CustomTextFormField({super.key, this.onSaved, this.validator, required this.labelText, required this.icon,  this.isPassword, this.hintText, this.controller, this.isNum});

  @override
  Widget build(BuildContext context) {
    double radius = 15;
    return SizedBox(
      height: 80,
      child: TextFormField(
        controller: controller,
        onSaved: onSaved,
        keyboardType: isNum != null?TextInputType.number:null,
        obscureText: isPassword ?? false,
        validator: validator,
        decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            labelStyle: const TextStyle(
                fontSize: 13, color: kDarkPrimaryColor),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius)),
            suffixIcon: Icon(icon),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: const BorderSide(color:Colors.indigoAccent))),
      ),
    );
  }
}
