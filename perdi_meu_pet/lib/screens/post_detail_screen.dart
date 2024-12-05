import 'package:flutter/material.dart';
import '../domain/model/post.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;

  PostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(post.nome),
        title: Text('Nome do pet'), // Nome do pet
        backgroundColor: Colors.teal, // Mesma cor da HomeScreen
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0), // Arredondar as bordas da imagem
              child: Image.network(
                post.imageUrl,
                fit: BoxFit.cover,
                height: 200, // Altura da imagem
                width: double.infinity, // Largura da imagem
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Descrição:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal), // Estilo do título
            ),
            SizedBox(height: 8),
            Text(
              post.descricao,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Localização:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal), // Estilo do título
            ),
            SizedBox(height: 8),
            Text(
              post.localizacao,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
