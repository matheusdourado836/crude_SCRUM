import 'package:app/src/blocs/scrum_blocs.dart';
import 'package:flutter/material.dart';

class GetPage extends StatelessWidget {
  final _bloc = ScrumBlocs();

  @override
  Widget build(BuildContext context) {
  _bloc.getMethod();

    return Scaffold(
      appBar: AppBar(
        title: Text('GET PAGE'),
      ),
      body: Container(
        child: StreamBuilder(
            stream: _bloc.getObtido,
            builder: (context, AsyncSnapshot snapshot) {
              if(snapshot.hasData) {
                final data = snapshot.data!;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      if (i.isOdd) {
                        Divider();
                        return ListTile(
                          title: Text(data[i].toString()),
                        );
                      }else
                        return ListTile(
                          title: Text(data[i].toString()),
                        );
                });
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
                },
              );
            }
        ),
      ),
    );
  }
  
}