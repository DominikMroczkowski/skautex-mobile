import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../helpers/credentials.dart';
import '../helpers/creds_with_code.dart';


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
		_JWTFetcher.stream.transform(_JWTTransformer()).pipe(_JWTOutput);
		MergeStream<Future<JWT>>([
			_OTPFetcher.stream.transform(_OTPTransformer()),
			_refreshTokens.stream,
			_dbTokenLoader.stream.transform(_dbLoaderTransform())
		]).pipe(_OTPOutput);
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
}
