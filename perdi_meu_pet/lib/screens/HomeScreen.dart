import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/widgets/PostWidget.dart';
import 'package:perdi_meu_pet/models/Post.dart';
import 'package:perdi_meu_pet/models/Usuario.dart';
import 'package:provider/provider.dart';
import 'package:perdi_meu_pet/usuario_provider.dart';

// Mock de dados
final List<Post> mockPosts = [
  Post(
    nome: 'Mia',
    descricao: 'Gatinha branca e muito carinhosa, desapareceu ontem.',
    localizacao: 'Bairro Jardim Paulista',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpiJmZoJ_y-zMy5ke5RAw14AZj9dIREUxFCA&s',
  ),
  Post(
    nome: 'Simba',
    descricao:
        'Gato laranja, adora brincar na rua. Foi visto pela última vez perto da praça.',
    localizacao: 'Bairro Pinheiros',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_tk6y1IbTI65cDl8Us1qcnRY_XUj1iMfr1w&s',
  ),
  Post(
    nome: 'Luna',
    descricao:
        'Gata cinza, muito tímida. Por favor, ajude-nos a encontrá-la!',
    localizacao: 'Centro',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRK_iz_E5w6MEQwWr9Sx4nfK7yW_F4saX4wg&s',
  ),
];

// Tela principal com TabBarView
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('FindMyPet'),
          backgroundColor: Colors.teal,
          actions: [
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileTab(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                children: [
                  FeedTab(),
                  usuarioProvider.isLoggedIn ? AddPostTab() : Center(child: Text('Faça login para adicionar um post.')),
                  usuarioProvider.isLoggedIn ? FavoritesTab() : Center(child: Text('Faça login para ver favoritos.')),
                ],
              ),
            ),
            Container(
              color: Colors.teal,
              child: const TabBar(
                indicatorColor: Colors.amber,
                labelColor: Colors.amber,
                unselectedLabelColor: Colors.white60,
                tabs: [
                  Tab(icon: Icon(Icons.pets), text: 'Feed'),
                  Tab(icon: Icon(Icons.add), text: 'Adicionar'),
                  Tab(icon: Icon(Icons.favorite), text: 'Favoritos'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Widget de feed que usa o mock de posts
class FeedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: mockPosts.length,
      itemBuilder: (context, index) {
        return PostWidget(post: mockPosts[index]);
      },
    );
  }
}

class FavoritesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Seus posts favoritos aparecerão aqui.'));
  }
}

class AddPostTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Descrição do pet'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('Escolher imagem'),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {},
            child: Text('Publicar'),
          ),
        ],
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: usuarioProvider.isLoggedIn ? _buildUserProfile(usuarioProvider) : _buildLoginForm(usuarioProvider),
      ),
    );
  }

  Widget _buildLoginForm(UsuarioProvider usuarioProvider) {
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
            onPressed: () {
              usuarioProvider.login(emailController.text, senhaController.text);
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile(UsuarioProvider usuarioProvider) {
    Usuario usuario = usuarioProvider.usuario!; // Obter usuário

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          child: Icon(Icons.person, size: 50),
        ),
        SizedBox(height: 10),
        Text(usuario.nome, style: TextStyle(fontSize: 20)),
        Text(usuario.email, style: TextStyle(color: Colors.grey)),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            usuarioProvider.logout(); // Chama o método de logout
             // Volta para a tela anterior
          },
          child: Text('Sair'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Cor do botão
          ),
        ),
      ],
    );
  }
}
