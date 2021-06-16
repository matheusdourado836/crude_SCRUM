import 'package:app/src/blocs/scrum_blocs.dart';
import 'package:app/src/model/scrum_model.dart';
import 'package:app/src/ui/get_page.dart';
import 'package:app/src/ui/post_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'delete_page.dart';

class CrudeScrum extends StatelessWidget {
  final _bloc = ScrumBlocs();
  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _textFieldController.addListener(() {
      _bloc.getById(byId: _textFieldController.text);
    });

    void _goToPost() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => GetPage()));
    }

    void _goToDelete() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => DeletePage()));
    }

    return Scaffold(
        appBar: AppBar(
        title: Text('GET by ID'),
       ),
      body: SafeArea(
        child: Container(
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(fontSize: 25.0),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 20.0),
                    labelText: 'Informe o ID para recuperar uma Sprint',
                    helperStyle: TextStyle(fontSize: 15.0),
                    helperText: 'somente números',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _textFieldController,
                ),
                Divider(),
                Container(
                  child: StreamBuilder(
                    stream: _bloc.ultimoIdObtido,
                    builder: (context, AsyncSnapshot<ScrumModel> snapshot) {
                      if(snapshot.hasData) {
                        final data = snapshot.data!;
                        return Column(
                          children: [
                            Text('id: ${data.id}', style: TextStyle(fontSize: 25.0)),
                            Text('link: ${data.link}', style: TextStyle(fontSize: 25.0)),
                            Text('nome: ${data.nome}', style: TextStyle(fontSize: 25.0)),
                            Divider()
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
                 ElevatedButton(
                   child: Text("GET Sprints"),
                   onPressed: () => _goToPost(),
                 ),
                ElevatedButton(
                   onPressed: () => _goToDelete(),
                   child: Text("Deletar Sprint")
                ),
              ],
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage()));
      },
          tooltip: 'Adicionar Sprint',
          child: const Icon(Icons.add)

      ),
    );
  }
}