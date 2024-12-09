import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/model/post.dart';
import '../domain/provider/post_provider.dart';
import '../domain/provider/user_provider.dart';
import '../widgets/post_widget.dart';
import 'register_screen.dart';

class ProfileScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UserProvider>(context);
    final postProvider = Provider.of<PostProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        backgroundColor: Colors.teal,
        actions: usuarioProvider.isLoggedIn
            ? [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    usuarioProvider.logout();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Você deslogou com sucesso!')),
                    );
                  },
                ),
              ]
            : null,
      ),
      body: usuarioProvider.isLoggedIn
          ? _buildUserProfile(usuarioProvider, postProvider)
          : _buildLoginForm(usuarioProvider, context),
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
            onPressed: () async {
              try {
                await usuarioProvider.login(
                    emailController.text, senhaController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Login realizado com sucesso!')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Erro ao realizar login: $e')),
                );
              }
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
            },
            child: Text('Registrar'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile(UserProvider usuarioProvider, PostProvider postProvider) {
    final user = usuarioProvider.user;

    return Column(
      children: [
        // User Profile Header
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              SizedBox(height: 10),
              Text(user.username, style: TextStyle(fontSize: 20)),
              Text(user.email, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        Divider(),
        // User Posts List
        Expanded(
          child: FutureBuilder<Map<String, Post>>(
            future: postProvider.getUserPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erro: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('Você ainda não fez nenhum post.'));
              }

              final userPosts = snapshot.data!;
              return ListView.builder(
                itemCount: userPosts.length,
                itemBuilder: (context, index) {
                  final postEntry = userPosts.entries.elementAt(index);

                  return PostWidget(
                    postMapEntry: postEntry,
                    onFavoriteToggled: () {
                      // Allow liking/unliking own posts
                      usuarioProvider.toggleFavorite(postEntry.key);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
