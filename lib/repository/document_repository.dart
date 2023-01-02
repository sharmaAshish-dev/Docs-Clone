import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../constants.dart';
import '../models/document_model.dart';
import '../models/error_model.dart';

final documentRepositoryProvider = Provider((ref) => DocumentRepository(client: Client()));

class DocumentRepository {
  final Client _client;

  DocumentRepository({required Client client}) : _client = client;

  Future<ResponseModel> createDocument(String token) async {
    ResponseModel responseModel = ResponseModel(msg: "Something went wrong", data: null);

    try {
      var response = await _client.post(
        Uri.parse("${kHost}doc/create"),
        headers: {
          "Content-Type": "application/json; Charset=UTF-8",
          'x-auth-token': token,
        },
        body: jsonEncode({
          "createdAt": DateTime.now().millisecondsSinceEpoch,
        }),
      );

      switch (response.statusCode) {
        case 200:
          responseModel = ResponseModel(
            msg: "Success",
            data: DocumentModel.fromJson(
                response.body,
            ),
          );
          break;
          default:
            responseModel = ResponseModel(
              msg: response.body,
              data: null,
            );
      }
    } catch (e) {
      print(e);
      responseModel = ResponseModel(msg: e.toString(), data: null);
    }

    return responseModel;
  }
}
