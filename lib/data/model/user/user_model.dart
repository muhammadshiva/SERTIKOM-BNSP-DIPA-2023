class UserModel {
  final int? id;
  final String fullName;
  final String username;
  final String email;
  final String password;
  final int balance;

  UserModel({
    this.id,
    required this.fullName,
    required this.username,
    required this.email,
    required this.password,
    required this.balance,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['fullName'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      balance: map['balance'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'username': username,
      'email': email,
      'password': password,
      'balance': balance,
    };
  }
}
