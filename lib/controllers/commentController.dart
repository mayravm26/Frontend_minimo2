import 'package:flutter/material.dart';
import '../services/commentServide.dart';
import '../models/Comment.dart';
/*
class CommentController with ChangeNotifier {
  final CommentService _commentService = CommentService();
  List<Comment> _comments = [];
  bool _isLoading = false;

  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;

  Future<void> fetchComments(String postId) async {
    _isLoading = true;
    notifyListeners();

    _comments = await _commentService.getComments(postId);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addComment(String postId, Comment comment) async {
    final newComment = await _commentService.addComment(postId, comment);
    _comments.add(newComment);
    notifyListeners();
  }

  Future<void> updateComment(String commentId, Comment updatedComment) async {
    final index = _comments.indexWhere((comment) => comment.id == commentId);
    if (index != -1) {
      final updated =
          await _commentService.updateComment(commentId, updatedComment);
      _comments[index] = updated;
      notifyListeners();
    }
  }

  Future<void> deleteComment(String postId, String commentId) async {
    await _commentService.deleteComment(postId, commentId);
    _comments.removeWhere((comment) => comment.id == commentId);
    notifyListeners();
  }
}
*/

class CommentController with ChangeNotifier {
  final CommentService _commentService = CommentService();

  // Lista de comentarios
  List<Comment> _comments = [];
  bool _isLoading = false;

  // Getters para acceder a los datos
  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;

  // Método para obtener comentarios de un post
  Future<void> fetchComments(String postId) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Obtener comentarios del servicio
      _comments = await _commentService.getComments(postId);
    } catch (error) {
      print('Error al obtener comentarios: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para agregar un nuevo comentario
  Future<void> addComment(String postId, Comment comment) async {
    try {
      final newComment = await _commentService.addComment(postId, comment);
      _comments.add(newComment);
      notifyListeners();
    } catch (error) {
      print('Error al agregar comentario: $error');
    }
  }

  // Método para actualizar un comentario existente
  Future<void> updateComment(String commentId, Comment updatedComment) async {
    try {
      final index = _comments.indexWhere((comment) => comment.id == commentId);
      if (index != -1) {
        final updated =
            await _commentService.updateComment(commentId, updatedComment);
        _comments[index] = updated;
        notifyListeners();
      }
    } catch (error) {
      print('Error al actualizar comentario: $error');
    }
  }

  // Método para eliminar un comentario
  Future<void> deleteComment(String postId, String commentId) async {
    try {
      await _commentService.deleteComment(postId, commentId);
      _comments.removeWhere((comment) => comment.id == commentId);
      notifyListeners();
    } catch (error) {
      print('Error al eliminar comentario: $error');
    }
  }
}
