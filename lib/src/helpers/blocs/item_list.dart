import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'access.dart';

class ItemList<T> with Access {
	final _repository = Repository();
	final String customUrl;

	final _output = BehaviorSubject<Future<List<T>>>();
	final _input  = BehaviorSubject<String>();

	Function({String uri}) get fetch   =>
			({String uri}) {
				_input.sink.add(uri ?? '');
			};

	get watcher => _output.stream;

	ItemList({String customUrl}):
		customUrl = customUrl {
		_input.transform(_fetch()).pipe(_output);
	}

	_fetch() {
		return StreamTransformer<String, Future<List<T>>>.fromHandlers(
			handleData: (String uri, sink) {
				Future<List<T>> list = _repository.fetchItems<T>(otp, uri: uri);
				sink.add(list);
			}
		);
	}

	dispose() {
		_output.close();
		_input.close();
	}
}
