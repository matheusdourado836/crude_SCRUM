import 'package:app/src/model/scrum_model.dart';
import 'package:app/src/resources/scrum_api_provider.dart';

class Repository {
  final scrumApiProvider = ScrumApiProvider();

  Future getMethod() => scrumApiProvider.getMethod();
  Future<ScrumModel> getById(String id) => scrumApiProvider.getById(id);
  Future<ScrumModel> postMethod(String nome, String link) => scrumApiProvider.postMethod(nome, link);
  Future deleteMethod(String id) => scrumApiProvider.deleteMethod(id);
}