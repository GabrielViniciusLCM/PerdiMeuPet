import 'dart:convert';

import '../../utils/urls.dart';
import '../model/post.dart';
import '../model/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<Map<String, User>> addUser(User user) async {
    final response = await http.post(
      Uri.parse('${Urls.BASE_URL}/users.json'),
      body: json.encode(user),
    );

    if (response.statusCode == 200) {
      final id = json.decode(response.body)['name'];
      final Map<String, User> userMap = {id: user};
      return userMap;
    } else {
      throw Exception('Erro ao cadastrar usuário');
    }
  }
  
  // Função para buscar o nome do usuário com base no ID
  static Future<String> getUserNameById(String userId) async {
    try {
      Map<String, User> userMap = await UserService._getUserById(userId);
      User user = userMap[userId]!;

      return user.username;
    } catch (e) {
      throw Exception('Erro ao buscar nome do usuário: $e');
    }
  }

  static Future<MapEntry<String, User>> getUserByEmail(String email) async {
    final users = await _getUsers();

    return users.entries.firstWhere(
      (entry) => entry.value.email == email,
      orElse: () => throw Exception('Usuário não encontrado'),
    );
  }

  static Future<Map<String, User>> _getUsers() async {
    final response = await http.get(Uri.parse('${Urls.BASE_URL}/users.json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, User> userMap = {};
      data.forEach((key, value) {
        userMap[key] = User.fromJson(value);
      });
      return userMap;
    } else {
      throw Exception('Erro ao buscar usuários');
    }
  }

  static Future<Map<String, User>> _getUserById(String id) async {
    final response =
        await http.get(Uri.parse('${Urls.BASE_URL}/users/$id.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      // this._userMap[id] = User.fromJson(data
      final Map<String, User> userMap = {id: User.fromJson(data)};

      return userMap;
    } else {
      throw Exception('Erro ao buscar usuário');
    }
  }
}
