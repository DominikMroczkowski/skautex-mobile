import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/jwt.dart';
import 'package:skautex_mobile/src/resources/repository.dart';

import 'provider.dart';
export 'provider.dart';

import '../session/bloc.dart' as session;

import '../../models/user.dart';
import '../../models/permissions.dart';

class Bloc {
	final _repository  = Repository();
	final _permsOutput = BehaviorSubject<Future<Permissions>>();
	final _userOutput  = BehaviorSubject<Future<User>>();
	final _userFetcher = BehaviorSubject<String>();
	final _groupsOutput  = BehaviorSubject<Future<List<String>>>();


	BehaviorSubject<Future<JWT>> _access;

	get permissions => _permsOutput.stream;
	get me => _userOutput.stream;
	get groups => _groupsOutput.stream;

	Bloc(BuildContext c) {
		_userFetcher.transform(_userTransform()).pipe(_userOutput);
		_userFetcher.transform(_permsTransform()).pipe(_permsOutput);
		_userFetcher.transform(_groupTransform()).pipe(_groupsOutput);

		final s = session.Provider.of(c);
		_access = s.otp;
		_fetchMe();
	}

	_fetchMe() {
		_userFetcher.sink.add('me');
	}

	_userTransform() {
		return StreamTransformer<String, Future<User>>.fromHandlers(
			handleData: (String uri, sink) {
				sink.add(_repository.fetchUser(_access.value, uri));
			}
		);
	}

	_permsTransform() {
		return StreamTransformer<String, Future<Permissions>>.fromHandlers(
			handleData: (String uri, sink) {
				sink.add(_repository.fetchPermissions(_access.value, uri));
			}
		);
	}

	_groupTransform() {
		return StreamTransformer<String, Future<List<String>>>.fromHandlers(
			handleData: (String uri, sink) {
				sink.add(_repository.fetchGroups(_access.value, uri));
			}
		);
	}

	dispose() {
		_userOutput.close();
		_permsOutput.close();
		_groupsOutput.close();
	}
}
