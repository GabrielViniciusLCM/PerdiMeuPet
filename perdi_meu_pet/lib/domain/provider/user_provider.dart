// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/domain/service/user_service.dart';
import '../model/user.dart';
class UserProvider with ChangeNotifier {
  MapEntry<String, User>? _user;

  User? get user => this._user?.value;

  Future<void> login(String email, String pass) async {
    try {
      // Tenta buscar o usuário pelo username
      // final user = await UserService.getUserByUsername(username);
      final user = await UserService.getUserByEmail(email);

      // Verifica se a senha está correta
      if (user.value.password == pass) {
        this._user = user; // Preenche _user se o login for bem-sucedido
        // print('Usuário logado: ${this._user}');
        notifyListeners(); // Notifica os ouvintes sobre a mudança de estado
      } else {
        throw Exception('Senha incorreta');
      }
    } catch (error) {
      this._user = null; // Garante que _user fique null em caso de erro
      // notifyListeners(); // Notifica os ouvintes
      rethrow; // Propaga o erro para ser tratado onde o método for chamado
    }
  }
  
  void logout() {
    this._user = null;
    notifyListeners();
  }
  bool get isLoggedIn => this._user != null;
}