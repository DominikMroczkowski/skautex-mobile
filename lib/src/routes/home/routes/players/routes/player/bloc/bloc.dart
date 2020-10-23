import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/jwt.dart';
import 'package:skautex_mobile/src/helpers/blocs/delete.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/bloc/bloc.dart' as session;

import 'provider.dart';
export 'provider.dart';

class Bloc {
	final _repository    = Repository();
	final _playerOutput  = BehaviorSubject<Future<Player>>();
	final _playerFetcher = PublishSubject<Object>();
	final _deactivate    = Delete();

	BehaviorSubject<String> _clicked;
	BehaviorSubject<Future<JWT>> _access;

	get player => _playerOutput.stream;
	get deactivateOutput => _deactivate.item;

	Function(Object) get fetchPlayer => _playerFetcher.sink.add;

	Bloc(context) {
		_access = session.Provider.of(context).otp;
		_clicked = session.Provider.of(context).clicked;
		_deactivate.otp = context;
		_playerFetcher.transform(_playerTransfor()).pipe(_playerOutput);
	}

	_playerTransfor() {
		return StreamTransformer<Object, Future<Player>>.fromHandlers(
			handleData: (_, sink) {
				final uri = _clicked.value;
				if (uri == null) {
					print("Uri is equal null");
				}
				sink.add(_repository.fetchPlayer(_access.value, uri));
			}
		);
	}

	deactivate() async {
		player.listen(
			(future) async {
				Player _val = await future;
				_deactivate.addItem(_val.uri);
			}
		);
	}


	dispose() {
  	_playerOutput.close();
		_playerFetcher.close();
	}
}
