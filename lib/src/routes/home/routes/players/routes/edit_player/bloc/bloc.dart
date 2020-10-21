import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/positions.dart';
import '../add_player/bloc.dart' as add_player;
import '../session/bloc.dart' as session;
import 'package:skautex_mobile/src/models/player.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends add_player.Bloc {
	final _uri  = BehaviorSubject<String>();

	BehaviorSubject<String> _clicked;

	final _playerOutput  = BehaviorSubject<Future<Player>>();
	final _updatePlayerOutput = BehaviorSubject<Future<Player>>();
	final _updatePlayerFetcher = BehaviorSubject<BuildContext>();

	Stream<Future<Player>> get updatePlayerOutput => _updatePlayerOutput.stream;
	Function(BuildContext) get updatePlayer => _updatePlayerFetcher.sink.add;

	get player => _playerOutput.stream;

	Bloc(BuildContext c) :
		super(c) {
		final s = session.Provider.of(c);
		_clicked = s.clicked;
		_clicked.pipe(_uri);
		_clicked.transform(_playerTransfor()).pipe(_playerOutput);
		_updatePlayerFetcher.transform(_updatePlayer()).pipe(_updatePlayerOutput);
	}

	_playerTransfor() {
		return StreamTransformer<String, Future<Player>>.fromHandlers(
			handleData: (url, sink) {
				sink.add(repository.fetchPlayer(access.value, url).then(
						(Player p) {
							changeName(p.name);
							changeSurname(p.surname);
							changeCity(p.city);
							changeCountry(p.country);
							changeTeam(p.team);
							changeLeague(p.league);
							changePosition(p.position);
							changeBithDate(p.birthDate);
						}
					)
				);
			}
		);
	}

	_updatePlayer() {
		return StreamTransformer<BuildContext, Future<Player>>.fromHandlers(
			handleData: (context, sink) {
				Player player = Player();
				player.uri = _uri.value;
				player.name = nameTM.value;
				player.surname = surnameTM.value;
				player.city = cityTM.value;
				player.country = countryTM.value;
				player.team = teamTM.value;
				player.league = leagueTM.value;
				player.position = positionTM.value;
				player.birthDate = birthDateTM.value;
				return sink.add(repository.updatePlayer(access.value, player).then(
					(_) {
						Navigator.of(context).popUntil((route) {
							return '/home' == route.settings.name;
						});
						return _;
					}
				));
			}
		);
	}

	dispose() {
		_uri.close();
		_updatePlayerFetcher.close();
		_updatePlayerOutput.close();
		_playerOutput.close();
	}
}
