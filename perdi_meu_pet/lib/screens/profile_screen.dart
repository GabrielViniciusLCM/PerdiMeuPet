import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/model/user.dart';
import '../domain/provider/user_provider.dart';
import 'register_screen.dart';

class ProfileScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        backgroundColor: Colors.teal,
      ),
      body: Center(child: usuarioProvider.isLoggedIn ? _buildUserProfile(usuarioProvider) : _buildLoginForm(usuarioProvider, context),
      ),
    );
}
  Widget _buildLoginForm(UserProvider usuarioProvider, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: senhaController,
            decoration: InputDecoration(labelText: 'Senha'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async  {
              await usuarioProvider.login(emailController.text, senhaController.text);
            },
            child: Text('Login'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterScreen(),
                ),
              );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ProfileTab(),
              //   ),
              // );
            },
            child: Text('Registrar'),
          ),
        ],
      ),
    );
  }
  Widget _buildUserProfile(UserProvider usuarioProvider) {
    final user = usuarioProvider.user!; // Obter usuário
    // // var usuario = UserProvider().user;
    // final name = usuario == null ? 'Nome' : usuario.username;
    // final email = usuario == null ? 'Email' : usuario.email;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          child: Icon(Icons.person, size: 50),
        ),
        SizedBox(height: 10),
        Text(user.username, style: TextStyle(fontSize: 20)),
        Text(user.email, style: TextStyle(color: Colors.grey)),
        SizedBox(height: 20),
        // ElevatedButton(
        //   onPressed: () {
        //     usuarioProvider.logout(); // Chama o método de logout
        //      // Volta para a tela anterior
        //   },
        //   child: Text('Sair'),
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.red, // Cor do botão
        //   ),
        // ),
      ],
    );
  }
}
