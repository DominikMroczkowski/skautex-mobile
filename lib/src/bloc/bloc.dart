import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/widgets/dialog_info.dart';
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/models/user.dart';
import '../helpers/credentials.dart';
import '../helpers/creds_with_code.dart';

import 'auth_code_dialog.dart';

import 'provider.dart';
export 'provider.dart';

import '../resources/repository.dart';
import '../models/jwt.dart';

class Bloc {
	final _repository = Repository();
	BuildContext context;

	final _JWTOutput     = BehaviorSubject<Future<JWT>>();
	final _JWTFetcher    = BehaviorSubject<Credentials>();
	final _OTPOutput     = BehaviorSubject<Future<JWT>>();
	final _OTPFetcher    = BehaviorSubject<CreadsWithCode>();
	final _refreshTokens = BehaviorSubject<Future<JWT>>();
	final _dbTokenLoader = BehaviorSubject<Future<JWT>>();

	Stream<Future<JWT>> get jwt    => _JWTOutput.stream;
	Stream<Future<JWT>> get otp    => _OTPOutput.stream;

	Function(Credentials) get fetchJWT => _JWTFetcher.sink.add;

	fetchOTP(String code) {
		_OTPFetcher.sink.add(CreadsWithCode(_JWTOutput.value, code));
	}

	Bloc({this.context}) {
		_JWTOutput.listen(
			(Future<JWT> i) {
				i.then(
					(JWT i) {
						if (i.otpauth != null)
							showDialog(
								context: context,
								builder: (_) {
									return AuthCodeDialog(otpauth: i.otpauth);
								}
							);
					}
				);
			},
			onError: (i) {
				showDialog(
					context: context,
					builder: (_) => DialogInfo(
						future: Future.value(Object()),
						title: i.error
					)
				);
			}
		);
		_JWTFetcher.stream.transform(_JWTTransformer()).pipe(_JWTOutput);

		_OTPOutput.listen((i){
			i.then(
				(i) {
					fetchMe();
				}
			);
		});
		MergeStream<Future<JWT>>([
			_OTPFetcher.stream.transform(_OTPTransformer()),
			_refreshTokens.stream,
			_dbTokenLoader.stream.transform(_dbLoaderTransform())
		]).pipe(_OTPOutput);




		_teamsFetcher.transform(_fetchTeams()).pipe(_teamsOutput);
		_leagueFetcher.transform(_fetchLeagues()).pipe(_leagueOutput);
		_userFetcher.transform(_userTransform()).pipe(_userOutput);
		_userFetcher.transform(_permsTransform()).pipe(_permsOutput);
		_userFetcher.transform(_groupTransform()).pipe(_groupsOutput);
	}

	_JWTTransformer() {
		return StreamTransformer<Credentials, Future<JWT>>.fromHandlers(
			handleData: (creds, sink) {
				Future<JWT> jWT =_repository.fetchJWT(creds);
				sink.add(jWT);
			}
		);
	}

	_refreshError() {
		return StreamTransformer<Future<JWT>, Future<JWT>>.fromHandlers(
			handleData: (event, sink) {
				sink.add(event);
			},
			handleError: (_, __, ___) {
				Navigator.of(context, rootNavigator: true)
					.pushNamedAndRemoveUntil('login', (r) => false);
			}
		);
	}

	StreamTransformer<CreadsWithCode, Future<JWT>> _OTPTransformer() {
		return StreamTransformer<CreadsWithCode, Future<JWT>>.fromHandlers(
			handleData: (code, sink) {
				Future<JWT> jWT =_repository.fetchJWT2(code.jwt, code.code);
				jWT.then(
					(_) {
						Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil('/home', (r) => false);
					},
					onError: (_) {
						Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil('/login', (r) => false);
					}
				);
				sink.add(jWT);
				_refresh();
			}
		);
	}

	_refresh() async {
		Timer(Duration(minutes: 4, seconds: 30), () {
			_refreshTokens.sink.add(_repository.refetchJWT2(_OTPOutput.value));
			_refresh();
		});
	}

	sendCodeOnEmail() {
		_repository.sendCodeOnEmail(_JWTOutput.value);
	}

	void triggerDbLoader() {
		return _dbTokenLoader.sink.add(Future.value(JWT('access', 'refresh')));
	}

	_dbLoaderTransform() {
		return StreamTransformer<Future<JWT>, Future<JWT>>.fromHandlers(
			handleData: (Future<JWT> jWT, sink) {
				Future<JWT> fetched = _repository.refetchJWT2(jWT);
				fetched.then(
					(_) {
						Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil('/home', (r) => false);
					},
				);
				sink.add(fetched);
				_refresh();
			}
		);
	}

	dispose() {
		_JWTOutput.close();
		_JWTFetcher.close();
		_OTPOutput.close();
		_OTPFetcher.close();
		_refreshTokens.close();
		_dbTokenLoader.close();
		_clicked.close();

		_teamsOutput.close();
		_teamsFetcher.close();
		_leagueFetcher.close();
		_leagueOutput.close();
		_userOutput.close();
		_permsOutput.close();
		_groupsOutput.close();

	}

	setContext(context) {
		this.context = context;
	}

	/*
	 * To big of a hack should be put in constructor
	 */
	final BehaviorSubject<String> _clicked = BehaviorSubject<String>();
	get clicked => _clicked.stream;
	Function(String) get changeClicked => _clicked.sink.add;


	final _teamsOutput  = BehaviorSubject<Future<List<List<String>>>>();
	final _leagueOutput  = BehaviorSubject<Future<List<List<String>>>>();

	final _teamsFetcher = BehaviorSubject<Object>();
	final _leagueFetcher = BehaviorSubject<Object>();

	final _permsOutput = BehaviorSubject<Future<Permissions>>();
	final _userOutput  = BehaviorSubject<Future<User>>();
	final _userFetcher = BehaviorSubject<String>();
	final _groupsOutput  = BehaviorSubject<Future<List<String>>>();

	get permissions => _permsOutput.stream;
	Stream<Future<User>> get me => _userOutput.stream;
	get groups => _groupsOutput.stream;

	Stream<Future<List<List<String>>>> get teams   => _teamsOutput.stream;
	Stream<Future<List<List<String>>>> get leagues => _leagueOutput.stream;

	Function(Object) get fetchTeams   => _teamsFetcher.sink.add;
	Function(Object) get fetchLeagues => _leagueFetcher.sink.add;

	_fetchTeams() {
		return StreamTransformer<Object, Future<List<List<String>>>>.fromHandlers(
			handleData: (_, sink) {
				sink.add(_repository.fetchTeams(_OTPOutput.value));
			}
		);
	}

	_fetchLeagues() {
		return StreamTransformer<Object, Future<List<List<String>>>>.fromHandlers(
			handleData: (_, sink) {
				sink.add(_repository.fetchLeagues(_OTPOutput.value));
			}
		);
	}

	fetchMe() {
		_userFetcher.sink.add('me');
	}

	_userTransform() {
		return StreamTransformer<String, Future<User>>.fromHandlers(
			handleData: (String uri, sink) {
				sink.add(_repository.fetchUser(_OTPOutput.value, uri));
			}
		);
	}

	_permsTransform() {
		return StreamTransformer<String, Future<Permissions>>.fromHandlers(
			handleData: (String uri, sink) {
				sink.add(_repository.fetchPermissions(_OTPOutput.value, uri));
			}
		);
	}

	_groupTransform() {
		return StreamTransformer<String, Future<List<String>>>.fromHandlers(
			handleData: (String uri, sink) {
				sink.add(_repository.fetchGroups(_OTPOutput.value, uri));
			}
		);
	}
}
