import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/utils/app_routes.dart';
import 'package:provider/provider.dart';
import '../domain/provider/user_provider.dart';
import '../widgets/add_post_tab.dart';
import '../widgets/favorites_tab.dart';
import '../widgets/feed_tab.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UserProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white), // Set drawer icon color to white
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
                Navigator.of(context).pushNamed(AppRoutes.PROFILE);
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
                      Navigator.of(context).pushNamed(AppRoutes.MY_PETS);
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