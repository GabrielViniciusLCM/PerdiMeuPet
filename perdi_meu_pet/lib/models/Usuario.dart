class Usuario {
  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.senha, // Adicionando o campo senha
  });

  final String id;
  final String nome;
  final String email;
  final String telefone;
  final String senha; // Campo para armazenar a senha
}
