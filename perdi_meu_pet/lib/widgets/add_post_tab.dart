import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/domain/provider/post_provider.dart';
import 'package:provider/provider.dart';
import '../domain/model/pet.dart';
import '../domain/model/post.dart';
import '../domain/provider/pet_provider.dart';
import '../domain/provider/user_provider.dart';
class AddPostTab extends StatefulWidget {
  @override
  _AddPostTabState createState() => _AddPostTabState();
}

class _AddPostTabState extends State<AddPostTab> {
  final _descricaoController = TextEditingController();
  final _localizacaoController = TextEditingController();
  String? _imageUrl;
  String? _selectedPetId; // Track the selected pet's ID
  late PetProvider petProvider;
  Map<String, Pet> pets = {};
  
  bool isLoading = true;


  @override
  initState() {
    super.initState();
    petProvider = Provider.of<PetProvider>(context, listen: false);
    _fetchPets();
  }

  void _fetchPets() async {
    try {
      final petsMap = await petProvider.getUserPets();
      setState(() {
        this.pets = petsMap;
        this.isLoading = false;
      });
    } catch (e) {
      setState(() {
        this.isLoading = false;
      });
    }
  }

  Future<void> _addPost() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final postProvier = Provider.of<PostProvider>(context, listen: false);
    if (_selectedPetId != null &&
        _descricaoController.text.isNotEmpty &&
        _localizacaoController.text.isNotEmpty &&
        _imageUrl != null) {
      final newPost = Post(
        descricao: _descricaoController.text,
        localizacao: _localizacaoController.text,
        imageUrl: _imageUrl!,
        userId: userProvider.userId,
        petId: _selectedPetId!,
      );

      // Submit the post (e.g., save to a backend or update a local provider)
      await postProvier.addPost(newPost);

      // For now, just clear the fields and show a success message
      _descricaoController.clear();
      _localizacaoController.clear();
      setState(() {
        _imageUrl = null;
        _selectedPetId = null;
      });

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
          'https://blog.casadoprodutor.com.br/wp-content/uploads/2018/04/gatinho.jpg'; // Example image URL
    });
  }

  @override
  Widget build(BuildContext context) {


    return isLoading
      ?Center(child: CircularProgressIndicator()) 
      :Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Pet selection dropdown
            DropdownButtonFormField<String>(
              value: _selectedPetId,
              onChanged: (value) {
                setState(() {
                  _selectedPetId = value;
                });
              },
              items: pets.entries.map((entry) {
                final pet = entry.value;
                return DropdownMenuItem<String>(
                  value: entry.key, // Pet ID
                  child: Text(pet.name),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Selecione um Pet'),
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
