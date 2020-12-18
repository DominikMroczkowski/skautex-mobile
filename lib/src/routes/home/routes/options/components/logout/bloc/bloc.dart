import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/resources/repository.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc {
	final _repository = Repository();

	final _output = PublishSubject<Future<Object>>();
	final _input  = PublishSubject<Object>();

	deleteItem() {_input.sink.add(Object());}
	Stream<Future<Object>> get watcher => _output.stream;

	Bloc() {
		_input.transform(_fetch()).pipe(_output);
	}

	_fetch() {
		return StreamTransformer<Object, Future<Object>>.fromHandlers(
			handleData: (Object _, sink) {
				sink.add(_repository.clear());
			}
		);
	}

	dispose() {
		_output.close();
		_input.close();
	}
}
