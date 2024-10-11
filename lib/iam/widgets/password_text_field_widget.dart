import 'package:ayni_mobile_app/shared/utils/colors.dart';
import 'package:flutter/material.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  const PasswordTextFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool _isObscureText = true;

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: colors["color-main-green"]!),
      borderRadius: BorderRadius.circular(12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscureText,
      validator: _validatePassword,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(color: colors["color-main-green"]),
        focusedBorder: _buildBorder(),
        enabledBorder: _buildBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscureText ? Icons.visibility : Icons.visibility_off,
            color: colors["color-main-green"],
          ),
          onPressed: () {
            setState(() {
              _isObscureText = !_isObscureText;
            });
          },
        ),
      ),
    );
  }
}
