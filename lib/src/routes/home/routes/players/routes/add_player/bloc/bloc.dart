import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/add.dart';
import 'package:skautex_mobile/src/models/player.dart';

import 'provider.dart';
export 'provider.dart';

import 'validate.dart';

class Bloc extends Add<Player> with Validate {
	final _name      = BehaviorSubject<String>();
	final _surname   = BehaviorSubject<String>();
	final _position  = BehaviorSubject<String>();
	final _birthDate = BehaviorSubject<String>();
	final _country   = BehaviorSubject<String>();
	final _city      = BehaviorSubject<String>();
	final _team      = BehaviorSubject<List<String>>();
	final _league    = BehaviorSubject<List<String>>();
	final Function updateUpperPage;

	Bloc(BuildContext c, {@required this.updateUpperPage}) {
		otp = c;

		item.listen(
			(Future<Player> i) {
				i.then(
				 (i) {_update(i);},
				 onError: (_) {
					showDialog(
						context: context,
						builder: (context) {
							return AlertDialog(
								title: Text('Niepowodzenie'),
								actions: [
									FlatButton(
										child: Text('Ok'),
										onPressed: () {
											Navigator.of(context).pop();
										}
									)
								],
							);
						}
					);
				 }
				);
			}
		);
	}

	_update(Player player) async {
		updateUpperPage != null ? updateUpperPage() : null;
		Navigator.of(context).pushNamed('/home/players/player', arguments: [player, updateUpperPage]);
	}

	Stream<String> get name         => _name.stream;
	Stream<String> get surname      => _surname.stream;
	Stream<String> get position  		=> _position.stream;
	Stream<String> get birthData  	=> _birthDate.stream;
	Stream<String> get country      => _country.stream;
	Stream<String> get city         => _city.stream;
	Stream<List<String>> get team   => _team.stream;
	Stream<List<String>> get league => _league.stream;
	Stream<bool>   get submitValid  => Rx.combineLatest([name, surname, position, birthData, country, city, team, league], (List<Object> _) { return true;});

	Function(String) get changeName => _name.sink.add;
	Function(String) get changeSurname => _surname.sink.add;
	Function(String) get changePosition => _position.sink.add;
	Function(String) get changeBithDate => _birthDate.sink.add;
	Function(String) get changeCountry => _country.sink.add;
	Function(String) get changeCity => _city.sink.add;
	Function(List<String>) get changeTeam => _team.sink.add;
	Function(List<String>) get changeLeague => _league.sink.add;

	addPlayer() {
		addItem(
			Player(
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
