import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import 'post_widget.dart';
import '../screens/post_detail_screen.dart'; // Importa a tela de detalhes

class FavoritesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritePosts = mockPosts.where((post) => post.isFavorite).toList();

    if (favoritePosts.isEmpty) {
      return Center(child: Text('Nenhum post favoritado.'));
    }

    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: favoritePosts.length,
      itemBuilder: (context, index) {
        final post = favoritePosts[index];

        return GestureDetector(
          onTap: () {
            // Navega para a tela de detalhes do post
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailScreen(post: post),
              ),
            );
          },
          child: PostWidget(
            post: post,
            onFavoriteToggled: () {
              // Aciona a atualização da UI quando o status de favorito de um post muda
              (context as Element).markNeedsBuild();
            },
          ),
        );
      },
    );
  }
}
