import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/auth_screen/sign_in_screen.dart';

import '../../../data/models/network_response.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/utilities/urls.dart';
import '../../widgets/background_widget.dart';
import '../../widgets/snack_bar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _registerInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Create Account ",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Text(
                            "Fill your information below and create your account",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@gmail.com')) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                      controller: _emailTEController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your first name";
                        }
                        return null;
                      },
                      controller: _firstNameTEController,
                      decoration: const InputDecoration(
                        hintText: "First name",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your last name";
                        }
                        return null;
                      },
                      controller: _lastNameTEController,
                      decoration: const InputDecoration(
                        hintText: "Last name",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your mobile number";
                        }
                        return null;
                      },
                      controller: _mobileTEController,
                      decoration: const InputDecoration(
                        hintText: "Mobile",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your password";
                        }
                        return null;
                      },
                      controller: _passwordTEController,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: _registerInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _registerUser();
                          }
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    buildBackToSignInSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackToSignInSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? "),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SignInScreen(),
            ));
          },
          child: const Text("Sign In"),
        ),
      ],
    );
  }
  void _registerUser() async {
    _registerInProgress = true;
    setState(() {});

    Map<String, dynamic> registerInputs = {
      "email": _emailTEController.text,
      "firstName": _firstNameTEController.text,
      "lastName": _lastNameTEController.text,
      "mobile": _mobileTEController.text,
      "password": _passwordTEController.text,
    };

    NetworkResponse response = await NetworkCaller.postResponse(
        Urls.registration,
        body: registerInputs);
    if (mounted) {
      setState(() {
        _registerInProgress = false;
      });
    }

    if (response.isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Registration Success');
        clearTextFields();
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Registration Failed');
      }
    }

    if (mounted) {
      setState(() {
        _registerInProgress = false;
      });
    }
  }

  void clearTextFields() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }
}
