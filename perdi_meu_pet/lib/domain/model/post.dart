// ignore_for_file: unnecessary_this
class Post {
  final String descricao; // descrição do post
  final String
      localizacao; // localização do pet, onde foi visto pela última vez
  final String imageUrl; // url da imagem do pet
  final String userId; // id do usuário que fez o post
  final String petId; // id do pet que se perdeu
  final DateTime placedAt; // data e hora do post

  Post({
    required this.descricao,
    required this.localizacao,
    required this.imageUrl,
    required this.userId,
    required this.petId,
  })  : placedAt = DateTime.now(),
        assert(descricao.isNotEmpty),
        assert(localizacao.isNotEmpty),
        assert(imageUrl.isNotEmpty),
        assert(userId.isNotEmpty),
        assert(petId.isNotEmpty),
        assert(descricao.length >= 5),
        assert(localizacao.length >= 5),
        assert(imageUrl.length >= 5),
        assert(userId.length >= 5),
        assert(petId.length >= 5);

  Post.fromJson(Map<String, dynamic> json)
      : this.descricao = json['descricao'],
        this.localizacao = json['localizacao'],
        this.imageUrl = json['imageUrl'],
        this.userId = json['userId'],
        this.petId = json['petId'],
        this.placedAt = DateTime.parse(json[
            'placedAt']); // Retorna string no padrão ISO 8601 para o DateTime

  Map<String, dynamic> toJson() {
    return {
      'descricao': this.descricao,
      'localizacao': this.localizacao,
      'imageUrl': this.imageUrl,
      'userId': this.userId,
      'petId': this.petId,
      'placedAt': this.placedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return '''Post{
      \n\tdescricao: ${this.descricao},
      \n\tlocalizacao: ${this.localizacao},
      \n\timageUrl: ${this.imageUrl},
      \n\tuserId: ${this.userId},
      \n\tpetId: ${this.petId},
      \n\tplacedAt: $placedAt
      \n}''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Post &&
        other.descricao == this.descricao &&
        other.localizacao == this.localizacao &&
        other.imageUrl == this.imageUrl &&
        other.userId == this.userId &&
        other.petId == this.petId &&
        other.placedAt == this.placedAt;
  }
}
