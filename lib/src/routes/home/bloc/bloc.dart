import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/models/user.dart';
import 'package:skautex_mobile/src/helpers/blocs/access.dart';
import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc with Access {
	final _repository = Repository();
	final _teamsOutput  = BehaviorSubject<Future<List<List<String>>>>();
	final _leagueOutput  = BehaviorSubject<Future<List<List<String>>>>();

	final _teamsFetcher = BehaviorSubject<Object>();
	final _leagueFetcher = BehaviorSubject<Object>();

	final _permsOutput = BehaviorSubject<Future<Permissions>>();
	final _userOutput  = BehaviorSubject<Future<User>>();
	final _userFetcher = BehaviorSubject<String>();
	final _groupsOutput  = BehaviorSubject<Future<List<String>>>();

	final homeNavigatorKey;

	get permissions => _permsOutput.stream;
	Stream<Future<User>> get me => _userOutput.stream;
	get groups => _groupsOutput.stream;

	Stream<Future<List<List<String>>>> get teams   => _teamsOutput.stream;
	Stream<Future<List<List<String>>>> get leagues => _leagueOutput.stream;

	Function(Object) get fetchTeams   => _teamsFetcher.sink.add;
	Function(Object) get fetchLeagues => _leagueFetcher.sink.add;

	Bloc(BuildContext context, this.homeNavigatorKey) {
		otp = context;
		_teamsFetcher.transform(_fetchTeams()).pipe(_teamsOutput);
		_leagueFetcher.transform(_fetchLeagues()).pipe(_leagueOutput);
		_userFetcher.transform(_userTransform()).pipe(_userOutput);
		_userFetcher.transform(_permsTransform()).pipe(_permsOutput);
		_userFetcher.transform(_groupTransform()).pipe(_groupsOutput);

		_fetchMe();
	}

	flush() {

	}

	_fetchTeams() {
		return StreamTransformer<Object, Future<List<List<String>>>>.fromHandlers(
			handleData: (_, sink) {
				sink.add(_repository.fetchTeams(otp));
			}
		);
	}

	_fetchLeagues() {
		return StreamTransformer<Object, Future<List<List<String>>>>.fromHandlers(
			handleData: (_, sink) {
				sink.add(_repository.fetchLeagues(otp));
			}
		);
	}

	_fetchMe() {
		_userFetcher.sink.add('me');
	}

	_userTransform() {
		return StreamTransformer<String, Future<User>>.fromHandlers(
			handleData: (String uri, sink) {
				sink.add(_repository.fetchUser(otp, uri));
			}
		);
	}

	_permsTransform() {
		return StreamTransformer<String, Future<Permissions>>.fromHandlers(
			handleData: (String uri, sink) {
				sink.add(_repository.fetchPermissions(otp, uri));
			}
		);
	}

	_groupTransform() {
		return StreamTransformer<String, Future<List<String>>>.fromHandlers(
			handleData: (String uri, sink) {
				sink.add(_repository.fetchGroups(otp, uri));
			}
		);
	}

	dispose() {
		_teamsOutput.close();
		_teamsFetcher.close();
		_leagueFetcher.close();
		_leagueOutput.close();
		_userOutput.close();
		_permsOutput.close();
		_groupsOutput.close();
	}
}
