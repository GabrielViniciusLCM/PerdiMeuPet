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

  /**
   * Nessa implementação retorna todos os posts independentemente do id passado... Refatorar para corrigir
   */
  static Future<Map<String, Comment>> getCommentsByPostId(String postId) async {
    final response = await http
        .get(Uri.parse('${Urls.BASE_URL}/comments.json?postId=$postId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Verifique se a resposta contém dados
      if (data.isEmpty) {
        return {};
      }

      final Map<String, Comment> commentMap = {};
      data.forEach((commentId, commentData) {
        commentMap[commentId] = Comment.fromJson(commentData);
      });

      return commentMap;
    } else {
      throw Exception('Erro ao buscar comentários');
    }
  }
}
