import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/response_list.dart';
import 'dart:async';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'package:skautex_mobile/src/models/uri_parametrized.dart';
import 'access.dart';

class ItemList<T> with Access {
	final _repository = Repository();
	final String customUrl;

	final _response = BehaviorSubject<Future<ResponseList<T>>>();
	final _input  = BehaviorSubject<UriParametrized>();
	final _output = BehaviorSubject<List<T>>();

	fetch({String uri, Map<String,String> where}) {
		_input.sink.add(
			UriParametrized(
				uri: uri ?? '',
				parameters: where
			)
		);
	}

	Stream get requestWatcher => _response.stream;
	Stream get itemsWatcher => _output.stream;

	ItemList({String customUrl}):
		customUrl = customUrl {

		final _fetch = StreamTransformer<UriParametrized, Future<ResponseList<T>>>.fromHandlers(
			handleData: (UriParametrized uri, sink) {
				sink.add(
					_repository.fetchItems<T>(
						otp,
						uri: uri.uri,
						where: uri.parameters)
				);
			}
		);
		_input.transform(_fetch).pipe(_response);


		final _toList = ScanStreamTransformer<ResponseList<T>, List<T>>(
			(List<T> cache, ResponseList<T> rl, _) {
				rl.results.forEach(
					(i) => cache.add(i)
				);
				return cache;
			},
			[]
		);

		final _future = StreamTransformer<Future<ResponseList<T>>, ResponseList<T>>.fromHandlers(
			handleData: (i, sink) async {
				final v = await i;
				sink.add(v);
			}
		);
		_response.transform(_future).transform(_toList).pipe(_output);
	}


	dispose() {
		_output.close();
		_response.close();
		_input.close();
	}
}
