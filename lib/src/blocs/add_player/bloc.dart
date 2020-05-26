import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/blocs/session/bloc.dart' as session;
import 'package:skautex_mobile/src/helpers/positions.dart';
import 'package:skautex_mobile/src/models/jwt.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'package:date_format/date_format.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'provider.dart';
export 'provider.dart';

import 'validate.dart';

class Bloc with Validate {
	final _repository = Repository();
	final _name      = BehaviorSubject<String>();
	final _surname   = BehaviorSubject<String>();
	final _position  = BehaviorSubject<Positions>();
	final _birthDate = BehaviorSubject<DateTime>();
	final _country   = BehaviorSubject<String>();
	final _city      = BehaviorSubject<String>();
	final _team      = BehaviorSubject<String>();
	final _league    = BehaviorSubject<String>();

	final _response  = BehaviorSubject<Future<Player>>();
	final _request   = BehaviorSubject<Object>();

	BehaviorSubject<Future<JWT>> _jwt;

	Bloc(BuildContext c) {
			final s = session.Provider.of(c);
			_jwt = s.otp;

			_request.transform(_postPlayer()).pipe(_response);
		}

	Stream<String> get name         => _name.stream.transform(isUperCaseWord);
	Stream<String> get surname      => _surname.stream.transform(isUperCaseWord);
	Stream<Positions> get position  => _position.stream.transform(isPosition);
	Stream<DateTime> get birthData  => _birthDate.stream;
	Stream<String> get country      => _country.stream.transform(isUperCaseWord);
	Stream<String> get city         => _city.stream.transform(isUperCaseWord);
	Stream<String> get team         => _team.stream.transform(isUperCaseWord);
	Stream<String> get league       => _league.stream.transform(isUperCaseWord);
	Stream<bool>   get submitValid  => Rx.combineLatest([name, surname, position, birthData, country, city, team, league], (List<Object> _) { return true;});

	Stream<Future<Player>> get response => _response.stream;

	Function(String) get changeName => _name.sink.add;
	Function(String) get changeSurname => _surname.sink.add;
	Function(Positions) get changePosition => _position.sink.add;
	Function(DateTime) get changeBithDate => _birthDate.sink.add;
	Function(String) get changeCountry => _country.sink.add;
	Function(String) get changeCity => _city.sink.add;
	Function(String) get changeTeam => _team.sink.add;
	Function(String) get changeLeague => _league.sink.add;

	Function(Object) get submitPlayer => _request.sink.add;

	_postPlayer() {
		return StreamTransformer<Object, Future<Player>>.fromHandlers(
			handleData: (_, sink) {
				final player = Player(
					name: _name.value,
					surname: _surname.value,
					position: positionsToRequest[Positions.values.indexOf(_position.value)],
					birthDate: formatDate(_birthDate.value, [yyyy, '-', mm, '-', dd]),
					country: _country.value,
					city: _city.value,
					team: _team.value,
					league: _league.value
				);
				print('dodaje plaera do sinka');
				sink.add(_repository.addPlayer(_jwt.value, player));
			}
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

		_response.close();
		_request.close();
	}
}
