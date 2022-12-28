class UserModel{

  final String? userId;
  final String? profileName;
  final String? fullName;
  final String? avatarUrl;
  final String? email;

  UserModel({
    this.userId,
    this.profileName,
    this.fullName,
    this.avatarUrl,
    this.email,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      userId: map['userId'],
      profileName: map['profileName'],
      fullName: map["fullName"],
      avatarUrl: map["avatarUrl"],
      email: map['email']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'profileName': profileName,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'email': email,
    };
  }
}