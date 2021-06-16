// To parse this JSON data, do
//
//     final scrumModel = scrumModelFromJson(jsonString);

import 'dart:convert';

ScrumModel scrumModelFromJson(String str) => ScrumModel.fromJson(json.decode(str));

String scrumModelToJson(ScrumModel data) => json.encode(data.toJson());

class ScrumModel {
  ScrumModel({
    required this.id,
    required this.nome,
    required this.link,
  });

  int id;
  String nome;
  String link;

  factory ScrumModel.fromJson(Map<String, dynamic> json) => ScrumModel(
    id: json["id"] == null ? null : json["id"],
    nome: json["nome"] == null ? null : json["nome"],
    link: json["link"] == null ? null : json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "nome": nome == null ? null : nome,
    "link": link == null ? null : link,
  };
}
