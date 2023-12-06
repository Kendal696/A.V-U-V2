class UserNLP {
  String name;
  String lastName;
  String email;
  String password;
  UserNLP(
      {this.name = '',
      this.lastName = '',
      this.email = '',
      this.password = ''});

  factory UserNLP.fromMap(Map<String, dynamic> user) => UserNLP(
      name: user['name'], lastName: user['last_name'], email: user['email']);

  static Map<String, dynamic> toJSON(UserNLP user) {
    return {
      "name": user.name,
      "last_name": user.lastName,
      "email": user.email,
    };
  }
}
