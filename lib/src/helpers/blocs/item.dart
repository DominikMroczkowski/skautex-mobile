import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'access.dart';

class Item<T> with Access {
	final _repository = Repository();

	final _output = BehaviorSubject<Future<T>>();
	final _input  = BehaviorSubject<String>();

	get fetchItem => _input.sink.add;
	Stream<Future<T>> get item => _output.stream;

	Item() {
		_input.transform(_fetch()).pipe(_output);
	}

	_fetch() {
		return StreamTransformer<String, Future<T>>.fromHandlers(
			handleData: (String uri, sink) {
				sink.add(_repository.fetchItem<T>(otp, uri));
			}
		);
	}

	dispose() {
		_output.close();
		_input.close();
	}
}
