import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/domain/model/comment.dart';
import 'package:perdi_meu_pet/domain/provider/pet_provider.dart';
import 'package:perdi_meu_pet/domain/provider/user_provider.dart';
import 'package:perdi_meu_pet/domain/service/user_service.dart';
import 'package:perdi_meu_pet/domain/provider/comment_provider.dart';
import 'package:provider/provider.dart';
import '../domain/model/post.dart';

class PostDetailScreen extends StatefulWidget {
  final MapEntry<String, Post> postMapEntry;

  PostDetailScreen({required this.postMapEntry});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Carregar os comentários ao inicializar a tela
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final commentProvider = Provider.of<CommentProvider>(context, listen: false);
      commentProvider.loadComments(widget.postMapEntry.key);
    });
  }

  // Função para adicionar um novo comentário
  void _addComment() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final commentProvider = Provider.of<CommentProvider>(context, listen: false);

    if (_commentController.text.isNotEmpty && userProvider.isLoggedIn) {
      Comment newComment = Comment(
        postId: widget.postMapEntry.key,
        content: _commentController.text,
        userId: userProvider.userId,
      );

      try {
        await commentProvider.addComment(newComment);

        // Limpar o campo de texto após adicionar o comentário
        _commentController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Comentário adicionado com sucesso!')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao adicionar comentário: $e')));
      }
    } else if (!userProvider.isLoggedIn) {
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
          // future: PetService.getPetNameById(widget.post.petId),
          future: Provider.of<PetProvider>(context).getPetNameById(widget.postMapEntry.value.petId),
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
                  widget.postMapEntry.value.imageUrl,
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
             widget.postMapEntry.value.descricao,
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
             widget.postMapEntry.value.localizacao,
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
            Consumer<CommentProvider>(
              builder: (context, commentProvider, child) {
                if (commentProvider.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (commentProvider.comments.isEmpty) {
                  return Center(child: Text('Nenhum comentário encontrado.'));
                }
                if (commentProvider.error.isNotEmpty) {
                  return Center(child: Text(commentProvider.error));
                }

                final comments = commentProvider.comments;

                return Expanded(
                  child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments.values.toList()[index];

                      return FutureBuilder<String>(
                        future: UserService.getUserNameById(comment.userId),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState == ConnectionState.waiting) {
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

                          String userName = userSnapshot.data ?? 'Usuário desconhecido';

                          return ListTile(
                            leading: Icon(Icons.person, color: Colors.teal),
                            title: Text(userName),
                            subtitle: Text(comment.content),
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
                    enabled: userProvider.isLoggedIn,
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
                  onPressed: userProvider.isLoggedIn ? _addComment : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
            // if (!userProvider.isLoggedIn)
            //   Padding(
            //     padding: const EdgeInsets.only(top: 16.0),
            //     child: Text(
            //       'Você precisa estar logado para adicionar um comentário.',
            //       style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
