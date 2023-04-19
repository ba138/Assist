import 'package:assist/auth/controller/auth_controller.dart';
import 'package:assist/auth/screens/login_screen.dart';
import 'package:assist/openAI/screens/home_page.dart';
import 'package:assist/utills/loader_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pallete.dart';
import 'utills/error_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Pallete.whiteColor,
          appBarTheme: const AppBarTheme(backgroundColor: Pallete.whiteColor)),
      home: ref.watch(userProvider).when(
            data: (user) {
              if (user == null) {
                return const LoginScreen();
              } else {
                return const HomePage();
              }
            },
            error: (err, trace) {
              return ErrorScreen(error: err.toString());
            },
            loading: () => const Loader(),
          ),
    );
  }
}
