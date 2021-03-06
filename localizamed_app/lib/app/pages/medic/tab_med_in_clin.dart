import 'package:flutter/material.dart';
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:localizamed_app/app/pages/clinic/clinica.bloc.dart';

class MedCardInClin extends StatefulWidget {
  @override
  _MedCardState createState() => _MedCardState();
}

class _MedCardState extends State<MedCardInClin> {
  ConexaoAPI conexaoApi;

  @override
  void initState() {
    clinicaBloc.getClinica();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: (context, constrains) {
        return Container(
            margin: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0,
            ),
            child: StreamBuilder(
                stream: clinicaBloc.clinica,
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
                      itemCount: snapshot?.data?.medicosClin?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String image;
                        String _setImage() {
                          if (snapshot.data.medicosClin[index]
                                        .medicoIdClass.temFoto == '0' &&
                              snapshot.data.medicosClin[index]
                                        .medicoIdClass.sexo == 'M') {
                            image = 'images/homem_medico.png';
                          } else if (snapshot.data.medicosClin[index]
                                        .medicoIdClass.temFoto ==
                                  '0' /*|| snapshot.data[index].temFoto == '1' */ &&
                              snapshot.data.medicosClin[index]
                                        .medicoIdClass.sexo != 'M') {
                            image = 'images/mulher_medico.png';
                          } else {
                            image = 'images/placeholder.png';
                          }
                          return image;
                        }

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
                                            color: Colors.redAccent,
                                            width: 3))),
                                child: ListTile(
                                  title: Text(
                                    snapshot.data.medicosClin[index]
                                        .medicoIdClass.nome,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    snapshot.data.medicosClin[index]
                                        .medicoIdClass.especialidade,
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
                                      image: snapshot.data.medicosClin[index]
                                                  .medicoIdClass.caminhoFoto ==
                                              null
                                          ? AssetImage(_setImage())
                                          : NetworkImage(snapshot
                                              .data
                                              .medicosClin[index]
                                              .medicoIdClass
                                              .caminhoFoto),
                                    )),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }));
      },
    );
  }
}
