import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/colors.dart';
import 'package:google_docs/repository/document_repository.dart';
import 'package:google_docs/utility.dart';
import 'package:routemaster/routemaster.dart';

import '../models/error_model.dart';
import '../repository/auth_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void signOut(WidgetRef ref) {
    ref.read(authRepositoryProvider).signOut();
    ref.read(userProvider.notifier).update((state) => null);
  }

  void createDocument(BuildContext context, WidgetRef ref) async {
    String token = ref.read(userProvider)!.token ?? "";
    final navigator = Routemaster.of(context);
    final snackbar = ScaffoldMessenger.of(context);

    ResponseModel response = await ref.read(documentRepositoryProvider).createDocument(token);

    if (response.data != null) {
      navigator.push("/document/${response.data!.id}");
    } else {
      showSnackBar(snackbar, txt: response.msg);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async => createDocument(context, ref),
            icon: const Icon(Icons.add, color: kBlackColor),
          ),
          IconButton(
            onPressed: () => signOut(ref),
            icon: const Icon(Icons.logout, color: kRedColor),
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Text(ref.watch(userProvider)?.name ?? "No user"),
        ),
      ),
    );
  }
}
