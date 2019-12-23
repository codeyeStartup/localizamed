const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const PlanosSaude_with_ClinicaExameConsultaSchema = new Schema({
   clinicaExameConsultaId: {
       type: mongoose.Schema.Types.ObjectId,
       ref: 'clin_exam_med'
   },
   planoDeSaude: {
       type: mongoose.Schema.Types.ObjectId,
       ref: 'plano_de_saude'
   },
},
    {
        timestamps: true
    }
);

module.exports = mongoose.model('planoSaude_ClinExamCons', PlanosSaude_with_ClinicaExameConsultaSchema);

