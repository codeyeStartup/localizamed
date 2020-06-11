class Usuario {
  final String id;
  final String nome;
  final String email;
  final String uf;
  final String fone_1;
  final String cidade;
  final String cpf;
  final String rg;
  final String caminhoFoto;

  Usuario(
      {this.nome,
      this.cidade,
      this.cpf,
      this.caminhoFoto,
      this.email,
      this.fone_1,
      this.rg,
      this.id,
      this.uf});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['_id'] as String,
      nome: json['nome'] as String,
      cidade: json['cidade'] as String,
      cpf: json['cpf'] as String,
      caminhoFoto: json['caminho_foto'] as String,
      email: json['email'] as String,
      fone_1: json['fone_1'] as String,
      rg: json['rg'] as String,
      uf: json['uf'] as String
    );
  }
}