import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'access.dart';

class Upload<T> with Access {
	final String uri;
	final _repository = Repository();

	final _output = PublishSubject<Future<String>>();
	final _input = PublishSubject<T>();

	Function(T) get uploadItem => _input.sink.add;
	Stream<Future<String>> get item => _output.stream;

	Upload({this.uri}) {
		_input.transform(_fetch()).pipe(_output);
	}

	_fetch() {
		return StreamTransformer<T, Future<String>>.fromHandlers(
			handleData: (T file, sink) {
				sink.add(_repository.uploadItem<T>(otp, uri, file));
			}
		);
	}

	dispose() {
		_output.close();
		_input.close();
	}
}
