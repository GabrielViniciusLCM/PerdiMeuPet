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
      future: PostService.getPosts(), // Obtém as postagens através do serviço
      builder: (context, snapshot) {
        // Checa estado da conexão
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()); // Indicador de carregamento
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Text(
                  'Nenhum post encontrado.')); // Exibe mensagem quando não houver dados
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
                  'Erro: ${snapshot.error}')); // Exibe erro se a busca falhar
        }

        // Extrai as postagens do mapa retornado
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
                  // Atualiza a UI quando o status de favorito do post muda
                  // Você pode adicionar lógica aqui para salvar no banco de dados ou em estado local
                  (context as Element)
                      .markNeedsBuild(); // Reconstroi a interface
                },
              ),
            );
          },
        );
      },
    );
  }
}
