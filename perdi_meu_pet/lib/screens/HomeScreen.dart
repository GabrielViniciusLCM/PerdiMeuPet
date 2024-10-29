import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/models/Post.dart';
import 'package:perdi_meu_pet/widgets/AddPostTab.dart';
import 'package:perdi_meu_pet/widgets/FavoritesTab.dart';
import 'package:perdi_meu_pet/widgets/FeedTab.dart';
import 'package:perdi_meu_pet/widgets/ProfileTab.dart';

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
            ),
          ],
        ),
      ),
    );
  }
}