import 'dart:async';

class Validate {
	final isUperCaseWord = StreamTransformer<String, String>.fromHandlers(
		handleData: (i, sink) {
			RegExp exp = new RegExp(r"^[A-Ź]\S*$");
			Iterable<RegExpMatch> matches = exp.allMatches(i);

			if (1 == matches.length) {
				sink.add(i);
			} else {
				sink.addError('Wpisz poprawne imię');
			}
		}
	);
}
