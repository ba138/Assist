class UserModel {
  final String name;
  final String uid;
  final String profilePic;

  final String email;

  UserModel({
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.email,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'email': email,
    };
  }

  factory UserModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return UserModel(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      profilePic: map['profilePic'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
