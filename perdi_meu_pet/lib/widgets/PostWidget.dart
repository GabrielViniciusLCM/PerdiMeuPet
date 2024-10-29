import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/models/Post.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final VoidCallback onFavoriteToggled; // Callback para notificar o pai

  const PostWidget({
    Key? key,
    required this.post,
    required this.onFavoriteToggled,
  }) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  void _toggleFavorite() {
    setState(() {
      widget.post.isFavorite = !widget.post.isFavorite;
    });
    widget.onFavoriteToggled(); // Callback notifica o pai quando o favorito muda
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                widget.post.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.nome,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.post.descricao,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.teal),
                      SizedBox(width: 4),
                      Text(widget.post.localizacao),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          widget.post.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.post.isFavorite ? Colors.red : null,
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