import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/jwt.dart';
import '../../resources/repository.dart';
import '../../models/player.dart';
import '../session/bloc.dart' as session;
import '../players/bloc.dart' as players;

import 'provider.dart';
export 'provider.dart';

class Bloc {
	final _repository    = Repository();
	final _playerOutput  = BehaviorSubject<Future<Player>>();
	final _playerFetcher = PublishSubject<Object>();

	BehaviorSubject<String> _clicked;
	BehaviorSubject<Future<JWT>> _access;

	get player => _playerOutput.stream;

	Function(Object) get fetchPlayer => _playerFetcher.sink.add;

	Bloc(context) {
		_access = session.Provider.of(context).otp;
		_clicked = session.Provider.of(context).clicked;
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

	dispose() {
  	_playerOutput.close();
		_playerFetcher.close();
	}
}
