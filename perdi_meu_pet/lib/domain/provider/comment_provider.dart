import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/domain/model/comment.dart';
import 'package:perdi_meu_pet/domain/service/comment_service.dart';

class CommentProvider extends ChangeNotifier {
  Map<String, Comment> _comments = {};
  bool _loading = false;
  String _error = '';

  Map<String, Comment> get comments => _comments;
  bool get loading => _loading;
  String get error => _error;

  // Função para carregar os comentários de um post
  Future<void> loadComments(String postId) async {
    _loading = true;
    notifyListeners();

    try {
      Map<String, Comment> fetchedComments =
          await CommentService.getCommentsByPostId(postId);
      _comments = fetchedComments; // Atualiza os comentários
      _error = '';
    } catch (e) {
      _error = 'Erro ao carregar comentários: $e';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Função para adicionar um comentário
  Future<void> addComment(Comment newComment) async {
    try {
      Map<String, Comment> addedComment =
          await CommentService.addComment(newComment);

      _comments[addedComment.keys.first] = newComment;

      notifyListeners();
    } catch (e) {
      _error = 'Erro ao adicionar comentário: $e';
      notifyListeners();
    }
  }
}
