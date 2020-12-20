import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/file.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'access.dart';

class Download with Access {
	final _repository = Repository();

	final _output = PublishSubject<Future<String>>();
	final _input = PublishSubject<File>();

	downloadItem(File file, {String uri}) {
		_input.sink.add(
			File(
				file: file.file,
				uri: uri ?? file.uri
			)
		);
	}
	Stream<Future<String>> get item => _output.stream;

	Download() {
		_input.transform(_fetch()).pipe(_output);
	}

	_fetch() {
		return StreamTransformer<File, Future<String>>.fromHandlers(
			handleData: (File file, sink) {
				sink.add(_repository.downloadItem(otp, file.uri, file));
			}
		);
	}

	dispose() {
		_output.close();
		_input.close();
	}
}
