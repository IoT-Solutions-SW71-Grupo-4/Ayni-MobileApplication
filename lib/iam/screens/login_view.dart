import 'package:ayni_mobile_app/iam/widgets/auth_text_field_widget.dart';
import 'package:ayni_mobile_app/iam/widgets/password_text_field_widget.dart';
import 'package:ayni_mobile_app/shared/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              SizedBox(
                height: 100,
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    color: colors["color-main-green"],
                  ),
                ),
              ),
              Form(
                child: Column(
                  children: [
                    SizedBox(
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AuthTextFieldWidget(
                            controller: _emailController,
                            labelText: "Email",
                          ),
                          PasswordTextFieldWidget(
                            controller: _passwordController,
                            labelText: "Password",
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (bool? value) {},
                          activeColor: colors["color-main-green"],
                        ),
                        Text(
                          "Remember me",
                          style: TextStyle(
                            fontSize: 14,
                            color: colors["color-50-black"],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors["color-main-green"],
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: colors["color-white"],
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontSize: 13,
                          color: colors["color-50-black"],
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
                          color: Color(0xFF121212), // Color del texto
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
                    onPressed: () => {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors["color-light-green"],
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
                            Text(
                              "Log in using Gmail",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: colors["color-black"],
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
                        Text(
                          "Don't you have an account?",
                          style: TextStyle(
                            fontSize: 13,
                            color: colors["color-50-black"],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.goNamed("register_view");
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 13,
                              color: colors["color-50-black"],
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
