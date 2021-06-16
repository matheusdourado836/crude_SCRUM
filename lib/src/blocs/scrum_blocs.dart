import 'package:app/src/model/scrum_model.dart';
import 'package:app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ScrumBlocs {
  final _repository = Repository();
  final _idFetcher = PublishSubject<ScrumModel>();
  final _getFetcher = PublishSubject();
  final _postFetcher = PublishSubject<ScrumModel>();
  final _idDeleteFetcher = PublishSubject();
  final _carregando = PublishSubject<bool>();

  Stream get getObtido => _getFetcher.stream;
  Stream<ScrumModel> get ultimoIdObtido => _idFetcher.stream;
  Stream<ScrumModel> get postBody => _postFetcher.stream;
  Stream get idDelete => _idDeleteFetcher.stream;
  Stream<bool> get carregando => _carregando.stream;

  getMethod() async {
    final getObtido = await _repository.getMethod();
    _carregando.sink.add(false);
    _getFetcher.sink.add(getObtido);

    await _getFetcher.drain();
  }

  getById({required String byId}) async {
    if(byId.length < 4) {
      final idObtido = await _repository.getById(byId);
      _carregando.sink.add(false);
      _idFetcher.sink.add(idObtido);
    }
      await _idFetcher.drain();
  }

  postMethod({required String nome, required String link}) async {
    final dataReceived = await _repository.postMethod(nome, link);
    _carregando.sink.add(false);
    _postFetcher.sink.add(dataReceived);

    await _postFetcher.drain();
  }

  deleteMethod({required String id}) async {
    if(id.length < 4) {
      final idObtido = await _repository.deleteMethod(id);
      _carregando.sink.add(false);
      _idDeleteFetcher.sink.add(idObtido);
    }
    await _idDeleteFetcher.drain();
  }

  dispose() {
    _idFetcher.close();
    _getFetcher.close();
    _postFetcher.close();
    _idDeleteFetcher.close();
    _carregando.close();
  }

}