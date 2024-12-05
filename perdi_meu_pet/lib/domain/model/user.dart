// ignore_for_file: unnecessary_this
class User {
  final String username;
  final String email;
  final String phone;
  final String password;
  
  User({
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
  }):assert(username.isNotEmpty),
    assert(email.isNotEmpty),
    assert(phone.isNotEmpty),
    assert(password.isNotEmpty),
    assert(username.length >= 5),
    assert(password.length >= 5),
    assert(phone.length >= 11),
    assert(email.contains('@')),
    assert(email.endsWith('.com'));

  User.fromJson(Map<String, dynamic> json): 
    this.username  = json['username'],
    this.email     = json['email'],
    this.phone     = json['phone'],
    this.password  = json['password'];

  Map<String, dynamic> toJson() {
    return {
      'username': this.username,
      'email':    this.email,
      'phone':    this.phone,
      'password': this.password,
    };
  }

  @override
  String toString() {
    return 'User(username: $username, email: $email, phone: $phone, password: $password)';
  }
}