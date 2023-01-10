class UserModel{

  String? userId;
  String? fullName;
  String? avatarUrl;
  String? email;

  UserModel(
       {
    this.userId,
    this.fullName,
    this.avatarUrl,
    this.email,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      userId: map['userId'],
      fullName: map["fullName"],
      avatarUrl: map["avatarUrl"],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'email': email,
    };
  }
}