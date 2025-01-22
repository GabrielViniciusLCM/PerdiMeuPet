import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  void initState() {
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

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageUrl = pickedFile.path; // Usaremos o caminho local da imagem
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nenhuma imagem foi selecionada.')),
      );
    }
  }

  Future<void> _addPost() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    if (_selectedPetId != null &&
        _descricaoController.text.isNotEmpty &&
        _localizacaoController.text.isNotEmpty &&
        _imageUrl != null) {
      final newPost = Post(
        descricao: _descricaoController.text,
        localizacao: _localizacaoController.text,
        imageUrl: _imageUrl!, // Aqui você pode alterar para o URL após upload
        userId: userProvider.userId,
        petId: _selectedPetId!,
      );

      // Submit the post (e.g., save to a backend or update a local provider)
      await postProvider.addPost(newPost);

      // Clear fields and show a success message
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: Icon(Icons.photo_library),
                      label: Text('Galeria'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: Icon(Icons.camera_alt),
                      label: Text('Câmera'),
                    ),
                  ],
                ),
                if (_imageUrl != null) ...[
                  SizedBox(height: 10),
                  Image.file(File(_imageUrl!), height: 100, fit: BoxFit.cover),
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
