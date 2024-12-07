import 'package:flutter/material.dart';

import '../model/post.dart';
import '../service/post_service.dart';

class PostProvider with ChangeNotifier {

  final Map<String, Post> _posts = {};
  final Map<String, Post> _userPosts = {};
  
  Map<String, Post> get posts => this._posts;
  Map<String, Post> get userPosts => this._userPosts;

  Future<Map<String, Post>> getPosts() async {
    try {
      final posts = await PostService.getPosts();
      this._posts.clear();
      this._posts.addAll(posts);
      notifyListeners();
      return this.posts;
    } catch (error) {
      rethrow;
    }
  }

  Future<MapEntry<String, Post>> addPost(Post post) async {
    try {
      final addedPost = await PostService.addPost(post);
      this._posts[addedPost.key] = addedPost.value;
      notifyListeners();
      return addedPost;
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, Post>> getPostsByUserId(String userId) async {
    try {
      final posts = await PostService.getPostsByUser(userId);
      this._userPosts.clear();
      this._userPosts.addAll(posts);
      notifyListeners();
      return this.userPosts;
    } catch (error) {
      rethrow;
    }
  }

}