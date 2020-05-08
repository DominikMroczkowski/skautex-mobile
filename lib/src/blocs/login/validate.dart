import 'dart:async';

class Validate {
	final validateEmail = StreamTransformer<String, String>.fromHandlers(
		handleData: (email, sink) {
			RegExp exp = new RegExp(r"(.{6,})");
			Iterable<RegExpMatch> matches = exp.allMatches(email);

			if (1 == matches.length) {
				sink.add(email);
			} else {
				sink.addError('Wpisz poprawny email');
			}
		}
	);

	final validatePassword = StreamTransformer<String, String>.fromHandlers(
		handleData: (password, sink) {
			RegExp exp = new RegExp(r"(.{6,})");
			Iterable<RegExpMatch> matches = exp.allMatches(password);

			if (1 == matches.length) {
				sink.add(password);
			} else {
				sink.addError('Wpisz poprawne hasło');
			}
		}
	);
}
