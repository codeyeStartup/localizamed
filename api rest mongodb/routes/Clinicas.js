const express = require('express');
const Clinicas = require("../models/clinicas");
const bcrypt = require('bcryptjs');
const SALT_WORK_FACTOR = 10;


const clinicasRouter = express.Router();

//função de RETORNAR TODAS as CLÍNICAS
clinicasRouter.get('/clinicas', (req, res, next)=>{
  async function AllClinicas(){
      Clinicas.find({}, (erro, dados) => {
          if(erro){
              res.status(417).send({ message: "Nenhum registro recebido"});
          }
          res.status(200);
          res.json(dados);
      });
  }

  AllClinicas();
});

//função para RETORNAR UMA ÚNICA CLÍNICA
clinicasRouter.get('/clinicas/:id', (req, res, next) => {
    async function findClinicas(){
        clinicas.findById(req.params.id).then((clinicas) => {
            res.status(200);
            res.json(clinicas);
        }).catch((erro) => {
            if(erro){
                res.status(417).send({ message: "Nenhum usuário encontrado"});
                throw erro;
            }
        });
    }

    findClinicas();
});

//função de INSERIR dados no banco
clinicasRouter.post('/clinicas', (req, res, next)=>{

    async function salvaClinicas(){
        const clinicas = new Clinicas({
            nome: req.body.nome,
            email: req.body.email,
            razao_social: req.body.razao_social,
            senha: bcrypt.hashSync(req.body.senha, 10),
            //latitude
            //longitude
            logradouro: req.body.logradouro,
            bairro: req.body.bairro,
            uf: req.body.uf,
            fone_1: req.body.fone_1,
            fone_2: req.body.fone_2,
            cnpj: req.body.cnpj,
            descricao: req.body.descricao,
            caminho_foto: req.body.caminho_foto,
            data_atualizacao: null
            });


        try{
            const result = await clinicas.save();
            console.log("Operação realizada com sucesso");
            res.status(201).send({ message: "Cadastrado com sucesso!"});
            /* res.statusCode = 201;
            res.send(); */
        } catch(erro){
            console.log(erro.message);
            res.status(406).send({ message: "Cadastro falhou"});
            /* res.statusCode = 406;
            res.send(); */
        }
    }

    salvaClinicas();
});

//função de LOGIN
clinicasRouter.post('/loginClinica', (req, res, next)=>{

    async function Login(){
    try {
        var user = await Clinicas.findOne({ email: req.body.email}).exec();
        if(!user) {
            return res.status(400).send({ message: "Email inválido/inexistente"});
        }
        if(!bcrypt.compareSync(req.body.senha, user.senha)){
            return res.status(400).send({ message: "Senha Incorreta"});
        }

        //tudo ok
        return res.status(201).send({ message: "Logado com sucesso!"});
    } catch (erro) {
        res.status(416).send({ message: "Algo de errado aconteceu"});
    }
}
    Login();
});

//função de DELETAR uma CLÍNICA
clinicasRouter.delete('/clinicas/:id', (req, res, next)=>{

    async function deletarClinicas(){
        Clinicas.findByIdAndDelete(req.params.id).then((clinicas) => {
            if(clinicas){
                res.status(200).send({ message: "Deletado com sucesso"});
            } else{
                res.status(404).send({ message: "Registro não encontrado"});
            }
        }).catch((erro) => {
            if(erro){
                res.status(417).send({ message: "Falha ao deletar registro"});
                throw erro;
            }
        });
    }

    deletarClinicas();

});

//função de ATUALIZAR clinicas
clinicasRouter.put('/clinicas/:id', (req, res, next)=>{

    async function atualizarClinicas(){
        try{
            Clinicas.findByIdAndUpdate(req.params.id, req.body, function(erro) {
                if (erro) {
                    res.send(erro);
                }
                res.status(201).send("Atualizado com sucesso!");
            });
        } catch{
            res.status(417).send("Algo deu errado");
        }

};

atualizarClinicas();
});

module.exports = clinicasRouter;
