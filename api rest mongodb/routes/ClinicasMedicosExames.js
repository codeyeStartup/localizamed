const express = require('express');
const ClinicasMedicosExames = require("../models/clin_exam_med");
const fs = require('fs');

const clinMedExamRouter = express.Router();

//ROTORNAR TODOS os documentos
clinMedExamRouter.get('/clin_med_exam', (req, res, next) => {
    async function AllClinMedExam() {
        ClinicasMedicosExames.find({}, (erro, dados) => {
            if (erro) {
                res.status(417).send({ message: "Nenhum registro encontrado" });
            }
            res.status(200);
            res.json(dados);
        });
    }
    AllClinMedExam();
});

//retornar um DOCUMENTO específico
clinMedExamRouter.get('/clin_exam_med/:id', (req, res, next) => {
    async function findOne() {
        ClinicasMedicosExames.findById(req.params.id)
            .populate('clinicaId').populate('medico/medicoId')
            .populate('exame_consulta.exameConsultaId')
            .then((dados) => {
                res.status(200);
                res.json(dados);
            }).catch((erro) => {
                if (erro) {
                    res.status(417).send({ message: "nenhum registro encontrado" });
                    throw erro;
                }
            });
    }

    findOne();
});

//INSERIR UM NOVO registro
clinMedExamRouter.post('/clin_exam_med', (req, res, next) => {
    async function newData() {
        const data = new ClinicasMedicosExames({
            clinicaId: req.body.clinicaId
        });

        try {
            const result = await data.save();
            console.log("Operação realizada com sucesso");
            res.status(201).send({ message: "Cadastrado com sucesso!" });
        } catch (erro) {
            console.log(erro.message);
            res.status(406).send({ message: "Cadastro falhou" });
        }
    }
    
    newData();
});







