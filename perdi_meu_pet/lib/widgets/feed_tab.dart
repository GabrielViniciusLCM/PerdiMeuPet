import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/provider/post_provider.dart';
import '../widgets/post_widget.dart';
import '../screens/post_detail_screen.dart'; // Importa a tela de detalhes

class FeedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postsProvider = Provider.of<PostProvider>(context);
    postsProvider.getPosts(); // Busca os posts
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: postsProvider.posts.length,
      itemBuilder: (context, index) {
        final post = postsProvider.posts.values.elementAt(index);
        
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
