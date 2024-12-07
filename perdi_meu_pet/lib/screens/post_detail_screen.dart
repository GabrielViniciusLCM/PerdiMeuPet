import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/domain/model/comment.dart';
import 'package:perdi_meu_pet/domain/provider/user_provider.dart';
import 'package:perdi_meu_pet/domain/service/comment_service.dart';
import 'package:perdi_meu_pet/domain/service/pet_service.dart';
import 'package:perdi_meu_pet/domain/service/user_service.dart';
import 'package:provider/provider.dart';
import '../domain/model/post.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;

  PostDetailScreen({required this.post});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late Future<Map<String, Comment>> _commentsFuture;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Busca os comentários especificamente relacionados ao post atual
    _commentsFuture = CommentService.getCommentsByPostId(
        widget.post.id); // Obtém os comentários filtrados pelo postId
  }

  // Função para adicionar um novo comentário
  void _addComment() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (_commentController.text.isNotEmpty && userProvider.isLoggedIn) {
      Comment newComment = Comment(
        postId: widget.post.id, // Associa o comentário ao post específico
        content: _commentController.text,
        userId: userProvider.userId, // Usa o ID do usuário logado
      );

      try {
        // Adicionando o comentário através do serviço
        Map<String, Comment> newCommentMap =
            await CommentService.addComment(newComment);

        // Se o comentário for adicionado com sucesso, atualiza a interface
        setState(() {
          _commentsFuture = CommentService.getCommentsByPostId(widget
              .post.id); // Busca os comentários atualizados para este post
          _commentController.clear(); // Limpa o campo de texto
        });

        // Opcionalmente exibe uma mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Comentário adicionado com sucesso!')));
      } catch (e) {
        // Exibe uma mensagem de erro caso algo dê errado
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao adicionar comentário: $e')));
      }
    } else if (!userProvider.isLoggedIn) {
      // Se o usuário não estiver logado, exibe uma mensagem
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Você precisa estar logado para adicionar um comentário.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: PetService.getPetNameById(widget.post.petId), // Espera o nome do pet ser carregado
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('...');
            }

            if (snapshot.hasError) {
              return Text('Erro ao carregar nome do pet');
            }

            return Text(snapshot.data ?? 'Nome do pet');
          },
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  widget.post.imageUrl,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Descrição:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            SizedBox(height: 8),
            Text(
              widget.post.descricao,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Localização:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            SizedBox(height: 8),
            Text(
              widget.post.localizacao,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Divider(thickness: 1),
            Text(
              'Comentários:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            FutureBuilder<Map<String, Comment>>(
              future: _commentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhum comentário encontrado.'));
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar comentários.'));
                }

                final comments = snapshot.data!;

                return Expanded(
                  child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments.values.toList()[index];

                      // Chama o método para buscar o nome do usuário
                      return FutureBuilder<String>(
                        future: UserService.getUserNameById(comment
                            .userId), // Passando o ID do usuário do comentário
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ListTile(
                              leading: Icon(Icons.person, color: Colors.teal),
                              title: Text('...'),
                              subtitle: Text(comment.content),
                            );
                          }

                          if (userSnapshot.hasError) {
                            return ListTile(
                              leading: Icon(Icons.person, color: Colors.teal),
                              title: Text('Erro ao carregar nome do usuário'),
                              subtitle: Text(comment.content),
                            );
                          }

                          String userName =
                              userSnapshot.data ?? 'Usuário desconhecido';

                          return ListTile(
                            leading: Icon(Icons.person, color: Colors.teal),
                            title: Text(userName), // Nome do usuário
                            subtitle:
                                Text(comment.content), // Conteúdo do comentário
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
            Divider(thickness: 1),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    enabled: userProvider
                        .isLoggedIn, // Desabilita o campo de texto se não estiver logado
                    decoration: InputDecoration(
                      hintText: 'Adicione um comentário...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: userProvider.isLoggedIn
                      ? _addComment
                      : null, // Desabilita o botão se não estiver logado
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
            if (!userProvider.isLoggedIn)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Você precisa estar logado para adicionar um comentário.',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
