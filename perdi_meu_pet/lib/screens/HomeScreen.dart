import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/widgets/PostWidget.dart';
import 'package:perdi_meu_pet/models/Post.dart';

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
                // Show profile
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
                children: [FeedTab(), AddPostTab(), FavoritesTab()],
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 10),
            Text('Nome do Usuário', style: TextStyle(fontSize: 20)),
            Text('usuario@email.com', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
