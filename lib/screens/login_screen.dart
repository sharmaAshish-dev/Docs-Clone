import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/colors.dart';
import 'package:google_docs/utility.dart';
import 'package:routemaster/routemaster.dart';

import '../repository/auth_repository.dart';
import 'home_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void _signInWithGoogle(WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(ref.context);
    final navigator = Routemaster.of(ref.context);
    final response = await ref.read(authRepositoryProvider).signInWithGoogle();

    if (response.msg == "Success" && response.data != null) {
      ref.read(userProvider.notifier).update((state) => response.data!);
      navigator.replace('/');
    } else {
      showSnackBar(messenger, txt: response.msg);
    }
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
