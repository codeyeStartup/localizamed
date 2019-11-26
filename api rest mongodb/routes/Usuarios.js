const express = require('express');
const Usuarios = require("../models/usuarios");
const bcrypt = require('bcryptjs');
const SALT_WORK_FACTOR = 10;


const usuarioRouter = express.Router();

//função de RETORNAR TODOS os usuários
usuarioRouter.get('/usuarios', (req, res, next)=>{
    async function AllUsuarios(){
        Usuarios.find({}, (erro, dados) => {
            if(erro){
                res.status(417).send({ message: "Nenhum registro recebido"});
            }
            res.status(200);
            res.json(dados);
        });
    }

    AllUsuarios();
});

//função para RETORNAR UM ÚNICO USUÁRIO PELO ID
usuarioRouter.get('/usuario/:id', (req, res, next) => {
    async function findUsuario(){
        Usuarios.findById(req.params.id).then((usuario) => {
            res.status(200);
            res.json(usuario);
        }).catch((erro) => {
            if(erro){
                res.status(417).send({ message: "Nenhum usuário encontrado"});
                throw erro;
            }
        });
    }

    findUsuario();
});

//função para RETORNAR USUÁRIO PELO RANGE
usuarioRouter.get('/usuarioFindOne/:email', (req, res, next) => {
    async function GetUser(){
    Usuarios.findOne({ email: req.params.email}).then((usuario) => {
            res.status(200);
            res.json(usuario);
        }).catch((erro) => {
            if(erro){
                res.status(417).send({ message: "Nenhum usuário encontrado"});
                throw erro;
            }
        });
   
}
    GetUser();
});

//função de INSERIR dados no banco
usuarioRouter.post('/usuarios', (req, res, next)=>{

    async function salvaUsuario(){
        const usuarios = new Usuarios({
            nome: req.body.nome,
            email: req.body.email,
            data_nascimento: req.body.data_nascimento,
            senha: bcrypt.hashSync(req.body.senha, 10),
            //senha: req.body.senha,
            //logradouro: req.body.logradouro,
            //bairro: req.body.bairro,
            cidade: req.body.cidade,
            uf: req.body.uf,
            fone_1: req.body.fone_1,
            fone_2: req.body.fone_2,
            cpf: req.body.cpf,
            rg: req.body.rg,
            //caminho_foto: req.body.caminho_foto,
            });

        try{
            const result = await usuarios.save();
            console.log("Operação realizada com sucesso");
            res.status(201).send({ message: "Cadastrado com sucesso!"});
            //console.log(usuarios)
            /* res.statusCode = 201;
            res.send(); */
        } catch(erro){
            console.log(erro.message);
            res.status(406).send({ message: "Cadastro falhou"});
            /* res.statusCode = 406;
            res.send(); */
        }
    }

    salvaUsuario();
});

//função de LOGIN
usuarioRouter.post('/login', (req, res, next)=>{

    async function Login(){
    try {
        var user = await Usuarios.findOne({ email: req.body.email}).exec();
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

//função de DELETAR um usuário
usuarioRouter.delete('/usuario/:id', (req, res, next)=>{

    async function deletarUsuario(){
        Usuarios.findByIdAndDelete(req.params.id).then((usuario) => {
            if(usuario){
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

    deletarUsuario(); 

});


//função de ATUALIZAR um usuário
usuarioRouter.put('/usuario/:id', (req, res, next)=>{

    async function atualizarUsuario(){
        try{
            Usuarios.findByIdAndUpdate(req.params.id, req.body, function(erro) {
                if (erro) {
                    res.send(erro);
                }
                res.status(201).send("Atualizado com sucesso!");
            });
        } catch{
            res.status(417).send("Algo deu errado");
        }

};

atualizarUsuario();
});

module.exports = usuarioRouter;
