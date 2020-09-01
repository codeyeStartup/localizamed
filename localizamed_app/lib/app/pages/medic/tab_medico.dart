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
  void initState() {
    //medicosBloc = new MedicosBloc();
    medicoBloc.getMedicos();
    super.initState();
  }

  @override
  void dispose() {
    //medicoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //medicoBloc.getMedicos();
    return new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 18.0,
          horizontal: 26.0,
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
                        height: MediaQuery.of(context).size.height / 30);
                  },
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot?.data?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String image;
                    String _setImage() {
                      if (snapshot.data[index].temFoto == '0' &&
                          snapshot.data[index].sexo == 'M') {
                        image = 'images/homem_medico.png';
                      } else if (snapshot.data[index].temFoto == '0' /*|| snapshot.data[index].temFoto == '1' */&&
                          snapshot.data[index].sexo != 'M') {
                        image = 'images/mulher_medico.png';
                      } else {
                        image = 'images/placeholder.png';
                      }
                      return image;
                    }

                    return Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 6.5,
                          width: MediaQuery.of(context).size.width / 1.3,
                          margin: new EdgeInsets.only(left: 46.0),
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: new BorderRadius.circular(8.0),
                              boxShadow: <BoxShadow>[
                                new BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5.0,
                                  offset: new Offset(2.0, 5.0),
                                )
                              ]),
                          child: Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 22),
                            padding: EdgeInsets.only(left: 50),
                            child: ListTile(
                                title: Text(
                                  snapshot.data[index].nome,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Montserrat-Bold',
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 3, bottom: 4),
                                      child: Text(
                                        snapshot.data[index].especialidade ==
                                                null
                                            ? 'Especialiade não informada'
                                            : snapshot
                                                .data[index].especialidade,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 6),
                                      color: Colors.redAccent,
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                      height: 2,
                                    )
                                  ],
                                )),
                          ),
                        ),
                        Container(
                          margin: new EdgeInsets.symmetric(vertical: 18),
                          alignment: FractionalOffset.centerLeft,
                          child: new Container(
                            height: MediaQuery.of(context).size.height / 9,
                            width: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(270)),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:
                                      snapshot.data[index].caminhoFoto == null
                                          ? AssetImage(_setImage())
                                          : NetworkImage(
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
