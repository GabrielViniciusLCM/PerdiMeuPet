import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/domain/model/post.dart';
import 'package:perdi_meu_pet/domain/provider/post_provider.dart';
import 'package:provider/provider.dart';
import 'post_widget.dart';
import '../screens/post_detail_screen.dart'; // Importa a tela de detalhes

class FavoritesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Usando o FutureBuilder para lidar com a busca assíncrona de postagens
    return FutureBuilder<Map<String, Post>>(
      // future: Provider.of<PostProvider>(context, listen: false).getFavoritePosts(),
      future: Provider.of<PostProvider>(context, listen: false).getFavoritePosts(),
      builder: (context, snapshot) {
        // Checa o estado da conexão
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Mostrar indicador de carregamento durante a busca
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhum post favoritado.')); // Mostrar mensagem se nenhuma postagem for encontrada
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}')); // Mostrar erro se a busca falhar
        }

        // Depois que os dados forem carregados, extrai as postagens do mapa
        final favoritePosts = snapshot.data!;

        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: favoritePosts.length,
          itemBuilder: (context, index) {
            final postMapEntry = favoritePosts.entries.elementAt(index);

            return GestureDetector(
              onTap: () {
                // Navega para a tela de detalhes do post
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailScreen(postMapEntry: postMapEntry),
                  ),
                );
              },
              child: PostWidget(
                postMapEntry: postMapEntry,
                onFavoriteToggled: () {
                  // Aciona a atualização da UI quando o status de favorito de um post muda
                  (context as Element).markNeedsBuild();
                },
              ),
            );
          },
        );
      },
    );
  }
}
