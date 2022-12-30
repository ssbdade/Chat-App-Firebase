class UserModel{

  final String? userId;
  final String? profileName;
  final String? fullName;
  final String? avatarUrl;
  final String? email;
  final List<UserModel>? friends;

  UserModel(
       {
    this.userId,
    this.profileName,
    this.fullName,
    this.avatarUrl,
    this.email,
         this.friends,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      userId: map['userId'],
      profileName: map['profileName'],
      fullName: map["fullName"],
      avatarUrl: map["avatarUrl"],
      email: map['email'],
      friends: map['friends'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'profileName': profileName,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'email': email,
      'friends': friends,
    };
  }
}