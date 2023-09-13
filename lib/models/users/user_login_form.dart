class UserLoginForm{
  String email;
  String password;

  UserLoginForm({
    required this.email, 
    required this.password
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}