const app = require('express')();
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs'); 
var mongodb = require('mongodb');
//const ModelUsuario = require('./models/usuarios');

//body-parser
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

//let _db = null;
//conexão com o banco
mongoose.connect('mongodb+srv://localizamed:startup2019@cluster0-b3dwf.mongodb.net/db_localizamed?retryWrites=true&w=majority', {
    useNewUrlParser: true,
    useUnifiedTopology: true      
}, () => {   
    console.log("banco conectado");
}); 

//-->ENDPOINTS
const usuariosRouter = require("../routes/Usuarios");
const clinicaRouter = require("../routes/Clinicas");
const medicoRouter = require("../routes/Medicos");
const exames_consultasRouter = require("../routes/Exames_Consultas");
const planos_de_saudeRouter = require("../routes/Planos_de_saude");

app.use(usuariosRouter);
app.use(clinicaRouter); 
app.use(medicoRouter);
app.use(exames_consultasRouter);
app.use(planos_de_saudeRouter);


module.exports = app;