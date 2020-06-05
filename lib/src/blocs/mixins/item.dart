import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'acess.dart';

class Item<T> with Access {
	final _repository = Repository();

	final _output     = PublishSubject<Future<T>>();
	final _input      = PublishSubject<String>();

	get fetchItem => _input.sink.add;
	get item      => _output.stream;

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
