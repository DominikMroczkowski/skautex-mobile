import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'access.dart';

class Update<T> with Access {
	final _repository = Repository();

	final _output     = PublishSubject<Future<T>>();
	final _input      = PublishSubject<T>();

	Function(T) get updateItem => _input.sink.add;
	Stream<Future<T>> get item => _output.stream;

	Update() {
		_input.transform(_fetch()).pipe(_output);
	}

	_fetch() {
		return StreamTransformer<T, Future<T>>.fromHandlers(
			handleData: (T item, sink) {
				sink.add(_repository.updateItem<T>(otp, item));
			}
		);
	}

	dispose() {
		_output.close();
		_input.close();
	}
}
