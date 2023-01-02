class UserModel{
  final String? name;
  final String? email;
  final String? profilePicture;
  final String? uid;
  final String? token;

  UserModel({this.name, this.email, this.profilePicture, this.uid, this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      uid: json['_id'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'profilePicture': profilePicture,
    '_id': uid,
    'token': token,
  };

  UserModel copyWith({
    String? name,
    String? email,
    String? profilePicture,
    String? uid,
    String? token,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      uid: uid ?? this.uid,
      token: token ?? this.token,
    );
  }

}