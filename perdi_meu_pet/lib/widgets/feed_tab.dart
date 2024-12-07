import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/domain/model/post.dart';
import 'package:perdi_meu_pet/domain/service/post_service.dart';
import '../screens/home_screen.dart';
import '../widgets/post_widget.dart';
import '../screens/post_detail_screen.dart'; // Importa a tela de detalhes

class FeedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Usando FutureBuilder para lidar com a busca assíncrona de postagens
    return FutureBuilder<Map<String, Post>>(
      future: PostService.getPosts(), // Fetch posts using the PostService
      builder: (context, snapshot) {
        // Checa estado da conexão
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child:
                  CircularProgressIndicator()); // Mostrar indicador de carregamento durante a busca
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
                  'Erro: ${snapshot.error}')); // Mostrar erro se a busca falhar
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Text(
                  'Nenhum post encontrado.')); // Mostrar mensagem se nenhuma postagem for encontrada
        }

        // Depois que os dados forem carregados, extrai as postagens do mapa
        final posts = snapshot.data!.values.toList();

        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];

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
      },
    );
  }
}
