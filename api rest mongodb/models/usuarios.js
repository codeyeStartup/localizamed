const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const UserSchema = new Schema({
    nome:{
        type: String,
        required: true,
        maxlength: 80
    },
    email:{
        type: String,
        required: true,
        maxlength: 80
    },
    senha:{
        type: String,
        required: true,
        maxlength: 100
    },
    logradouro:{
        type: String,
        required: true,
        maxlength: 50
    },
    bairro:{
        type: String,
        required: true,
        maxlength: 50
    },
    uf:{
        type: String,
        required: true,
        maxlength: 2
    },
    fone_1:{
        type: String,
        required: true,
        maxlength: 15
    },
    fone_2:{
        type: String,
        maxlength: 15
    },
    cpf:{
        type: String,
        maxlength: 11
    },
    rg:{
        type: String,
        maxlength: 14
    },
    caminho_foto:{
        type: String,
        maxlength: 100
    },
    /* data_cadastro:{
        type: Date,
        default: Date.now
    }, 
    data_atualizacao:{
        type: Date,
        default: Date.now
    }, */
    data_nascimento:{
        type: Date,
        required: true        
    }, 
     
},
    //timestamps fornece a data de cadastro e atualização
    {
        timestamps: true
    }
);

module.exports = mongoose.model('usuarios', UserSchema);
