class UserModel {
  String name;
  String email;
  String password;
  String createdAt;
  String userId;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'email': this.email,
      'password': this.password,
      'creatAt': this.createdAt,
      'userId': this.userId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      createdAt: map['createdAt'] as String,
      userId: map['userId'] as String,
    );
  }
}
