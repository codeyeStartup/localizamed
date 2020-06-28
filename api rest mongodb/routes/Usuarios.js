const express = require('express');
const Usuarios = require("../models/usuarios");
const usuarioController = require('../controllers/usuarioController');
const bcrypt = require('bcryptjs');
const usuarioRouter = express.Router();
const nodemailer = require('nodemailer');
const cloudinary = require('cloudinary').v2;
const smtpTrans = require('nodemailer-smtp-transport');
const path = require('path');
const date1 = new Date();
const dma = `${date1.getDate()}-${date1.getMonth()}-${date1.getFullYear()}`
// require('dotenv/config');


//função para enviar EMAIL DE RECUPERAÇÃO DE SENHA
usuarioRouter.post('/send_mail', async (req, res, next) => {
    try {
        const user = await Usuarios.findOne({ email: req.body.email }).exec();
        if (!user) {
            return res.status(400).send({ message: "Email inválido/inexistente" });
        }

        const transporter = nodemailer.createTransport(smtpTrans({
            service: 'gmail',
            auth: {
                user: process.env.EMAIL,
                pass: process.env.PASSWORD
            },
            tls: { rejectUnauthorized: false }
        }));        

        // const url = `${process.env.IP_ADDRESS_PORT}/update_pass_get/?email=${req.body.email}`;
        const url = `http://${process.env.IP_ADDRESS}/update_pass_get/?email=${req.body.email}`;
        const mailOptions = {
            from: 'Localizamed <no-reply@localizamed.com.br>',
            to: req.body.email,
            subject: 'Recuperação de senha',
            html: `<html>

            <body style="
                            align-content: center;
                            font-family: 'Arial';
                            ">
                <div class="container" style="  
                                background-color: white;
                                padding: 20;
                                text-align: center;
                                font-size: 0.9em;
                                text-decoration-color: black;
                                ">
                    <h3>Este é um e-mail de recuperação de senha</h3>
                    <p>Clique no botão para recuperar sua conta</p>
                    <a href="${url}"><button style="
                                    background-color: #1B49F3;
                                    color: white;
                                    border: none;
                                    font-size: 1.07em;
                                    font-weight: bold;
                                    border-radius: 0.4em;
                                    margin-bottom: 20;
                                    width: 180px;
                                    height: 50px;">
                            Atualizar Senha
                        </button></a>
                </div>
            </body>
            
            </html>`
        }

        transporter.sendMail(mailOptions, (erro, info) => {
            if (erro) console.log(erro)
            console.log(info)
            return res.status(201).send({ message: 'Enviado' })
        });
    } catch (error) {
        res.status(500)
    }
}
);

usuarioRouter.put('/update_pass/:email', async (req, res, next) => {
    try {
        Usuarios.findOneAndUpdate(
            { email: req.params.email },
            { senha: bcrypt.hashSync(req.body.senha.trim(), 10) },
            (erro) => {
                if (erro) {
                    res.status(417).send({ message: "Falha ao atualizar" });
                    throw erro;
                }
                console.log('fui atualizado')
                res.status(201).send("Atualizado com sucesso!");
            });
    } catch{
        res.status(417).send("Entrei no catch de erro");
    }
});

usuarioRouter.get('/update_pass_get', async (req, res, next) => {
    return res.sendFile(path.join(__dirname + '/../public/index.html'))
});


usuarioRouter.post('/update_pass_get/update', async (req, res, next) => {
    return res.sendFile(path.join(__dirname + '/../public/update_pass_confirm.html'))
});

//função de RETORNAR TODOS os usuários
usuarioRouter.get('/usuarios', (req, res, next) => {
    async function AllUsuarios() {
        Usuarios.find({}, (erro, dados) => {
            if (erro) {
                res.status(417).send({ message: "Nenhum registro recebido" });
            }
            res.status(200);
            res.json(dados);
        });
    }

    AllUsuarios();
});

//função para RETORNAR UM ÚNICO USUÁRIO PELO ID
usuarioRouter.get('/usuario/:id', (req, res, next) => {
    async function findUsuario() {
        Usuarios.findById(req.params.id).then((usuario) => {
            res.status(200);
            res.json(usuario);
        }).catch((erro) => {
            if (erro) {
                res.status(417).send({ message: "Nenhum usuário encontrado" });
                throw erro;
            }
        });
    }

    findUsuario();
});

//função para RETORNAR USUÁRIO PELO RANGE
usuarioRouter.get('/usuarioFindOne/:email', (req, res, next) => {
    async function GetUser() {
        Usuarios.findOne({ email: req.params.email }).then((usuario) => {
            res.status(200);
            res.json(usuario);
        }).catch((erro) => {
            if (erro) {
                res.status(417).send({ message: "Nenhum usuário encontrado" });
                throw erro;
            }
        });

    }
    GetUser();
});

