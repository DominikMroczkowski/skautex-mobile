import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/blocs/session/bloc.dart' as session;
import 'package:skautex_mobile/src/helpers/positions.dart';
import 'package:skautex_mobile/src/models/jwt.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'provider.dart';
export 'provider.dart';

import 'validate.dart';

class Bloc with Validate {
	final _repository = Repository();
	final nameTM      = BehaviorSubject<String>();
	final surnameTM   = BehaviorSubject<String>();
	final positionTM  = BehaviorSubject<String>();
	final birthDateTM = BehaviorSubject<String>();
	final countryTM   = BehaviorSubject<String>();
	final cityTM      = BehaviorSubject<String>();
	final teamTM      = BehaviorSubject<List<String>>();
	final leagueTM    = BehaviorSubject<List<String>>();

	final _response  = BehaviorSubject<Future<Player>>();
	final _request   = BehaviorSubject<BuildContext>();

	BehaviorSubject<Future<JWT>> _jwt;

	Bloc(BuildContext c) {
		final s = session.Provider.of(c);
		_jwt = s.otp;

		_request.transform(_postPlayer()).pipe(_response);
	}

	Stream<String> get name         => nameTM.stream;
	Stream<String> get surname      => surnameTM.stream;
	Stream<String> get position  		=> positionTM.stream;
	Stream<String> get birthData  	=> birthDateTM.stream;
	Stream<String> get country      => countryTM.stream;
	Stream<String> get city         => cityTM.stream;
	Stream<List<String>> get team         => teamTM.stream;
	Stream<List<String>> get league       => leagueTM.stream;
	Stream<bool>   get submitValid  => Rx.combineLatest([name, surname, position, birthData, country, city, team, league], (List<Object> _) { return true;});

	Stream<Future<Player>> get response => _response.stream;

	// Becouse dart doesnt have protected and private members this thing is for extending for edit player
	// Todo : create helpers mixins
	 get repository => _repository;
	 get access => _jwt;

	Function(String) get changeName => nameTM.sink.add;
	Function(String) get changeSurname => surnameTM.sink.add;
	Function(String) get changePosition => positionTM.sink.add;
	Function(String) get changeBithDate => birthDateTM.sink.add;
	Function(String) get changeCountry => countryTM.sink.add;
	Function(String) get changeCity => cityTM.sink.add;
	Function(List<String>) get changeTeam => teamTM.sink.add;
	Function(List<String>) get changeLeague => leagueTM.sink.add;

	Function(BuildContext) get submitPlayer => _request.sink.add;

	_postPlayer() {
		return StreamTransformer<BuildContext, Future<Player>>.fromHandlers(
			handleData: (context, sink) {
				final player = Player(
					name: nameTM.value,
					surname: surnameTM.value,
					position: positionTM.value,
					birthDate: birthDateTM.value,
					country: countryTM.value,
					city: cityTM.value,
					team: teamTM.value,
					league: leagueTM.value
				);
				sink.add(_repository.addPlayer(_jwt.value, player).then(
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
		nameTM.close();
		surnameTM.close();
		positionTM.close();
		birthDateTM.close();
		countryTM.close();
		cityTM.close();
		teamTM.close();
		leagueTM.close();

		_response.close();
		_request.close();
	}
}
