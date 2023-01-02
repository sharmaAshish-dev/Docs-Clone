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
        title: json['title'],
        uid: json['uid'],
        content: List.from(json['content']),
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
        id: json['_id'],
      );

  String toJson() => json.encode(toMap());

  factory DocumentModel.fromJson(String source) => DocumentModel.fromMap(json.decode(source));
}
