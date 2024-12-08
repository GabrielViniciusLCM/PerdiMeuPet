import 'package:flutter/material.dart';

import '../model/post.dart';
import '../service/post_service.dart';
import 'user_provider.dart';

class PostProvider with ChangeNotifier {

  final Map<String, Post> _posts = {};
  final Map<String, Post> _userPosts = {};
  final Map<String, Post> _favoritePosts = {};
  final UserProvider userProvider; // Injected UserProvider
  
  Map<String, Post> get posts => this._posts;
  Map<String, Post> get userPosts => this._userPosts;
  Map<String, Post> get favoritePosts => this._favoritePosts;

  PostProvider(this.userProvider);


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

  Future<Map<String, Post>> getUserPosts() async {
    try {
      final userId = this.userProvider.userId;
      final posts = await PostService.getPostsByUser(userId);
      this._userPosts.clear();
      this._userPosts.addAll(posts);
      return this.userPosts;
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, Post>> getFavoritePosts() async {
    try {
      final userId = this.userProvider.userId;
      final postsIds = await PostService.getFavoritePosts(userId);
      final posts = await PostService.getPosts();
      final favoritePosts = posts.entries.where((element) => postsIds.contains(element.key));
      this._favoritePosts.clear();
      this._favoritePosts.addEntries(favoritePosts);
      return this.favoritePosts;
    } catch (error) {
      rethrow;
    }
  }

}