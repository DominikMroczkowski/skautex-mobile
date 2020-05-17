import 'dart:async';
import 'validate.dart';
import 'package:rxdart/rxdart.dart';
import 'provider.dart';
import '../../helpers/credentials.dart';
export 'provider.dart';
import '../session/bloc.dart' as session;

class Bloc with Validate {
	final _email       = BehaviorSubject<String>();
	final _password    = BehaviorSubject<String>();
	final _obscure     = BehaviorSubject<bool>();

	Stream<String> get email           => _email.stream.transform(validateEmail);
	Stream<String> get password        => _password.stream.transform(validatePassword);
	Stream<bool>   get obscure         => _obscure.stream;
	Stream<bool>   get submitValid     => Rx.combineLatest2(email, password, (e, p) => true);
	Stream<String> get passwordObscure => Rx.combineLatest2(password, obscure, (p, o) => "$p $o" );

	Function(String) get changeEmail    => _email.sink.add;
	Function(String) get changePassword => _password.sink.add;
	Function(bool)   get changeObscure  => _obscure.sink.add;

	Bloc() {
		_obscure.sink.add(true);
	}

	submit(session.Bloc s) {
		final validEmail = _email.value;
		final validPassword = _password.value;
		s.fetchJWT(Credentials(user: validEmail, password: validPassword));
	}

	getEmailValue() {
		return _email.value;
	}

	getObscureValue() {
		return _obscure.value;
	}

	dispose() {
		_email.close();
		_password.close();
		_obscure.close();
	}
}
