import 'package:app/src/blocs/scrum_blocs.dart';
import 'package:app/src/model/scrum_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  final _textFieldNome = TextEditingController();
  final _textFieldLink = TextEditingController();
  late  String nome = "";
  late  String link = "";
  final _bloc = ScrumBlocs();

  @override
  Widget build(BuildContext context) {
    _textFieldNome.addListener(() {
      nome = _textFieldNome.text;
    });
    _textFieldLink.addListener(() {
      link = _textFieldLink.text;
    });

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ERRO'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Não foi possível realizar o POST.'),
                  Text('Verifique se os dados foram inseridos corretamente'),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
            appBar: AppBar(title: Text('POST PAGE')),
            body: SafeArea(
              child: Container(
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(fontSize: 25.0),
                      decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 20.0),
                      labelText: 'Informe o nome da Sprint',
                      helperStyle: TextStyle(fontSize: 20.0),
                    ),
                    controller: _textFieldNome,
                  ),
                    TextFormField(
                      style: TextStyle(fontSize: 25.0),
                      decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 20.0),
                      labelText: 'Informe o link da Sprint',
                      helperStyle: TextStyle(fontSize: 20.0),
                  ),
                    controller: _textFieldLink,
                  ),
                    ElevatedButton(onPressed: () async {
                      if (!link.contains("http")) {
                        return _showMyDialog();
                      }else
                        _bloc.postMethod(nome: nome, link: link);
                    }, child: Text("POST")),
                    Container(
                      child: StreamBuilder(
                        stream: _bloc.postBody,
                        builder: (context, AsyncSnapshot<ScrumModel> snapshot) {
                          if(snapshot.hasData) {
                            final data = snapshot.data!;
                            return Column(
                              children: [
                                Text("POST REALIZADO:", style: TextStyle(fontSize: 25.0)),
                                Divider(),
                                Text('id: ${data.id}', style: TextStyle(fontSize: 20.0)),
                                Text('link: ${data.link}', style: TextStyle(fontSize: 20.0)),
                                Text('nome: ${data.nome}', style: TextStyle(fontSize: 20.0))
                              ],
                            );
                          }
                          if (snapshot.hasError) {
                            return Text('Ocorreu um erro!\n${snapshot.error}');
                          }
                          return StreamBuilder(
                              stream: _bloc.carregando,
                              builder: (context, AsyncSnapshot<bool> snapshot) {
                                final carregando = snapshot.data ?? false;
                                if (carregando) {
                                  return CircularProgressIndicator();
                                }else {
                                  return Container();
                                }
                              }
                          );
                        },
                      ),
                    ),
                  ],
                )
              ),
            ),
          );
  }
}
