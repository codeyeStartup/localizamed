const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const UserSchema = new Schema({
  //cod_medico:{type:Integer},
  nome:{
    type: String,
    required: true,
    maxlength: 80  
  },
  formacao:{
    type: String, 
    required: true,
    maxlength: 200
  },
  crm:{
    type: String, 
    required: true,
    maxlength: 10
  },
  caminho_foto:{
    type: String,
    //required: true,
    maxlength: 100
  },
  cidade:{
    type: String,
    maxlength: 100
  }
  /* data_cadastro:{
    type: Date,
    default: Date.now
  }, 
  data_atualizacao:{
    type: Date,
    default: Date.now
  }, */
},
    //timestamps fornece a data de cadastro e atualização
  {
    timestamps: true 
  }
);

module.exports = mongoose.model('medicos', UserSchema);
