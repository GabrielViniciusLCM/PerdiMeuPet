import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/model/post.dart';
import '../domain/provider/user_provider.dart';
import '../widgets/add_post_tab.dart';
import '../widgets/favorites_tab.dart';
import '../widgets/feed_tab.dart';

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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UserProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(Icons.pets, color: Colors.amber), // Ícone de pata
              SizedBox(width: 8),
              Text(
                'Perdi Meu Pet',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Arial', // Alteração na fonte
                  color: Colors.amber, // Mesma cor do ícone
                ),
              ),
            ],
          ),
          backgroundColor: Colors.teal,
          actions: [
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ProfileTab(),
                //   ),
                // );
                Navigator.of(context).pushNamed('/profile');
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
            ),
          ],
        ),
      ),
    );
  }
}