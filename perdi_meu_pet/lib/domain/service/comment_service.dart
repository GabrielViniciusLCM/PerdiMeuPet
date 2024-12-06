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
}
