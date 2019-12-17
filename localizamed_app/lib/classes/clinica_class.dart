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
  final String teste;

  Clinicas2({
    this.id,
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
  });

  factory Clinicas2.fromJson(Map<String, dynamic> json) {
    return Clinicas2(
      id: json['_id'] as String,
      //idMedico: json['medico'] as String,
      //medicosClin: MedicosClin.fromJson(json["medico"]),
      /* medicosClin: json['medico']
              ?.map<MedicosClin>((dynamic map) => MedicosClin.fromJson(map))
              ?.toList() ??
          [], */
      medicosClin:
          (json['medico'] as List).map((i) => MedicosClin.fromJson(i)).toList(),
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
        caminhoFoto: json['caminho_foto']
        );
  }
}
//print(snapshot.data.medicosClin[0].testeNome);
//user.address.geo.lat

//-------------------------------------------------

/*  class Clinicas {
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
  final String teste;

  Clinicas(
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
      this.teste});

  factory Clinicas.fromJson(Map<String, dynamic> json) {
    return Clinicas(
      id: json['_id'] as String,
      //idMedico: json['medico'] as String,
      //medicosClin: MedicosClin.fromJson(json["medico"]),
      /* medicosClin: json['medico']
              ?.map<MedicosClin>((dynamic map) => MedicosClin.fromJson(map))
              ?.toList() ??
          [], */
      medicosClin: (json['medico'] as List).map((i) => MedicosClin.fromJson(i)).toList(),   
      teste: json['especialidade'] as String,
      nome: json['nome'] as String,
      razaoSocial: json['razao_social'] as String,
      email: json['email'] as String,
      site: json['site'] as String,
      cnpj: json['cnpj'] as String,
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
  final String nome;
  final String especialidade;
  final String idMedico;

  MedicosClin({this.especialidade, this.nome, this.idMedico});

  factory MedicosClin.fromJson(Map<String, dynamic> json) {
    return MedicosClin(
      nome: json['nome'] as String,
      especialidade: json['especialidade'] as String,
      idMedico: json['_id'] as String,
    );
  }
}  */
