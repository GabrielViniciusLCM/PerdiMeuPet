import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/screens/HomeScreen.dart';
import 'package:perdi_meu_pet/widgets/PostWidget.dart';

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
        return PostWidget(
          post: favoritePosts[index],
          onFavoriteToggled: () {
            // Aciona a atualização da UI quando o status de favorito de um post muda
            (context as Element).markNeedsBuild();
          },
        );
      },
    );
  }
}
