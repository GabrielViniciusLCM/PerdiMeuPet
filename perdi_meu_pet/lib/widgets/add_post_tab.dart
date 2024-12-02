import 'package:flutter/material.dart';
import '../models/Post.dart';
import '../screens/home_screen.dart';

class AddPostTab extends StatefulWidget {
  @override
  _AddPostTabState createState() => _AddPostTabState();
}

class _AddPostTabState extends State<AddPostTab> {
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _localizacaoController = TextEditingController();
  String? _imageUrl;

  void _addPost() {
    if (_nomeController.text.isNotEmpty &&
        _descricaoController.text.isNotEmpty &&
        _localizacaoController.text.isNotEmpty &&
        _imageUrl != null) {
      final newPost = Post(
        nome: _nomeController.text,
        descricao: _descricaoController.text,
        localizacao: _localizacaoController.text,
        imageUrl: _imageUrl!,
      );

      setState(() {
        mockPosts.add(newPost); // Adiciona o novo post à lista mockada de posts
      });

      // Limpa os campos de texto e a URL da imagem
      _nomeController.clear();
      _descricaoController.clear();
      _localizacaoController.clear();
      _imageUrl = null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post adicionado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
    }
  }


  // Função para simular a escolha de uma imagem
  void _pickImage() {
    setState(() {
      _imageUrl =
          'https://s3.animalia.bio/animals/photos/full/original/900px-koka-palawansk-mld-zoo-praha-1jpg.webp'; // URL de uma imagem de exemplo
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: 'Nome do pet'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _descricaoController,
            decoration: InputDecoration(labelText: 'Descrição'),
            maxLines: 2,
          ),
          SizedBox(height: 10),
          TextField(
            controller: _localizacaoController,
            decoration: InputDecoration(labelText: 'Localização'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Escolher Imagem'),
          ),
          if (_imageUrl != null) ...[
            SizedBox(height: 10),
            Image.network(_imageUrl!, height: 100, fit: BoxFit.cover),
          ],
          Spacer(),
          ElevatedButton(
            onPressed: _addPost,
            child: Text('Publicar'),
          ),
        ],
      ),
    );
  }
}
