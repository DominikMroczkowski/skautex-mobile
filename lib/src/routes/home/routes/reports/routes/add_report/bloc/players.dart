import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/helpers/blocs/access.dart';

class Players with Access {
	final _repository = Repository();

	final _playersOutput  = BehaviorSubject<Future<List<Player>>>();
	final _playersFetcher = BehaviorSubject<String>();

	get fetchPlayers => _playersFetcher.sink.add;
	get players => _playersOutput.stream;

	Players() {
		_playersFetcher.transform(_fetch()).pipe(_playersOutput);
	}

	_fetch() {
		return StreamTransformer<String, Future<List<Player>>>.fromHandlers(
			handleData: (stringus , sink) {
				//sink.add(_repository.fetchItems<Player>(otp, where: {"surname__contains" : stringus}));
			}
		);
	}

	dispose() {
		_playersOutput.close();
		_playersFetcher.close();
	}
}
