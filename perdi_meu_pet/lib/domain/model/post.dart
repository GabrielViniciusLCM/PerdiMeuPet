class Post {
  final String nome;
  final String descricao;
  final String localizacao;
  final String imageUrl;
  bool isFavorite;

  Post({
    required this.nome,
    required this.descricao,
    required this.localizacao,
    required this.imageUrl,
    this.isFavorite = false,
  });
}
