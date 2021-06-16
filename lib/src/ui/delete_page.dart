import 'package:app/src/blocs/scrum_blocs.dart';
import 'package:app/src/model/scrum_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeletePage extends StatelessWidget {
  final _bloc = ScrumBlocs();
  final _textFieldController = TextEditingController();
  late  String id = "";

  @override
  Widget build(BuildContext context) {
    _textFieldController.addListener(() {
      id = _textFieldController.text;
    });

     _delete() {
      _bloc.deleteMethod(id: id);
    }

    Future<void> _showMyAlert(String msg1, msg2) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(msg1),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(msg2),
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
      appBar: AppBar(
        title: Text('DELETE PAGE'),
      ),
      body: SafeArea(
        child: Container(
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(fontSize: 25.0),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 20.0),
                    labelText: 'Informe o ID para deletar uma Sprint',
                    helperStyle: TextStyle(fontSize: 20.0),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _textFieldController,
                ),
                ElevatedButton(onPressed: () => {
                  if(id != "") {
                    _delete(),
                    _showMyAlert("SUCESSO", "Sprint Deletada")
                  }else {
                   _showMyAlert("ERRO", "Nenhum ID foi informado")
                  }
                },
                child: Text("DELETAR")
                ),
              ],
            )
        ),
      ),
    );
  }
}