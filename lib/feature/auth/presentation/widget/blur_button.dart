import 'package:ecommerce_app/core/constants/fonts_constant.dart';
import 'package:flutter/material.dart';

class BlurButton extends StatelessWidget {
  final VoidCallback onPressed;
  final title;

  const BlurButton({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withOpacity(0.5),
        border: Border.all(color: Colors.white.withOpacity(0.7), width: 2),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: FontConstants.productSansBold,
          ),
        ),
      ),
    );
  }
}
