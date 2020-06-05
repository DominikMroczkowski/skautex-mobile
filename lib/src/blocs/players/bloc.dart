import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/jwt.dart';
import '../../resources/repository.dart';
import '../../models/player.dart';
import '../session/bloc.dart' as session;

import 'provider.dart';
export 'provider.dart';

class Bloc {
	final _repository     = Repository();
	final _topPlayers     = PublishSubject<List<String>>();
	final _playersOutput  = BehaviorSubject<Map<String, Future<Player>>>();
	final _playersFetcher = PublishSubject<String>();
	BehaviorSubject<Future<JWT>> _access;

	get topUris => _topPlayers.stream;
	get player => _playersOutput.stream;

	Function(String) get fetchPlayer => _playersFetcher.sink.add;

	Bloc(BuildContext context) {
		_access = session.Provider.of(context).otp;
		_playersFetcher.transform(_playerTransfor()).pipe(_playersOutput);
	}

	fetchTopUris() async {
		final uris = await _repository.fetchTopPlayersUris(_access.value);
		_topPlayers.sink.add(uris);
	}

	_playerTransfor() {
		return ScanStreamTransformer<String, Map<String, Future<Player>>>(
			(Map<String, Future<Player>> map, String uri, _) {
				map[uri] = _repository.fetchPlayer(_access.value, uri);
				return map;
			},
			<String, Future<Player>> {}
		);
	}

	dispose() {
  	_topPlayers.close();
  	_playersOutput.close();
		_playersFetcher.close();
		_access.close();
	}
}
