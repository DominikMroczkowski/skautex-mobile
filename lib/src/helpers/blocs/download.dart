import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'access.dart';

class Download with Access {
	final _repository = Repository();

	final _output = PublishSubject<Future<String>>();
	final _input = PublishSubject<String>();

	Function(String) get downloadItem => _input.sink.add;
	Stream<Future<String>> get item => _output.stream;

	Download() {
		_input.transform(_fetch()).pipe(_output);
	}

	_fetch() {
		return StreamTransformer<String, Future<String>>.fromHandlers(
			handleData: (String uri, sink) {
				sink.add(_repository.downloadItem(otp, uri));
			}
		);
	}

	dispose() {
		_output.close();
		_input.close();
	}
}
