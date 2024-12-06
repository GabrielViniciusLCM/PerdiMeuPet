class Comment {
  final String userId;
  final String postId;
  final String content;
  final DateTime createdAt = DateTime.now();

  Comment({
    required this.userId,
    required this.postId,
    required this.content,
  })  : assert(userId.isNotEmpty),
        assert(postId.isNotEmpty),
        assert(content.isNotEmpty),
        assert(content.length >= 5),
        assert(content.length <= 500);
}
