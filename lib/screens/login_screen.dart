import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/colors.dart';

import '../repository/auth_repository.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void _signInWithGoogle(WidgetRef ref) {
    ref.read(authRepositoryProvider).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton.icon(
            onPressed: () => _signInWithGoogle(ref),
            icon: Image.asset(
              'assets/images/g-logo-2.png',
              height: 20,
            ),
            label: const Text(
              "Login with Google",
              style: TextStyle(
                color: kBlackColor,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: kWhiteColor,
              minimumSize: const Size(150, 50),
            ),
          ),
        ),
      ),
    );
  }
}

