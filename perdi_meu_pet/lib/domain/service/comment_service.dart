import 'dart:convert';
import '../../utils/urls.dart';
import '../model/comment.dart';
import 'package:http/http.dart' as http;

class CommentService {
  static Future<Map<String, Comment>> addComment(Comment comment) async {
    final response = await http.post(
      Uri.parse('${Urls.BASE_URL}/comments.json'),
      body: json.encode(comment),
    );

    if (response.statusCode == 200) {
      final id = json.decode(response.body)['name'];
      final Map<String, Comment> commentMap = {id: comment};
      return commentMap;
    } else {
      throw Exception('Erro ao cadastrar comentário.');
    }
  }

  // Método para obter comentários filtrados por postId
  static Future<Map<String, Comment>> getCommentsByPostId(String postId) async {
    final response =
        await http.get(Uri.parse('${Urls.BASE_URL}/comments.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, Comment> commentMap = {};

      data.forEach((key, value) {
        // Verifica se o comentário tem o mesmo postId que o post em questão
        if (value['postId'] == postId) {
          commentMap[key] = Comment.fromJson(value);
        }
      });

      return commentMap;
    } else {
      throw Exception('Erro ao buscar comentários');
    }
  }

  // Método para deletar comentário por id do post
  static Future<void> deleteCommentsByPostId(String id) async {
    final posts = await getCommentsByPostId(id);
    final List<String> commentKeys = posts.keys.toList();
    commentKeys.forEach((commentKey) async {
      final response = await http.delete(Uri.parse('${Urls.BASE_URL}/comments/$commentKey.json'));
      if (response.statusCode != 200) {
        throw Exception('Erro ao deletar comentário');
      }
    });
  }
}
