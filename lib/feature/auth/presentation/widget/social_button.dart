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
      padding: EdgeInsets.only(right: isLast ? 0 : 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          onPressed();
        },
        child: Image.asset(
          imageAsset,
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
