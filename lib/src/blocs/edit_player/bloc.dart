import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../add_player/bloc.dart' as add_player;
import 'package:skautex_mobile/src/models/player.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends add_player.Bloc  {

	final _uri  = BehaviorSubject<String>();
	final _updatePlayerOutput = BehaviorSubject<Future<Player>>();
	final _updatePlayerFetcher = BehaviorSubject<Object>();


	Stream<String> get uri => _uri.stream;

	Bloc(BuildContext c) :
		super() {
			_updatePlayerFetcher.transform(_updatePlayer()).pipe(_updatePlayerOutput);
	}

	Stream<Future<Player>> get updatePlayerOutput => _updatePlayerOutput.stream;
	Function(Object) get updatePlayer => _updatePlayerFetcher.sink.add;

	_updatePlayer() {
		return StreamTransformer<Object, Future<Player>>.fromHandlers(
			handleData: (_, sink) {
				Player player = Player();
				player.uri = _uri.value;
				return _repository.updatePlayer(_access.value, player);
			}
		);
	}


	dispose() {
		_uri.close();
		_updatePlayerFetcher.close();
		_updatePlayerOutput.close();
	}

}
