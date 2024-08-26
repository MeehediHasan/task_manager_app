import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/auth_screen/splash_screen.dart';
import 'package:taskmanager/ui/utility/app_colors.dart';


class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>() ;
  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(),
      home: const Scaffold(body: SplashScreen()),
    );
  }

  ThemeData lightThemeData() {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
        textTheme: const TextTheme(
            titleLarge: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
            titleSmall: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                letterSpacing: 0.4)),

        elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeColor,
          foregroundColor: AppColors.whiteColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
          fixedSize: const Size.fromWidth(double.maxFinite),
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style:  TextButton.styleFrom(
          foregroundColor: Colors.grey,
               textStyle: TextStyle(fontWeight: FontWeight.w600),
        )
      )
    );
  }
}
