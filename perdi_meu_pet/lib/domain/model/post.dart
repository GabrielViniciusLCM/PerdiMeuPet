// ignore_for_file: unnecessary_this
class Post {
  final String nome;        // nome do pet
  final String descricao;   // descrição do post
  final String localizacao; // localização do pet, onde foi visto pela última vez
  final String imageUrl;    // url da imagem do pet
  final String userId;      // id do usuário que fez o post
  final String petId;       // id do pet que se perdeu
  final DateTime placedAt = DateTime.now(); // data e hora do post

  Post({
    required this.nome,
    required this.descricao,
    required this.localizacao,
    required this.imageUrl,
    required this.userId,
    required this.petId,
  }):assert(nome.isNotEmpty),
    assert(descricao.isNotEmpty),
    assert(localizacao.isNotEmpty),
    assert(imageUrl.isNotEmpty),
    assert(userId.isNotEmpty),
    assert(petId.isNotEmpty),
    assert(nome.length >= 3),
    assert(descricao.length >= 5),
    assert(localizacao.length >= 5),
    assert(imageUrl.length >= 5),
    assert(userId.length >= 5),
    assert(petId.length >= 5);
  
  Post.fromJson(Map<String, dynamic> json):
    this.nome         = json['nome'],
    this.descricao    = json['descricao'],
    this.localizacao  = json['localizacao'],
    this.imageUrl     = json['imageUrl'],
    this.userId       = json['userId'],
    this.petId        = json['petId'];
  
  Map<String, dynamic> toJson() {
    return {
      'nome':        this.nome,
      'descricao':   this.descricao,
      'localizacao': this.localizacao,
      'imageUrl':    this.imageUrl,
      'userId':      this.userId,
      'petId':       this.petId,
      'placedAt':    this.placedAt.toString(),
    };
  }

  @override
  String toString() {
    return '''Post{
      \n\tnome: ${this.nome},
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
      other.nome        == this.nome &&
      other.descricao   == this.descricao &&
      other.localizacao == this.localizacao &&
      other.imageUrl    == this.imageUrl &&
      other.userId      == this.userId &&
      other.petId       == this.petId &&
      other.placedAt    == this.placedAt;
  }
}
