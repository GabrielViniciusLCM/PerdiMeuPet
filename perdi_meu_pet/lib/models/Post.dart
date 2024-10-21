class Post {
  Post({
    required this.id,
    required this.animalId,
    required this.usuarioId,
    required this.descricao,
    required this.localizacao,
    required this.dataPerda,
  });

  final String id;
  final String animalId;
  final String usuarioId;
  final String descricao;
  final String localizacao;
  final DateTime dataPerda;
}
