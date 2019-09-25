const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const UserSchema = new Schema({
  //cod_planosaude:{type:Integer},
  nome:{type:String},
  data_cadastro:{type:Date},
  data_atualizacao:{type:Date}
},
  {
    timestamps: true
  }
);

module.exports = mongoose.model('plano_de_saude', UserSchema);
