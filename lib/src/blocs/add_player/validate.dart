import 'dart:async';
import 'package:skautex_mobile/src/helpers/positions.dart';

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

	final isPosition = StreamTransformer<Positions, Positions>.fromHandlers(
		handleData: (i, sink) {
			if (Positions.values.indexOf(i) != -1) {
				sink.add(i);
			} else {
				sink.addError('Wybierz pozycje');
			}
		}
	);
}
