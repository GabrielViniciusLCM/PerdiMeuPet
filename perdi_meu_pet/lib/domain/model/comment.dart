// ignore_for_file: unnecessary_this

class Comment {
  final String userId;                      // id do usuário que fez o comentário
  final String postId;                      // id do post que recebeu o comentário
  final String text;                        // texto do comentário
  final DateTime placedAt = DateTime.now(); // data e hora do comentário

  Comment({
    required this.userId,
    required this.postId,
    required this.text,
  }):assert(userId.isNotEmpty),
    assert(postId.isNotEmpty),
    assert(text.isNotEmpty),
    assert(userId.length >= 5),
    assert(postId.length >= 5),
    assert(text.length >= 5),
    assert(text.length <= 500);

  // Comment copyWith({
  //   String? id,
  //   String? userId,
  //   String? petId,
  //   String? text,
  //   DateTime? date,
  // }) {
  //   return Comment(
  //     id: id ?? this.id,
  //     userId: userId ?? this.userId,
  //     petId: petId ?? this.petId,
  //     text: text ?? this.text,
  //     date: date ?? this.date,
  //   );
  // }
  Comment.fromJson(Map<String, dynamic> json):
    this.userId = json['userId'],
    this.postId = json['postId'],
    this.text   = json['text'];

  Map<String, dynamic> toJson() {
    return {
      'userId':   this.userId,
      'postId':   this.postId,
      'text':     this.text,
      'placedAt': this.placedAt,
    };
  }

  @override
  String toString() {
    return '''Comment(
      \n\tuserId: ${this.userId},
      \n\tpostId: ${this.postId}, 
      \n\ttext: ${this.text}, 
      \n\tdate: ${this.placedAt},
      \n)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Comment &&
      other.userId    == this.userId &&
      other.postId    == this.postId &&
      other.text      == this.text &&
      other.placedAt  == this.placedAt;
  }

  // @override
  // int get hashCode {
  //   return id.hashCode ^ userId.hashCode ^ petId.hashCode ^ text.hashCode ^ date.hashCode;
  // }
}