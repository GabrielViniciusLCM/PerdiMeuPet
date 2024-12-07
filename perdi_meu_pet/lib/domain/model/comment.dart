class Comment {
  final String userId;
  final String postId;
  final String content;
  final DateTime createdAt;

  Comment({
    required this.userId,
    required this.postId,
    required this.content,
  })  : createdAt = DateTime.now(),
        assert(userId.isNotEmpty),
        assert(postId.isNotEmpty),
        assert(content.isNotEmpty),
        assert(content.length >= 5),
        assert(content.length <= 500);

  Comment.fromJson(Map<String, dynamic> json)
      : this.userId = json['userId'],
        this.postId = json['postId'],
        this.content = json['content'],
        this.createdAt = DateTime.parse(json[
            'createdAt']); // Retorna string no padrão ISO 8601 para o DateTime

  Map<String, dynamic> toJson() {
    return {
      'userId': this.userId,
      'postId': this.postId,
      'content': this.content,
      'createdAt': this.createdAt.toIso8601String(),
    };
  }
}
