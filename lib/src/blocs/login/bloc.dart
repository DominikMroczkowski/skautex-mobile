import 'package:flutter/material.dart';
import 'dart:async';
import 'validate.dart';
import 'package:rxdart/rxdart.dart';
import 'provider.dart';
export 'provider.dart';

class Bloc with Validate {
	final _email = BehaviorSubject<String>();
	final _password = BehaviorSubject<String>();

	Stream<String> get email => _email.stream.transform(validateEmail);
	Stream<String> get password => _password.stream.transform(validatePassword);
	Stream<bool> get submitValid => Rx.combineLatest2(email, password, (e, p) => true);

	Function(String) get changeEmail => _email.sink.add;
	Function(String) get changePassword => _password.sink.add;

	submit(Function(String) session) {
		final validEmail = _email.value;
		final validPassword = _password.value;
	}

	getEmailValue() {
		return _email.value;
	}

	dispose() {
		_email.close();
		_password.close();
	}
}
