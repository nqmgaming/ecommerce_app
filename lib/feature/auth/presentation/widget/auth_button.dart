import 'package:ecommerce_app/core/constants/fonts_constant.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isLoading;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: const Color.fromRGBO(45, 32, 28, 1),
          foregroundColor: Colors.white,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                title.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: FontConstants.productSansRegular,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
