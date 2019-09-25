const express = require('express');
const Medicos = require("../models/medicos");
const bcrypt = require('bcryptjs');
const SALT_WORK_FACTOR = 10;


const medicoRouter = express.Router();

//função de RETORNAR TODOS os médicos
medicoRouter.get('/medicos', (req, res, next)=>{
    async function AllMedicos(){
        Medicos.find({}, (erro, dados) => {
            if(erro){
                res.status(417).send({ message: "Nenhum registro recebido"});
            }
            res.status(200);
            res.json(dados);
        });
    }

    AllMedicos();
});

//função para RETORNAR UM ÚNICO médico pelo id
medicoRouter.get('/medico/:id', (req, res, next) => {
    async function findMedico(){
        Medicos.findById(req.params.id).then((medico) => {
            res.status(200);
            res.json(medico);
        }).catch((erro) => {
            if(erro){
                res.status(417).send({ message: "Nenhum médico encontrado"});
                throw erro;
            }
        });
    }

    findMedico();
});

//função de INSERIR dados no banco
medicoRouter.post('/medicos', (req, res, next)=>{

    async function salvaMedico(){
        const medicos = new Medicos({
            nome: req.body.nome,
            formacao: req.body.formacao,
            crm: req.body.crm,
            caminho_foto: req.body.caminho_foto,
            data_atualizacao: null
            });


        try{
            const result = await medicos.save();
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

    salvaMedico();
});

//função de DELETAR um médico
medicoRouter.delete('/medico/:id', (req, res, next)=>{

    async function deletarMedico(){
        Medicos.findOneAndDelete(req.params.id).then((medico) => {
            if(medico){
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

    deletarMedico();

});

//função de ATUALIZAR medicos
medicosRouter.put('/medicos/:id', (req, res, next)=>{

    async function atualizarMedicos(){
        try{
            Medicos.findByIdAndUpdate(req.params.id, req.body, function(erro) {
                if (erro) {
                    res.send(erro);
                }
                res.status(201).send("Atualizado com sucesso!");
            });
        } catch{
            res.status(417).send("Algo deu errado");
        }

};

atualizarMedicos();
});

//ATUALIZAR médico


module.exports = medicoRouter;
