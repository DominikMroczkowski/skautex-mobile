import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'acess.dart';

class Add<T> with Access {
	final _repository = Repository();

	final _output     = PublishSubject<Future<T>>();
	final _input      = PublishSubject<T>();

	Function(T) get addItem    => _input.sink.add;
	Stream<Future<T>> get item => _output.stream;

	Add() {
		_input.transform(_fetch()).pipe(_output);
	}

	_fetch() {
		return StreamTransformer<T, Future<T>>.fromHandlers(
			handleData: (T item, sink) {
				sink.add(_repository.addItem<T>(otp, item));
			}
		);
	}

	dispose() {
		_output.close();
		_input.close();
	}
}
