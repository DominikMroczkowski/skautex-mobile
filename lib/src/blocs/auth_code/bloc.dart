import 'dart:async';
import 'package:rxdart/rxdart.dart';
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

// Just inject steam from session bloc for code
	submit() {
	}

	dispose() {
		_code.close();
	}
}
