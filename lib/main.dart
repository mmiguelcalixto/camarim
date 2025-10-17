//import 'package:camarim_backend/firebase_options.dart';
//import 'package:camarim_backend/pages/professional_pages/prof_horarios_page.dart';
import 'package:camarim_backend/pages/splash_screen.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camarim',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Montserrat', // essa linha aplica a fonte em tudo
        textTheme: ThemeData.light().textTheme.copyWith(
          displayLarge: const TextStyle(fontWeight: FontWeight.w700),
          displayMedium: const TextStyle(fontWeight: FontWeight.w700),
          displaySmall: const TextStyle(fontWeight: FontWeight.w700),
          headlineLarge: const TextStyle(fontWeight: FontWeight.w600),
          headlineMedium: const TextStyle(fontWeight: FontWeight.w600),
          headlineSmall: const TextStyle(fontWeight: FontWeight.w600),
          titleLarge: const TextStyle(fontWeight: FontWeight.w600),
          titleMedium: const TextStyle(fontWeight: FontWeight.w600),
          titleSmall: const TextStyle(fontWeight: FontWeight.w600),
          bodyLarge: const TextStyle(fontWeight: FontWeight.w500),
          bodyMedium: const TextStyle(fontWeight: FontWeight.w400),
          bodySmall: const TextStyle(fontWeight: FontWeight.w300),
          labelLarge: const TextStyle(fontWeight: FontWeight.w600),
          labelMedium: const TextStyle(fontWeight: FontWeight.w500),
          labelSmall: const TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}