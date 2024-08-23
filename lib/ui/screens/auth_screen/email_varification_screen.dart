import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/auth_screen/pin_verification_screen.dart';
import 'package:taskmanager/ui/widgets/background_widget.dart';

import '../../utility/app_colors.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  TextEditingController _emailTEController = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 190,
                  ),
                  Text(
                    "Your Email Address",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    " a 6 digit email verification pin send \n to your email address",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _onTapConfirmButton();
                    },
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: Colors.black.withOpacity(
                              0.8,
                            ),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4),
                        text: " have an account? ",
                        children: [
                          TextSpan(
                            text: " Sign In",
                            style: TextStyle(color: AppColors.themeColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _onTapSignInButton();
                              },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }

  void _onTapConfirmButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PinVerificationScreen(),
      ),
    );
  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }
}
