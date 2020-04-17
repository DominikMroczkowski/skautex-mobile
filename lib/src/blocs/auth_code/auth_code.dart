import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'provider.dart';
import 'validate.dart';
export 'provider.dart';

class AuthCodeBloc with Validate {
	final _code = BehaviorSubject<String>();

	Stream<String> get code => _code.stream.transform(validateCode);

	Stream<bool> get submitValid => code.transform(isNumber);

	Function(String) get changeCode => _code.sink.add;

	submit() {
		final validCode = _code.value;
	}

	dispose() {
		_code.close();
	}
}
