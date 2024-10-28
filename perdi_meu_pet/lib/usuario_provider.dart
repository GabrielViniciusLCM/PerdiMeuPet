import 'package:flutter/material.dart';
import 'models/Usuario.dart';

class UsuarioProvider with ChangeNotifier {
  Usuario? _usuario;

  // Lista de usuários mockados com senhas
  final List<Usuario> _usuariosMockados = [
    Usuario(id: '1', nome: 'Nome do Usuário 1', email: 'usuario1@email.com', telefone: '123456789', senha: 'senha1'),
    Usuario(id: '2', nome: 'Nome do Usuário 2', email: 'usuario2@email.com', telefone: '987654321', senha: 'senha2'),
    // Adicione mais usuários conforme necessário
  ];

  Usuario? get usuario => _usuario;

  void login(String email, String senha) {
    // Verifica se o email está na lista de usuários mockados
    final usuarioMockado = _usuariosMockados.firstWhere(
      (usuario) => usuario.email == email,
      orElse: () => Usuario(id: '', nome: '', email: '', telefone: '', senha: ''),
    );

    // Verifica se a senha corresponde
    if (usuarioMockado.senha == senha) {
      _usuario = usuarioMockado;
      notifyListeners();
    } else {
      // Aqui você pode adicionar lógica para tratar falhas de login
      print('Login falhou: usuário não encontrado ou senha incorreta.');
    }
  }

  void logout() {
    _usuario = null;
    notifyListeners();
  }

  bool get isLoggedIn => _usuario != null;
}
