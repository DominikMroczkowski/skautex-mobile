import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/update.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/routes/home/routes/players/bloc/bloc.dart' as playersBloc;

import 'provider.dart';
export 'provider.dart';

class Bloc extends Update<Player> {
	final _player = BehaviorSubject<Player>();
	final String _uri;

	final _name      = BehaviorSubject<String>();
	final _surname   = BehaviorSubject<String>();
	final _position  = BehaviorSubject<String>();
	final _birthDate = BehaviorSubject<String>();
	final _country   = BehaviorSubject<String>();
	final _city      = BehaviorSubject<String>();
	final _team      = BehaviorSubject<List<String>>();
	final _league    = BehaviorSubject<List<String>>();

	Bloc(BuildContext c, {@required Player player}):
		_uri = player.uri {
		otp = c;
		changeName(player.name);
		changeSurname(player.surname);
		changePosition(player.position);
		changeBithDate(player.birthDate);
		changeCity(player.city);
		changeCountry(player.country);
		changeTeam(player.team);
		changeLeague(player.league);
		item.listen(
			(Future<Player> i) {
				i.then(
					(Player i) {
						final bloc = playersBloc.Provider.of(c);
						bloc.reloadPlayers();
						bloc.navigator.currentState.pop();
						bloc.navigator.currentState.pushReplacementNamed('/home/players/player', arguments: i);
					}
				);
			}
		);
	}

	Stream<String> get name         => _name.stream;
	Stream<String> get surname      => _surname.stream;
	Stream<String> get position  		=> _position.stream;
	Stream<String> get birthData  	=> _birthDate.stream;
	Stream<String> get country      => _country.stream;
	Stream<String> get city         => _city.stream;
	Stream<List<String>> get team   => _team.stream;
	Stream<List<String>> get league => _league.stream;

	Function(String) get changeName => _name.sink.add;
	Function(String) get changeSurname => _surname.sink.add;
	Function(String) get changePosition => _position.sink.add;
	Function(String) get changeBithDate => _birthDate.sink.add;
	Function(String) get changeCountry => _country.sink.add;
	Function(String) get changeCity => _city.sink.add;
	Function(List<String>) get changeTeam => _team.sink.add;
	Function(List<String>) get changeLeague => _league.sink.add;

	Stream<bool>   get submitValid  => Rx.combineLatest([name, surname, position, birthData, country, city, team, league], (List<Object> _) { return true;});

	updatePlayer() {
		updateItem(
			Player(
				uri: _uri,
				name: _name.value,
				surname: _surname.value,
				position: _position.value,
				birthDate: _birthDate.value,
				country: _country.value,
				city: _city.value,
				team: _team.value,
				league: _league.value
			)
		);
	}

	dispose() {
		_player.close();

		_name.close();
		_surname.close();
		_position.close();
		_birthDate.close();
		_country.close();
		_city.close();
		_team.close();
		_league.close();
	}
}
