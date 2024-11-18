import 'package:ayni_mobile_app/iam/widgets/auth_text_field_widget.dart';
import 'package:ayni_mobile_app/iam/widgets/checkbox_widget.dart';
import 'package:ayni_mobile_app/iam/widgets/password_text_field_widget.dart';
import 'package:ayni_mobile_app/shared/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/sign_in_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isCheckedRememberMe = false;
  bool _isLoading = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final signInService = SignInService();

      try {
        final success = await signInService.signIn(
          _emailController.text,
          _passwordController.text,
        );

        setState(() {
          _isLoading = false;
        });

        if (success) {
          context.goNamed("home_view");
        } else {
          _showErrorDialog("Invalid credentials. Please try again.");
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        _showErrorDialog("An error occurred: ${e.toString()}");
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    color: Colors.green, // Usa el color definido para el tema
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 190,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AuthTextFieldWidget(
                            controller: _emailController,
                            labelText: "Email",
                            validator: _validateEmail,
                          ),
                          PasswordTextFieldWidget(
                            controller: _passwordController,
                            labelText: "Password",
                          ),
                        ],
                      ),
                    ),
                    CheckboxWidget(
                      value: _isCheckedRememberMe,
                      onChanged: (bool? val) {
                        setState(() {
                          _isCheckedRememberMe = val!;
                        });
                      },
                      text: "Remember me",
                    ),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => {}, // Agregar lógica de "Forgot password"
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black, // Color del texto del botón
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1, // Altura de la línea
                        color: Colors.grey, // Color de la línea
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.0), // Espacio alrededor del texto
                      child: Text(
                        'or',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1, // Altura de la línea
                        color: Colors.grey, // Color de la línea
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () => {}, // Agregar lógica para Gmail Login
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/google-logo.png',
                              height: 22,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "Log in using Gmail",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Don't you have an account?",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.goNamed("register_view");
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
