
class Clinicas {
  String id;
  String nome;
  String razaoSocial;
  String email;
  String site;
  String cnpj;
  num latitude;
  num longitude;
  String descricao;
  String cidade;
  String bairro;
  String uf;
  String fone_1;
  String fone_2;
  String caminhoFoto;
  MedicoId medicosClin;
  ExameConsultaId examConsultaClin;
  /* final MedicoClin medicosClin;
  final ExamesConsultaClin examConsultaClin; */
  String teste;

  Clinicas(
      {this.id,
      this.nome,
      this.razaoSocial,
      this.email,
      this.site,
      this.cnpj,
      this.latitude,
      this.longitude,
      this.descricao,
      this.cidade,
      this.bairro,
      this.uf,
      this.fone_1,
      this.fone_2,
      this.caminhoFoto,
      this.medicosClin,
      this.examConsultaClin,
      this.teste,
      });

  Clinicas.fromJson(Map<String, dynamic> json) {
      id = json['_id'] as String;
      medicosClin = MedicoId.fromJson(json['medico']);
      examConsultaClin = ExameConsultaId.fromJson(json['exame_consulta']);
    /* if (json['medico'] != null) {
      medicosClin = new List<MedicosClin>();
      json['medico'].forEach((v) {
        medicosClin.add(new MedicosClin.fromJson(v));
      });
    }
    if (json['exame_consulta'] != null) {
      examConsultaClin = new List<ExamesConsultaClin>();
      json['exame_consulta'].forEach((v) {
        examConsultaClin.add(new ExamesConsultaClin.fromJson(v));
      });
    } */
      teste = json['especialidade'] as String;
      nome = json['nome'] as String;
      razaoSocial = json['razao_social'] as String;
      email = json['email'] as String;
      site = json['site'] as String;
      latitude = json['latitude'] as num;
      longitude = json['longitude'] as num;
      descricao = json['descricao'] as String;
      cidade = json['cidade'] as String;
      bairro = json['bairro'] as String;
      uf = json['uf'] as String;
      fone_1 = json['fone_1'] as String;
      fone_2 = json['fone_2'] as String;
      caminhoFoto = json['caminho_foto'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['site'] = this.site;
    data['razao_social'] = this.razaoSocial;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['cidade'] = this.cidade;
    data['bairro'] = this.bairro;
    data['uf'] = this.uf;
    data['fone_1'] = this.fone_1;
    data['fone_2'] = this.fone_2;
    data['cnpj'] = this.cnpj;
    data['descricao'] = this.descricao;
    data['caminho_foto'] = this.caminhoFoto;
    data['medico'] = this.medicosClin;
    data['exames_consulta'] = this.examConsultaClin;
    /* if (this.medicosClin != null) {
      data['medico'] = this.medicosClin.map((v) => v.toJson()).toList();
    }
    if (this.examConsultaClin != null) {
      data['exame_consulta'] =
          this.examConsultaClin.map((v) => v.toJson()).toList();
    } */
    return data;
  }
}

class MedicosClin {
  String idMedico;
  MedicoId medicoIdClass;

  MedicosClin({this.idMedico,this.medicoIdClass});

  MedicosClin.fromJson(Map<String, dynamic> json) {  
        idMedico = json['_id'] as String;
        medicoIdClass = MedicoId.fromJson(json['medicoId']);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.idMedico;
    if(this.medicoIdClass != null) {
      data['medicoId'] = this.medicoIdClass.toJson();
    }
    return data;
  }
}

class MedicoId {
  String id;
  String nome;
  String especialidade;
  String sexo;
  String temFoto;
  String caminhoFoto;

  MedicoId(
      {this.id,
      this.especialidade,
      this.nome,
      this.sexo,
      this.temFoto,
      this.caminhoFoto});

  MedicoId.fromJson(Map<String, dynamic> json) {
      id = json['_id'];
      nome = json['nome'];
      especialidade = json['especialidade'];
      sexo = json['sexo'];
      temFoto = json['temFoto'];
      caminhoFoto = json['caminho_foto'];
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['nome'] = this.nome;
    data['especialidade'] = this.especialidade;
    data['sexo'] = this.sexo;
    data['temFoto'] = this.temFoto;

    return data;
  }

}

class ExamesConsultaClin {
  String idExamConsult;
  ExameConsultaId exameConsultaId;

  ExamesConsultaClin({this.idExamConsult,this.exameConsultaId});

  ExamesConsultaClin.fromJson(Map<String, dynamic> json) {
      idExamConsult = json['_id'];
      exameConsultaId = json['exame_consulta_id'] != null
        ? new ExameConsultaId.fromJson(json['exame_consulta_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["_id"] = idExamConsult;
     if (this.exameConsultaId != null) {
      data['exame_consulta_id'] = this.exameConsultaId.toJson();
    }
    return data;
  }
}

class ExameConsultaId {
  String id;
  String nomeExam;

  ExameConsultaId({this.id,this.nomeExam});

  ExameConsultaId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nomeExam = json['nome'];
  } 

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["_id"] = id;
    data["nome"] = nomeExam;

    return data;
  }
}

/* class Clinicas {
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
      this.teste,
      this.examConsultaClin});

  factory Clinicas.fromJson(Map<String, dynamic> json) {
    return Clinicas(
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
} */
