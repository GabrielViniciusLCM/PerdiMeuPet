import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/model/post.dart';
import '../domain/provider/user_provider.dart';

import '../widgets/add_post_tab.dart';
import '../widgets/favorites_tab.dart';
import '../widgets/feed_tab.dart';
import 'my_pet_screen.dart';

// Mock de dados

// // Mock Data
// final List<Pet> mockPets = [
//   Pet(
//     name: "Mia",
//     userId: "-OD89mi15TmBh3yH0mWJ",
//     breed: "Persian",
//     age: "2",
//     description: "A cute white cat, very playful.",
//     imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpiJmZoJ_y-zMy5ke5RAw14AZj9dIREUxFCA&s",
//   ),
//   Pet(
//     name: "Simba",
//     userId: "123456",
//     breed: "Tabby",
//     age: "3",
//     description: "An adventurous orange cat.",
//     imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_tk6y1IbTI65cDl8Us1qcnRY_XUj1iMfr1w&s",
//   ),
// ];

final List<Post> mockPosts = [
  Post(
    // nome: 'Mia',
    descricao:  'Gatinha branca e muito carinhosa, desapareceu ontem.',
    localizacao:'Bairro Jardim Paulista',
    imageUrl:   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpiJmZoJ_y-zMy5ke5RAw14AZj9dIREUxFCA&s',
    userId:    '123456',
    petId:     '654321',
  ),
  Post(
    // nome: 'Simba',
    descricao:  'Gato laranja, adora brincar na rua. Foi visto pela última vez perto da praça.',
    localizacao:'Bairro Pinheiros',
    imageUrl:   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_tk6y1IbTI65cDl8Us1qcnRY_XUj1iMfr1w&s',
    userId:     '123456',
    petId:      '654321',
  ),
  Post(
    // nome: 'Luna',
    descricao:  'Gata cinza, muito tímida. Por favor, ajude-nos a encontrá-la!',
    localizacao:'Centro',
    imageUrl:   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRK_iz_E5w6MEQwWr9Sx4nfK7yW_F4saX4wg&s',
    userId:     '123456',
    petId:      '654321',
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
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.pets, size: 48, color: Colors.amber),
                    SizedBox(height: 8),
                    Text(
                      "Perdi Meu Pet",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              if (usuarioProvider.isLoggedIn)
                  ListTile(
                    leading: const Icon(Icons.pets),
                    title: const Text("My Pets"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyPetsScreen(),
                      ));
                    },
                  ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),
                onTap: () {
                  // Close the drawer first
                  Navigator.of(context).pop();
                  // Navigator.of(context).pushNamed(AppRoutes.SETTINGS);
                  // Cria um SnackBar para mostrar uma mensagem de que ainda não há uma tela de configurações
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Configurações ainda não implementadas.')),
                  );
                },
              ),
            ],
          ),
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