//rotas das imagens
/* usuarioRouter.get('/imagensUsuario/:caminho_foto', (req, res, next) => {
    const img = req.params.caminho_foto;

    fs.readFile('./images/' + img, function (erro, content) {
        if (erro) {
            res.status(400).json(erro);
            return;
        }

        res.writeHead(200, { 'content-type': 'image/png' });
        res.end(content);
    });
}); */

usuarioRouter.patch('/usuario_image/:id', async (req, res, next) => {
    cloudinary.config({
        cloud_name: 'dpt5othex',
        api_key: '667378936985793',
        api_secret: 'KfoumTK2x1NgwXX0_KLdIdVR-J8'
    });

   async function AtualizarFotoUsuario(){
    try {
        const { id } = req.params;
        const date = new Date();
        time_stamp = date.getTime();

        
        const url_imagem = dma + '_' + time_stamp + '_' + req.files.caminho_foto.originalFilename;

        let { url, secure_url } = await cloudinary.uploader.upload(req.files.caminho_foto.path, {
            folder: `images/${id}/`,
            public_id: url_imagem,
            invalidate: true,
            overwrite: true
        });

        const usuarioImg = Usuarios.findByIdAndUpdate({_id: req.params.id},{ caminho_foto : secure_url.trim()});

        const ProfileUserImage = await usuarioImg;
        if (ProfileUserImage.errors) {
            
            return res.status(400).json(ProfileUserImage);
        }
        console.log('enviado com sucesso');
        return res.status(200).json(ProfileUserImage);


    } catch (error) {
        res.status(500).json(error);
        return console.log(error);
    }
   }

   return AtualizarFotoUsuario();
});

//função de INSERIR dados no banco
usuarioRouter.post('/usuarios', (req, res, next) => {

    async function salvaUsuario() {
        const usuarios = new Usuarios({
            nome: req.body.nome.trim(),
            email: req.body.email.trim(),
            data_nascimento: req.body.data_nascimento,
            senha: bcrypt.hashSync(req.body.senha.trim(), 10),
            //senha: req.body.senha,
            //logradouro: req.body.logradouro,
            //bairro: req.body.bairro,
            cidade: req.body.cidade.trim(),
            uf: req.body.uf.trim(),
            fone_1: req.body.fone_1.trim(),
            fone_2: req.body.fone_2.trim(),
            cpf: req.body.cpf.trim(),
            rg: req.body.rg.trim(),
            //caminho_foto: req.body.caminho_foto,
        });

        try {
            const result = await usuarios.save();
            console.log("Operação realizada com sucesso");
            res.status(201).send({ message: "Cadastrado com sucesso!" });
            //console.log(usuarios)
            /* res.statusCode = 201;
            res.send(); */
        } catch (erro) {
            console.log(erro.message);
            res.status(406).send({ message: "Cadastro falhou" });
            /* res.statusCode = 406;
            res.send(); */
        }
    }

    salvaUsuario();
});

//função de LOGIN
usuarioRouter.post('/login', (req, res, next) => {

    async function Login() {
        try {
            var user = await Usuarios.findOne({ email: req.body.email }).exec();
            if (!user) {
                return res.status(400).send({ message: "Email inválido/inexistente" });
            }
            if (!bcrypt.compareSync(req.body.senha, user.senha)) {
                return res.status(400).send({ message: "Senha Incorreta" });
            }

            //tudo ok
            return res.status(201).send({ message: "Logado com sucesso!" });
        } catch (erro) {
            res.status(416).send({ message: "Algo de errado aconteceu" });
        }
    }
    Login();
});

//função de DELETAR um usuário
usuarioRouter.delete('/usuario/:id', (req, res, next) => {

    async function deletarUsuario() {
        Usuarios.findByIdAndDelete(req.params.id).then((usuario) => {
            if (usuario) {
                res.status(200).send({ message: "Deletado com sucesso" });
            } else {
                res.status(404).send({ message: "Registro não encontrado" });
            }
        }).catch((erro) => {
            if (erro) {
                res.status(417).send({ message: "Falha ao deletar registro" });
                throw erro;
            }
        });
    }

    deletarUsuario();

});

usuarioRouter.patch('/usuarioUpdate/:email', (req, res, next) => {

    async function atualizarUsuario() {
        try {
            Usuarios.findOneAndUpdate(
                { email: req.params.email },
                req.body,
                function (erro) {
                    if (erro) {
                        res.status(417).send({ message: "Falha ao atualizar" });
                        throw erro;
                    }
                    console.log(req.body);
                    res.status(201).send("Atualizado com sucesso!");
                });
        } catch{
            res.status(417).send("Entrei no catch de erro");
        }

    };

    atualizarUsuario();
});

module.exports = usuarioRouter;
