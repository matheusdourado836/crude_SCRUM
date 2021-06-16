import 'dart:convert';

import 'package:app/src/model/scrum_model.dart';
import 'package:http/http.dart';

class ScrumApiProvider {
  final client = Client();
  final baseUrl = 'https://scrum-deck-backend.herokuapp.com/sprint/';

  Future getMethod() async {
    List lista;
    final response = await client.get(Uri.parse(baseUrl));
    lista = json.decode(response.body);
    if(response.statusCode == 200 || response.statusCode < 300) {
      return lista;
    }else {
      throw Exception('Erro ao recuperar os dados. Status: ${response.statusCode}');
    }
  }

  Future<ScrumModel> getById(String id) async {
    final response = await client.get(Uri.parse('$baseUrl$id'));
    if(response.statusCode == 200 || response.statusCode < 300) {
      return ScrumModel.fromJson(json.decode(response.body));
    }else {
      throw Exception('Erro ao recuperar o id. Status: ${response.statusCode}');
    }
  }

  Future<ScrumModel> postMethod(String nome, String link) async {
    final response = await client.post(
        Uri.parse('https://scrum-deck-backend.herokuapp.com/sprint/'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body:jsonEncode({
          'nome': nome,
          'link': link
        }));

    if(response.statusCode == 200 || response.statusCode < 300) {
      return ScrumModel.fromJson(json.decode(response.body));
    }else {
      throw Exception('Erro ao fazer o post. Status: ${response.statusCode}');
    }
  }

  Future deleteMethod(String id) async {
      final response = await client.delete(Uri.parse('$baseUrl$id'));
      if(response.statusCode == 200 || response.statusCode < 300) {
        return response.statusCode;
      }else {
        return response.statusCode;
      }
  }
}