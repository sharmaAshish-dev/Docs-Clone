import 'dart:convert';

class DocumentModel {
  final String title;
  final String uid;
  final List content;
  final DateTime createdAt;
  final String id;

  DocumentModel({required this.title, required this.uid, required this.content, required this.createdAt, required this.id});

  Map<String, dynamic> toMap() => {
        'title': title,
        'uid': uid,
        'content': content,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'id': id,
      };

  factory DocumentModel.fromMap(Map<String, dynamic> json) => DocumentModel(
        title: json["document"]['title'] ?? "",
        uid: json["document"]['uid'] ?? "",
        content: List.from(json["document"]['content'] ?? []),
        createdAt: DateTime.fromMillisecondsSinceEpoch(json["document"]['createdAt']),
        id: json["document"]['_id'] ?? "",
      );

  String toJson() => json.encode(toMap());

  factory DocumentModel.fromJson(String source) => DocumentModel.fromMap(json.decode(source));
}
