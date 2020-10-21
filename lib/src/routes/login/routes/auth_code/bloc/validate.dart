import 'dart:async';

class Validate {
	final validateCode = StreamTransformer<String, String>.fromHandlers(
		handleData: (code, sink) {
			RegExp exp = new RegExp(r"^(\d{6,6})$");
			Iterable<RegExpMatch> matches = exp.allMatches(code);

			if (1 == matches.length) {
				sink.add(code);
			} else {
				sink.addError('Wpisz poprawny kod');
			}
		}
	);

	final isNumber = StreamTransformer<String, bool>.fromHandlers(
		handleData: (code, sink) {
			sink.add(double.tryParse(code) != null);
		}
	);
}
