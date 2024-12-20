// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/domain/service/user_service.dart';
import '../model/user.dart';
class UserProvider with ChangeNotifier {
  MapEntry<String, User> _user = MapEntry('', User(username: 'username', email: 'user@email.com', phone: '84999999999', password: 'password'));

  User get user => this._user.value;

  String get userId => this._user.key;

  Future<void> login(String email, String pass) async {
    try {
      // Tenta buscar o usuário pelo email
      final user = await UserService.getUserByEmail(email);

      // Verifica se a senha está correta
      if (user.value.password == pass) {
        this._user = user; // Preenche _user se o login for bem-sucedido
        notifyListeners(); // Notifica os ouvintes sobre a mudança de estado
      } else {
        throw Exception('Senha incorreta');
      }
    } catch (error) {
      rethrow; // Propaga o erro para ser tratado onde o método for chamado
    }
  }

  Future<void> _removeFavoritePost(String postId) async {
    try {
      this._user.value.favoritePosts.remove(postId);
      await UserService.updateUser(this._user);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _addFavoritePost(String postId) async {
    try {
      this._user.value.favoritePosts.add(postId);
      await UserService.updateUser(this._user);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> toggleFavorite(String postId) async {
    if (this._user.value.favoritePosts.contains(postId)) {
      await this._removeFavoritePost(postId);
      notifyListeners();  
    } else {
      await this._addFavoritePost(postId);
      notifyListeners();
    }
  }

  bool isPostFavorite(String postId) {
    return this._user.value.favoritePosts.contains(postId);
  }
  
  void logout() {
    this._user = MapEntry('', User(username: 'username', email: 'user@email.com', phone: '84999999999', password: 'password'));
    notifyListeners();
  }
  bool get isLoggedIn => this._user.key.isNotEmpty;
}