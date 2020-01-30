const express = require('express');
const Clinicas = require("../models/clinicas");

const pesquisaRouter = express.Router();

pesquisaRouter.post('/search_clinica', (req, res, next) => {

    const search = req.body.search;

    /* async function AllClinicas() {
        Clinicas.find({
            nome:{
                $regex: new RegExp(search, "i")
            }
        }, (erro, dados) => {
            if(erro){
                res.status(417).send({ message: "Nothing"});
            }
            res.status(201);
            res.json(dados);
        });
        
    } */

    async function AllClinicas() {
        Clinicas.find({
            $or: [
                {
                    nome: {
                        $regex: new RegExp(search, "i")
                    },
                    cidade: {
                        $regex: new RegExp(search, "i")
                    }
                }
            ]

        }, (erro, dados) => {
            if (erro) {
                res.status(417).send({ message: "Nothing" });
            }
            res.status(201);
            res.json(dados);
        });

    }

    AllClinicas();
});

pesquisaRouter.get('/search_clinica2/:search', (req, res, next) => {

    const search = req.params.search;

    async function AllClinicas() {
        Clinicas.find({
            nome: {
                $regex: new RegExp(search, "i")
            }
        }, (erro, dados) => {
            if (erro) {
                res.status(417).send({ message: "Nothing" });
            }
            res.status(201);
            res.json(dados);
        });

    }

    AllClinicas();
});

module.exports = pesquisaRouter;

/* var name = 'Peter';
    db.User.find({name:{
                         $regex: new RegExp(name, "ig")
                     }
                },function(err, doc) {
                                     //Your code here...
              });
 */
