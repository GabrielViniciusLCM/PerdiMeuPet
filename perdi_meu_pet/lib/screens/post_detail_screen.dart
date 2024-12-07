import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/domain/model/comment.dart';
import 'package:perdi_meu_pet/domain/provider/user_provider.dart';
import 'package:perdi_meu_pet/domain/service/comment_service.dart';
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
  final TextEditingController _commentController = TextEditingController(); // Controller for text input

  @override
  void initState() {
    super.initState();
    // Fetch comments specifically related to the current post
    _commentsFuture = CommentService.getCommentsByPostId(widget.post.petId); // Get comments filtered by postId
  }

  // Function to handle adding a new comment
  void _addComment() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    if (_commentController.text.isNotEmpty && userProvider.isLoggedIn) {
      Comment newComment = Comment(
        postId: widget.post.petId, // Link comment to the specific post
        content: _commentController.text,
        userId: userProvider.userId, // Use the logged-in user's ID
      );

      try {
        // Adding the comment using the service
        Map<String, Comment> newCommentMap = await CommentService.addComment(newComment);
        
        // If the comment is successfully added, we update the UI
        setState(() {
          _commentsFuture = CommentService.getCommentsByPostId(widget.post.petId); // Fetch updated comments for this post
          _commentController.clear(); // Clear the text input
        });

        // Optionally show a success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Comentário adicionado com sucesso!')));
      } catch (e) {
        // Show an error message if something goes wrong
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao adicionar comentário: $e')));
      }
    } else if (!userProvider.isLoggedIn) {
      // If the user is not logged in, show a message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Você precisa estar logado para adicionar um comentário.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Nome do pet'),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 8),
            Text(
              widget.post.descricao,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Localização:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            FutureBuilder<Map<String, Comment>>(
              future: _commentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar comentários.'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhum comentário encontrado.'));
                }

                final comments = snapshot.data!;

                return Expanded(
                  child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments.values.toList()[index];
                      return ListTile(
                        leading: Icon(Icons.person, color: Colors.teal),
                        title: Text('Usuário ${index + 1}'),
                        subtitle: Text(comment.content),
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
                    enabled: userProvider.isLoggedIn, // Disable text field if not logged in
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
                  onPressed: userProvider.isLoggedIn ? _addComment : null, // Disable button if not logged in
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
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
