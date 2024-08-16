import 'package:ecommerce_app/core/constants/colors_constant.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String imageAsset;
  final bool isLast;

  const SocialButton({
    super.key,
    required this.onPressed,
    required this.imageAsset,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: isLast ? 0 : 5),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: ColorsConstant.blackColor,
        ),
        onPressed: () {
          onPressed();
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            imageAsset,
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }
}
