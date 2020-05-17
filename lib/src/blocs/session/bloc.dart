import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'provider.dart';
import '../../helpers/credentials.dart';
import '../../helpers/creds_with_code.dart';
export 'provider.dart';

import '../../resources/repository.dart';
import '../../models/jwt.dart';

class Bloc {
	final _repository = Repository();
	BuildContext context = null;


	final _JWTOutput  = BehaviorSubject<Future<JWT>>();
	final _JWTFetcher = BehaviorSubject<Credentials>();
	final _OTPOutput  = BehaviorSubject<Future<JWT>>();
	final _OTPFetcher = BehaviorSubject<CreadsWithCode>();
	final _access     = BehaviorSubject<String>();
	final _refreshTokens = BehaviorSubject<Future<JWT>>();

	Stream<Future<JWT>> get jwt    => _JWTOutput.stream;
	Stream<Future<JWT>> get otp    => _OTPOutput.stream;
	Stream<String> get access      => _access.stream;

	Function(Credentials) get fetchJWT => _JWTFetcher.sink.add;

	fetchOTP(String code) {
		_OTPFetcher.sink.add(CreadsWithCode(_JWTOutput.value, code));
	}

	Bloc() {
		_JWTFetcher.stream.transform(_JWTTransformer()).pipe(_JWTOutput);
		_OTPOutput.stream.transform(_accessTransformer()).pipe(_access);
		MergeStream([_OTPFetcher.stream.transform(_OTPTransformer()), _refreshTokens.stream]).pipe(_OTPOutput);
	}

	_JWTTransformer() {
		return StreamTransformer<Credentials, Future<JWT>>.fromHandlers(
			handleData: (creds, sink) {
				Future<JWT> jWT =_repository.fetchJWT(creds);
				jWT.then(
					(_) {
						Navigator.of(context).pushNamed('/auth_code');
					},
					onError: (error) {
						print('$error');
					}
				);
				sink.add(jWT);
			}
		);
	}

	_identity() {
		return StreamTransformer<Future<JWT>, Future<JWT>>.fromHandlers(
			handleData: (event, sink) {
				sink.add(event);
			}
		);
	}

	StreamTransformer<CreadsWithCode, Future<JWT>> _OTPTransformer() {
		return StreamTransformer<CreadsWithCode, Future<JWT>>.fromHandlers(
			handleData: (code, sink) {
				Future<JWT> jWT =_repository.fetchJWT2(code.jwt, code.code);
				jWT.then(
					(_) {
						Navigator.of(context).pushNamedAndRemoveUntil('/home', ModalRoute.withName('/'));
					},
					onError: (error) {
						print('$error');
					}
				);
				_refresh();
				sink.add(jWT);
			}
		);
	}

	_refresh() {
		Timer(Duration(minutes: 0, seconds: 30), () {
			_refreshTokens.sink.add(_repository.refetchJWT2(_OTPOutput.value));
			_refresh();
		});
	}

	_accessTransformer() {
		return StreamTransformer<Future<JWT>, String>.fromHandlers(
			handleData: (jWT, sink) async {
				JWT jwt = await jWT;
				sink.add(jwt.access);
			}
		);
	}

	sendCodeOnEmail() {
		_repository.sendCodeOnEmail(_JWTOutput.value);
	}

	dispose() {
		_JWTOutput.close();
		_JWTFetcher.close();
		_OTPOutput.close();
		_OTPFetcher.close();
		_access.close();
	}

	setContext(context) {
		this.context = context;
	}
}
