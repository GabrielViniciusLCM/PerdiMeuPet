import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/domain/service/pet_service.dart';
import 'package:perdi_meu_pet/domain/service/post_service.dart';
import 'package:provider/provider.dart';
import '../domain/model/pet.dart';
import '../domain/model/post.dart';
import '../domain/provider/user_provider.dart';
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

  Future<void> _addPost() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (_nomeController.text.isNotEmpty &&
        _descricaoController.text.isNotEmpty &&
        _localizacaoController.text.isNotEmpty &&
        _imageUrl != null) {
      
      final newPet = Pet(
        name: _nomeController.text,
        userId: userProvider.userId,
      );
      final petMapEntry = await PetService.addPet(newPet);  

      final newPost = Post(
        // nome: _nomeController.text,
        descricao: _descricaoController.text,
        localizacao: _localizacaoController.text,
        imageUrl: _imageUrl!,
        userId: userProvider.userId,
        petId: petMapEntry.key,
      );
      final postMap = await PostService.addPost(newPost);

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
          'https://blog.casadoprodutor.com.br/wp-content/uploads/2018/04/gatinho.jpg'; // URL de uma imagem de exemplo
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
