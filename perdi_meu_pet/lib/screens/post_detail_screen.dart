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
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // Arredondar as bordas da imagem
                child: Image.network(
                  post.imageUrl,
                  fit: BoxFit.cover,
                  height: 200, // Altura da imagem
                  width: double.infinity, // Largura da imagem
                ),
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
                        Spacer(), // Espaço flexível para empurrar os botões para baixo
            Divider(thickness: 1),
            Text(
              'Comentários:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Mock para 3 comentários
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person, color: Colors.teal),
                    title: Text('Usuário $index'),
                    subtitle: Text('Comentário exemplo $index'),
                  );
                },
              ),
            ),
            Divider(thickness: 1),
            Row(
              children: [
                Expanded(
                  child: TextField(
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
                  onPressed: () {
                    // Lógica mockada de adicionar comentário
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
