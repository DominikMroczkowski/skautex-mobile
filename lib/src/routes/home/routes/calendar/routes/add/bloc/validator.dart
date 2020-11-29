import 'dart:async';

class Validate {
	final isUperCaseWord = StreamTransformer<String, String>.fromHandlers(
		handleData: (i, sink) {
			RegExp exp = new RegExp(r"^[A-Ź]\S*$");
			Iterable<RegExpMatch> matches = exp.allMatches(i);

			if (1 == matches.length) {
				sink.add(i);
			} else {
				sink.addError('Słowo powinno zaczynać się z wielkiej litery');
			}
		}
	);

	final isName = StreamTransformer<String, String>.fromHandlers(
		handleData: (i, sink) {
			if (i.length > 255 || i.length < 10)
				sink.addError('Nazwa jest za krótka O_o');
			else
				sink.add(i);
		}
	);

	final startIsBefore = StreamTransformer<List<DateTime>, DateTime>.fromHandlers(
		handleData: (i, sink) {
			if (i[1].isAfter(i[0]))
				sink.add(i[0]);
			else
				sink.addError('Data początkowa nie jest po końcowej');
		}
	);

	final endIsAfter = StreamTransformer<List<DateTime>, DateTime>.fromHandlers(
		handleData: (i, sink) {
			if (i[1].isAfter(i[0]))
				sink.add(i[1]);
			else
				sink.addError('Data początkowa nie jest po końcowej');
		}
	);
}
