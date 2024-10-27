import 'package:flutter/material.dart';
import 'package:samad_blood_bank/shared/text_style.dart';
class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CustomButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Center(child: Text(title, style: buttonTextStyle,)),
      ),
      
      
    );
  }
}
