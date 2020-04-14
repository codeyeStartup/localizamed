import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localizamed_app/app/pages/clinic/clinica.bloc.dart';
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:localizamed_app/app/pages/clinic/clinic_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialCard extends StatefulWidget {

  @override
  _InitialCardState createState() => _InitialCardState();
}

class _InitialCardState extends State<InitialCard> {
  @override
  void initState(){
    clinicaBloc.getUltimasClinicas();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 40,
          right: MediaQuery.of(context).size.width / 40),
      height: MediaQuery.of(context).size.height / 1.9,
      child: StreamBuilder(
          stream: clinicaBloc.ultimasclinicasList,
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
                    width: 30,
                  );
                },
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      SharedPreferences prefId =
                          await SharedPreferences.getInstance();
                      prefId.setString('id', snapshot.data.clinicas[index].sId);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ClinicScreen()));
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 60,
                        ),
                        //height 1.9
                        width: MediaQuery.of(context).size.width / 1.3,
                        height: MediaQuery.of(context).size.height / 1.9,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(ConexaoAPI().api +
                                  'imagensClinica/' +
                                  snapshot.data.clinicas[index].caminhoFoto),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                offset: new Offset(4.0, 4.0),
                                blurRadius: 5,
                              )
                            ]),
                        child: Stack(
                          children: <Widget>[
                            //TRAÇO AZUL que fica no meio
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(300),
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 250,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )),

                            //CAIXA BRANCA que fica embaixo
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(500),
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height /
                                        3.4,
                                    //3.4
                                    color: Colors.white,
                                  ),
                                )),

                            //NOME da clinica
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3.3,
                                left: snapshot
                                            .data.clinicas[index].nome.length <=
                                        8
                                    ? MediaQuery.of(context).size.width / 2.2
                                    : MediaQuery.of(context).size.width / 3.6,
                              ),
                              child: Text(
                                snapshot.data.clinicas[index].nome,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Breeserif',
                                    fontSize: 25),
                              ),
                            ),

                            //CIDADE
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 2.8,
                                  left: snapshot.data.clinicas[index].nome
                                              .length <=
                                          8
                                      ? MediaQuery.of(context).size.width / 2.2
                                      : MediaQuery.of(context).size.width /
                                          3.6),
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.green, width: 2))),
                                  child: Text(
                                    snapshot.data.clinicas[index].cidade,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Breeserif',
                                        fontSize: 18),
                                  )),
                            ),
                          ],
                        )),
                  );
                },
              );
            }
          }),
    );
  }
}
