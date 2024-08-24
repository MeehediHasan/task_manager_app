import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskmanager/ui/screens/auth_screen/sign_in_screen.dart';
import 'package:taskmanager/ui/screens/main_button_nav_screen.dart';

import '../../controller/auth_controller.dart';
import '../../utility/asset_paths.dart';
import '../../widgets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    bool isUserLoggedIn = await AuthController.checkAuthState();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isUserLoggedIn ? const MainButtonNavScreen() : const SignInScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: SvgPicture.asset(
            AssetPaths.backgroundLogo,
            height: 220,
            width: 220,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
