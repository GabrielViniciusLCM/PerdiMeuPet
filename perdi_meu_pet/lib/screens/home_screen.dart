import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/domain/service/post_service.dart';
import 'package:provider/provider.dart';

import '../domain/model/post.dart';
import '../domain/provider/user_provider.dart';
import '../widgets/add_post_tab.dart';
import '../widgets/favorites_tab.dart';
import '../widgets/feed_tab.dart';

// Mock de dados
final Future<Map<String, Post>> loadedPosts = PostService.getPosts();

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