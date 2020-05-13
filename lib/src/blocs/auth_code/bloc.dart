import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../session/bloc.dart' as session;
import 'provider.dart';
import 'validate.dart';
export 'provider.dart';

class Bloc with Validate {
	final _code = BehaviorSubject<String>();

	Stream<String> get code => _code.stream.transform(validateCode);

	Stream<bool> get submitValid => code.transform(isNumber);

	Function(String) get changeCode => _code.sink.add;

	getCode() {
		return _code.value;
	}

	submit(session.Bloc s) {
		final code = _code.value;
		s.fetchOTP(code);
	}

	dispose() {
		_code.close();
	}
}
