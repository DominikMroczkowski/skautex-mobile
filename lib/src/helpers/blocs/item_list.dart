import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'package:skautex_mobile/src/models/uri_parametrized.dart';
import 'access.dart';

class ItemList<T> with Access {
	final _repository = Repository();
	final String customUrl;

	final _output = BehaviorSubject<Future<List<T>>>();
	final _input  = BehaviorSubject<UriParametrized>();

	fetch({String uri, Map<String,String> where}) {
		_input.sink.add(
			UriParametrized(
				uri: uri ?? '',
				parameters: where
			)
		);
	}

	get watcher => _output.stream;

	ItemList({String customUrl}):
		customUrl = customUrl {
		_input.transform(_fetch()).pipe(_output);
	}

	_fetch() {
		return StreamTransformer<UriParametrized, Future<List<T>>>.fromHandlers(
			handleData: (UriParametrized uri, sink) {
				Future<List<T>> list = _repository.fetchItems<T>(otp, uri: uri.uri, where: uri.parameters);
				sink.add(list);
			}
		);
	}

	dispose() {
		_output.close();
		_input.close();
	}
}
