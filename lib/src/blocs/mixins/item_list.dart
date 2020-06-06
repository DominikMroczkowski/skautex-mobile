import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'acess.dart';

class ItemList<T> with Access {
	final _repository = Repository();

	final _uris       = PublishSubject<List<String>>();
	final _output     = BehaviorSubject<Map<String, Future<T>>>();
	final _input      = PublishSubject<String>();

	get uris      => _uris.stream;
	get fetchItem => _input.sink.add;
	get watcher   => _output.stream;

	ItemList() {
		_input.transform(_fetch()).pipe(_output);
	}

	fetchUris() async {
		final uris = await _repository.fetchUris<T>(otp);
		_uris.sink.add(uris);
	}

	_fetch() {
		return ScanStreamTransformer<String, Map<String, Future<T>>>(
			(Map<String, Future<T>> map, String uri, _) {
				map[uri] = _repository.fetchItem<T>(otp, uri);
				return map;
			},
			<String, Future<T>> {}
		);
	}

	dispose() {
		_uris.close();
		_output.close();
		_input.close();
	}
}
