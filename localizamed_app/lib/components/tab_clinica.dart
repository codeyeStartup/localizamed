import 'package:flutter/material.dart';
import 'package:localizamed_app/blocs/clinica.bloc.dart';
import 'package:localizamed_app/blocs/conexaoAPI.dart';
import 'package:localizamed_app/classes/clinica_class.dart';
import 'package:localizamed_app/screens/clinic_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClinCard extends StatefulWidget {

  @override
  _ClinCardState createState() => _ClinCardState();
}

class _ClinCardState extends State<ClinCard> {

  @override
  void initState(){
    clinicaBloc.getListClinicas();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {    
    double c_width = MediaQuery.of(context).size.width * 0.0;

    return new Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 24.0,
      ),
      child: StreamBuilder(
          stream: clinicaBloc.clinicasList,
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
                  return GestureDetector(
                    onTap: () async {
                      SharedPreferences prefId =
                          await SharedPreferences.getInstance();
                      prefId.setString('id', snapshot.data[index].id);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ClinicScreen()));
                    },
                    child: Stack(
                      children: <Widget>[
                        //card da CLINICA
                        Container(
                          height: 130.0,
                          width: 410.0,
                          margin: new EdgeInsets.only(left: 10.0, top: 20),
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
                            // padding: EdgeInsets.only(left: 0, top: 0),
                            padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.green, width: 3.0))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.star_border,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    snapshot.data[index].nome,
                                    style: TextStyle(fontSize: 20),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                  ),
                                  subtitle: Text(
                                    snapshot.data[index].cidade,
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //IMAGEM
                        Container(
                          margin: EdgeInsets.only(
                            left: 15,
                          ),
                          child: Container(
                            height: 120,
                            width: 120,
                            margin: EdgeInsets.only(
                              bottom: 0,
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(270)),
                                image: DecorationImage(
                                  image: NetworkImage(ConexaoAPI().api +
                                      'imagensClinica/' +
                                      snapshot.data[index].caminhoFoto),
                                  fit: BoxFit.fill,
                                )),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
