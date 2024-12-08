// ignore_for_file: unnecessary_this
class User {
  final String username;
  final String email;
  final String phone;
  final String password;
  final List<String> favoritePosts; // List of post ids
  
  User({
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    this.favoritePosts = const [],
  }):assert(username.isNotEmpty),
    assert(email.isNotEmpty),
    assert(phone.isNotEmpty),
    assert(password.isNotEmpty),
    assert(username.length >= 5),
    assert(password.length >= 5),
    assert(phone.length >= 11),
    assert(RegExp(r'^\d+$').hasMatch(phone)), // Check for digits only
    assert(email.contains('@')),
    assert(email.endsWith('.com'));

  User.fromJson(Map<String, dynamic> json): 
    this.username       = json['username'],
    this.email          = json['email'],
    this.phone          = json['phone'],
    this.password       = json['password'],
    this.favoritePosts  = List<String>.from(json['favoritePosts'] ?? []);

  Map<String, dynamic> toJson() {
    return {
      'username':       this.username,
      'email':          this.email,
      'phone':          this.phone,
      'password':       this.password,
      'favoritePosts':  this.favoritePosts,
    };
  }

  @override
  String toString() {
    return '''User(
    \n\tusername: $username, 
    \n\temail: $email, 
    \n\tphone: $phone,
    \n\tpassword: $password,
    \n\tfavoritePosts: $favoritePosts
    \n)''';
  }
}