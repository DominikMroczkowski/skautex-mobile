import 'dart:async';

class Validate {
	final hasOneSymbol = StreamTransformer<String, String>.fromHandlers(
		handleData: (i, sink) {
			RegExp exp = new RegExp(r".+");
			Iterable<RegExpMatch> matches = exp.allMatches(i);

			if (1 == matches.length) {
				sink.add(i);
			} else {
				sink.addError('Błąd');
			}
		}
	);

	final hasOneElement = StreamTransformer<List, List>.fromHandlers(
		handleData: (List i, sink) {
			if (0 < i.length) {
				sink.add(i);
			} else {
				sink.addError('Błąd');
			}
		}
	);
}
