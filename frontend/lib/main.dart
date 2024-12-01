import 'package:flutter/material.dart';
import 'package:frontend/screens/ride_detail.dart';
import 'screens/signup.dart';
import 'screens/phone_verification.dart';
import 'screens/set_password.dart';
import 'screens/profile_setup.dart';
import 'screens/login.dart';
import 'screens/welcome.dart';
import 'screens/verification_screen.dart';
import 'screens/offer_ride.dart';
import 'screens/find_ride.dart';
import 'screens/ride_list.dart';
import 'screens/welcome_clicked.dart';
import 'screens/driver_profile.dart';

void main() {
  runApp(MaterialApp(
    home: DriverProfilePage(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Waggalni Maak',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF5C5C),
        hintColor: const Color(0xFFFF5C5C),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black), // Replaces headline1
          bodyLarge: TextStyle(
              fontSize: 16, color: Colors.black), // Replaces bodyText1
          bodyMedium: TextStyle(
              fontSize: 14, color: Color(0xFF8A8A8A)), // Replaces bodyText2
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF8F8F8),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFB8B8B8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFFF5C5C), width: 2),
          ),
          hintStyle: const TextStyle(color: Color(0xFFB8B8B8)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF5C5C),
            minimumSize: const Size(double.infinity, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      initialRoute: '/signup',
      routes: {
        '/signup': (context) => SignUpScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/phoneVerification': (context) => PhoneVerificationScreen(),
        '/setPassword': (context) => SetPasswordScreen(),
        '/profileSetup': (context) => ProfileSetupScreen(),
        '/login': (context) => LoginScreen(),
        '/verification_screen': (context) =>
            VerificationScreen(), // Add VerificationScreen route
        '/OfferRidePage': (context) => OfferRidePage(),
        '/FindRidePage': (context) => FindRidePage(),
      },
    );
  }
}
