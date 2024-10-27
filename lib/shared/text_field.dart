import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final Widget iconData;
  final String prefixText;
   const CustomTextField({super.key, required this. controller, required this.label, required this.hint, required this.iconData, this.prefixText=''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixText: prefixText,
          labelText: label,
          hintText: hint,
          prefixIcon: iconData,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          )


        ),


      ),
    );
  }
}
