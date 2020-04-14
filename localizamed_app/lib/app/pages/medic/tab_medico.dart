import 'package:flutter/material.dart';
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:localizamed_app/app/pages/medic/medicos_bloc.dart';

class MedCard extends StatefulWidget {

  @override
  _MedCardState createState() => _MedCardState();
}

class _MedCardState extends State<MedCard> {
  ConexaoAPI conexaoApi;
  //MedicosBloc medicosBloc;

  @override
  void initState(){
    //medicosBloc = new MedicosBloc();
    medicoBloc.getMedicos();
    super.initState();
  }

  @override
  void dispose(){
    //medicoBloc.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    //medicoBloc.getMedicos();    
    return new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: StreamBuilder(
            stream: medicoBloc.medico,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ));
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 15,
                    );
                  },
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot?.data?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: <Widget>[
                        Container(
                          height: 124.0,
                          width: 300.0,
                          margin: new EdgeInsets.only(left: 46.0),
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: new BorderRadius.circular(8.0),
                              boxShadow: <BoxShadow>[
                                new BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 5.0,
                                  offset: new Offset(2.0, 5.0),
                                )
                              ]),
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.only(left: 50),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.redAccent, width: 3))),
                            child: ListTile(
                              title: Text(
                                snapshot.data[index].nome,
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(
                                snapshot.data[index].especialidade,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: new EdgeInsets.symmetric(vertical: 16.0),
                          alignment: FractionalOffset.centerLeft,
                          child: new Container(
                            height: 95,
                            width: 95,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(270)),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: snapshot.data[index].temFoto == '0'
                                      ? snapshot.data[index].sexo == 'M'
                                          ? AssetImage(
                                              "images/homem_medico.png")
                                          : AssetImage(
                                              "images/mulher_medico.png")
                                      : NetworkImage(ConexaoAPI().api +
                                          'imagens/' +
                                          snapshot.data[index].caminhoFoto),
                                )),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            }));
  }
}