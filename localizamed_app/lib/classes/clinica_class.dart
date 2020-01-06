class Clinicas {
  final String id;
  final String nome;
  final String cidade;
  final String caminhoFoto;

  Clinicas({this.id, this.nome, this.cidade, this.caminhoFoto});

  factory Clinicas.fromJson(Map<String, dynamic> json) {
    return Clinicas(
      id: json['_id'] as String,
      nome: json['nome'] as String,
      cidade: json['cidade'] as String,
      caminhoFoto: json['caminho_foto'] as String,
    );
  }
}

class Clinicas2 {
  final String id;
  final String idMedico;
  final String nome;
  final String razaoSocial;
  final String email;
  final String site;
  final String cnpj;
  final num latitute;
  final num longitude;
  final String descricao;
  final String cidade;
  final String bairro;
  final String uf;
  final String fone_1;
  final String fone_2;
  final String caminhoFoto;
  final List<MedicosClin> medicosClin;
  final List<ExamesConsultaClin> examConsultaClin;
  final String teste;

  Clinicas2(
      {this.id,
      this.idMedico,
      this.nome,
      this.razaoSocial,
      this.email,
      this.site,
      this.cnpj,
      this.latitute,
      this.longitude,
      this.descricao,
      this.cidade,
      this.bairro,
      this.uf,
      this.fone_1,
      this.fone_2,
      this.caminhoFoto,
      this.medicosClin,
      this.teste,
      this.examConsultaClin});

  factory Clinicas2.fromJson(Map<String, dynamic> json) {
    return Clinicas2(
      id: json['_id'] as String,
      medicosClin:
          (json['medico'] as List).map((i) => MedicosClin.fromJson(i)).toList(),
      examConsultaClin: (json['exame_consulta'] as List)
          .map((i) => ExamesConsultaClin.fromJson(i))
          .toList(),
      teste: json['especialidade'] as String,
      nome: json['nome'] as String,
      razaoSocial: json['razao_social'] as String,
      email: json['email'] as String,
      site: json['site'] as String,
      latitute: json['latitude'] as num,
      longitude: json['longitude'] as num,
      descricao: json['descricao'] as String,
      cidade: json['cidade'] as String,
      bairro: json['bairro'] as String,
      uf: json['uf'] as String,
      fone_1: json['fone_1'] as String,
      fone_2: json['fone_2'] as String,
      caminhoFoto: json['caminho_foto'] as String,
    );
  }
}

class MedicosClin {
  final String idMedico;
  final MedicoId medicoIdClass;

  MedicosClin({this.medicoIdClass, this.idMedico});

  factory MedicosClin.fromJson(Map<String, dynamic> json) {
    return MedicosClin(
        idMedico: json['_id'] as String,
        medicoIdClass: MedicoId.fromJson(json['medicoId']));
  }
}

class MedicoId {
  final String nome;
  final String especialidade;
  final String sexo;
  final String temFoto;
  final String caminhoFoto;

  MedicoId(
      {this.especialidade,
      this.nome,
      this.sexo,
      this.temFoto,
      this.caminhoFoto});

  factory MedicoId.fromJson(Map<String, dynamic> json) {
    return MedicoId(
        nome: json['nome'],
        especialidade: json['especialidade'],
        sexo: json['sexo'],
        temFoto: json['temFoto'],
        caminhoFoto: json['caminho_foto']);
  }
}

class ExamesConsultaClin {
  final ExameConsultaId exameConsultaId;

  ExamesConsultaClin({this.exameConsultaId});

  factory ExamesConsultaClin.fromJson(Map<String, dynamic> json) {
    return ExamesConsultaClin(
        exameConsultaId: ExameConsultaId.fromJson(json['exame_consulta_id']));
  }
}

class ExameConsultaId {
  final String exame;

  ExameConsultaId({this.exame});

  factory ExameConsultaId.fromJson(Map<String, dynamic> json) {
    return ExameConsultaId(exame: json['nome']);
  }
}
