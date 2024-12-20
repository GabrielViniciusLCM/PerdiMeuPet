import 'package:flutter/material.dart';
import '../domain/model/post.dart';
import '../domain/provider/pet_provider.dart';
import '../domain/provider/user_provider.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatefulWidget {
  final MapEntry<String, Post> postMapEntry;
  final VoidCallback onFavoriteToggled; // Callback para notificar o pai

  const PostWidget({
    Key? key,
    required this.postMapEntry,
    required this.onFavoriteToggled,
  }) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  void _toggleFavorite() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.toggleFavorite(widget.postMapEntry.key);
  }

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UserProvider>(context);
    final isFavorite = usuarioProvider.isPostFavorite(widget.postMapEntry.key);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
            color: Colors.grey.shade300, width: 1), // Borda cinza clara
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do Post
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                widget.postMapEntry.value.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            // Informações do Post
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Usando FutureBuilder para buscar o nome do pet
                  FutureBuilder<String>(
                    future: Provider.of<PetProvider>(context).getPetNameById(widget.postMapEntry.value.petId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          '...',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Text(
                          'Erro ao carregar nome do pet',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        );
                      }

                      String petName = snapshot.data ?? 'Nome do pet'; // Se não encontrar, exibe "Nome do pet"
                      return Text(
                        petName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  Text(
                   widget.postMapEntry.value.descricao,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.teal),
                      SizedBox(width: 4),
                      // Text(widget.post.localizacao),
                      Expanded(
                        child: Text(
                          widget.postMapEntry.value.localizacao,
                          style: TextStyle(color: Colors.grey[600]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),

                      if (usuarioProvider.isLoggedIn)
                        IconButton(
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            // Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: _toggleFavorite,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

