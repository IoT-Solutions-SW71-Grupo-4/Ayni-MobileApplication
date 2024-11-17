import 'package:ayni_mobile_app/iam/widgets/auth_text_field_widget.dart';
import 'package:ayni_mobile_app/iam/widgets/checkbox_widget.dart';
import 'package:ayni_mobile_app/iam/widgets/password_text_field_widget.dart';
import 'package:ayni_mobile_app/shared/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/sign_up_service.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _areTermsAccepted = false;

  // Lista de roles y rol seleccionado
  final List<String> _roles = ["ROLE_USER", "ROLE_ADMIN"];
  String? _selectedRole;

  // Valida si el formulario es válido
  bool get _isFormValid {
    return _areTermsAccepted &&
        _selectedRole != null &&
        _formKey.currentState?.validate() == true;
  }

  // Validadores
  String? _validatePersonalData(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a valid name.';
    if (value.length < 3) return 'Name must be at least 3 characters.';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _confirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != _passwordController.text) {
      return "Please, confirm your password correctly";
    }
    return null;
  }

  // Método para enviar el formulario
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final signUpService = SignUpService();
      try {
        final errorMessage = await signUpService.signUp(
          "${_firstNameController.text} ${_lastnameController.text}",
          _emailController.text,
          _passwordController.text,
          [_selectedRole!],
        );

        if (errorMessage == null) {
          Fluttertoast.showToast(
            msg: "Registration successful!",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          context.goNamed("login_view");
        } else {
          _showErrorDialog(errorMessage); // Muestra el mensaje específico
        }
      } catch (error) {
        _showErrorDialog("An unexpected error occurred. Please try again.");
      }
    }
  }


  // Diálogo de error
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
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
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 56,
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: colors["color-main-green"] ?? Colors.green,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: SizedBox(
                    height: 700,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AuthTextFieldWidget(
                          controller: _firstNameController,
                          labelText: "First name",
                          validator: _validatePersonalData,
                        ),
                        AuthTextFieldWidget(
                          controller: _emailController,
                          labelText: "Email",
                          validator: _validateEmail,
                        ),
                        PasswordTextFieldWidget(
                          controller: _passwordController,
                          labelText: "Password",
                        ),
                        PasswordTextFieldWidget(
                          controller: _confirmPasswordController,
                          labelText: "Confirm password",
                          validator: _confirmPassword,
                        ),
                        DropdownButtonFormField<String>(
                          value: _selectedRole,
                          onChanged: (value) {
                            setState(() {
                              _selectedRole = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Select role",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: colors["color-main-green"] ?? Colors.green,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: colors["color-main-green"] ?? Colors.green,
                              ),
                            ),
                          ),
                          items: _roles
                              .map((role) => DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          ))
                              .toList(),
                          validator: (value) =>
                          value == null ? 'Please select a role' : null,
                        ),
                        CheckboxWidget(
                          value: _areTermsAccepted,
                          onChanged: (bool? val) {
                            setState(() {
                              _areTermsAccepted = val!;
                            });
                          },
                          text: "I agree with Ayni's Terms & Conditions",
                        ),
                        ElevatedButton(
                          onPressed: _isFormValid ? _submitForm : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            colors["color-main-green"] ?? Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: colors["color-white"] ?? Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}