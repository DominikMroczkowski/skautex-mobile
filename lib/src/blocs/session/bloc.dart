import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'provider.dart';
import '../../helpers/credentials.dart';
export 'provider.dart';

import '../../resources/repository.dart';
import '../../models/jwt.dart';

class Bloc {
	final _repository = Repository();
	BuildContext context = null;

	final _JWTOutup   = BehaviorSubject<Future<JWT>>();
	final _JWTFetcher = BehaviorSubject<Credentials>();
	final _OTPOutup   = BehaviorSubject<Future<JWT>>();
	final _OTPFetcher = BehaviorSubject<String>();

	Stream<Future<JWT>> get jwt => _JWTOutup.stream;
	Stream<Future<JWT>> get otp => _OTPOutup.stream;

	Function(Credentials) get fetchJWT => _JWTFetcher.sink.add;
	Function(String) get fetchOTP => _OTPFetcher.sink.add;

	Bloc() {
		_JWTFetcher.stream.transform(_JWTTransformer()).pipe(_JWTOutup);
		_OTPFetcher.stream.transform(_OTPTransformer()).pipe(_OTPOutup);
	}

	_JWTTransformer() {
		return StreamTransformer<Credentials, Future<JWT>>.fromHandlers(
			handleData: (creds, sink) {
				sink.add(_repository.fetchJWT(creds).then(
					(_) {
						Navigator.of(context).pushNamed('/auth_code');
					},
						onError: (error) {
						print('$error');
					})
				);
			}
		);
	}

	_OTPTransformer() {
		Future<JWT> access = _JWTOutup.value;
		return StreamTransformer<String, Future<JWT>>.fromHandlers(
			handleData: (code, sink) {
				sink.add(_repository.fetchJWT2(access, code));
			}
		);
	}

	dispose() {
		_JWTOutup.close();
		_JWTFetcher.close();
		_OTPOutup.close();
		_OTPFetcher.close();
	}

	setContext(context) {
		this.context = context;
	}
}
