import 'dart:async';
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

	final _JWTOutput   = BehaviorSubject<Future<JWT>>();
	final _JWTFetcher = BehaviorSubject<Credentials>();
	final _OTPOutput   = BehaviorSubject<Future<JWT>>();
	final _OTPFetcher = BehaviorSubject<CreadsWithCode>();

	Stream<Future<JWT>> get jwt => _JWTOutput.stream;
	Stream<Future<JWT>> get otp => _OTPOutput.stream;

	Function(Credentials) get fetchJWT => _JWTFetcher.sink.add;

	fetchOTP(String code) {
		_OTPFetcher.sink.add(CreadsWithCode(_JWTOutput.value, code));
	}

	Bloc() {
		_JWTFetcher.stream.transform(_JWTTransformer()).pipe(_JWTOutput);
		_OTPFetcher.stream.transform(_OTPTransformer()).pipe(_OTPOutput);
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

	_OTPTransformer() {
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
				sink.add(jWT);
			}
		);
	}

	dispose() {
		_JWTOutput.close();
		_JWTFetcher.close();
		_OTPOutput.close();
		_OTPFetcher.close();
	}

	setContext(context) {
		this.context = context;
	}
}
