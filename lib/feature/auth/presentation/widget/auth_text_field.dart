import 'package:ecommerce_app/core/constants/colors_constant.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.validator,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText ? !_passwordVisible : false,
      obscuringCharacter: '*',
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      cursorColor: ColorsConstant.blackColor,
      decoration: InputDecoration(
        label: Text(widget.hintText),
        labelStyle: TextStyle(
          color: ColorsConstant.blackColor.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorsConstant.greyColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorsConstant.blackColor),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorsConstant.redColor),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorsConstant.redColor),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: ColorsConstant.blackColor,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : null,
      ),
      textInputAction: TextInputAction.next,
      validator: widget.validator,
    );
  }
}
