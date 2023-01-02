import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/constants.dart';
import 'package:google_docs/models/error_model.dart';
import 'package:google_docs/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

import 'local_storage_repository.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(googleSignIn: GoogleSignIn(), client: Client(), localStorageRepository: LocalStorageRepository()),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  final LocalStorageRepository _localStorageRepository;

  AuthRepository({required GoogleSignIn googleSignIn, required Client client, required LocalStorageRepository localStorageRepository})
      : _googleSignIn = googleSignIn,
        _client = client,
        _localStorageRepository = localStorageRepository;

  Future<ResponseModel> signInWithGoogle() async {
    ResponseModel responseModel = ResponseModel(msg: "Something went wrong", data: null);

    try {
      final user = await _googleSignIn.signIn();

      if (user != null) {
        UserModel userAccount = UserModel(name: user.displayName!, email: user.email, profilePicture: user.photoUrl ?? "https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg", token: '', uid: '');

        var response = await _client.post(
            Uri.parse(
              signup(userAccount),
            ),
            body: jsonEncode(userAccount),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            });

        dynamic responseData = jsonDecode(response.body);

        switch (response.statusCode) {
          case 200:
            final newUser = userAccount.copyWith(
              uid: UserModel.fromJson(responseData['user']).uid,
              token: responseData['token'],
            );
            responseModel = ResponseModel(msg: "Success", data: newUser);
            _localStorageRepository.setToken(responseData['token']);
            break;
        }
      }
    } catch (e) {
      print(e);
      responseModel = ResponseModel(msg: e.toString(), data: null);
    }

    return responseModel;
  }

  Future<ResponseModel> getUserData() async {
    ResponseModel responseModel = ResponseModel(msg: "No User found", data: null);

    try {
      String? token = await _localStorageRepository.getToken();

      if (token != null) {
        var response = await _client.get(Uri.parse(kHost), headers: {
          "Content-Type": "application/json; Charset=UTF-8",
          'x-auth-token': token,
        });

        dynamic responseData = jsonDecode(response.body);

        switch (response.statusCode) {
          case 200:
            final newUser = UserModel.fromJson(responseData['user']).copyWith(token: token);
            responseModel = ResponseModel(msg: "Success", data: newUser);
            _localStorageRepository.setToken(responseData['token']);
            break;
        }
      }
    } catch (e) {
      print(e);
      responseModel = ResponseModel(msg: e.toString(), data: null);
    }

    return responseModel;
  }

  void signOut() async {
    await _googleSignIn.signOut();
    _localStorageRepository.setToken("");
  }
}
