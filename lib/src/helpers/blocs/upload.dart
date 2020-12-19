import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/file.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'access.dart';

class Upload with Access {
	final _repository = Repository();

	final _output = PublishSubject<Future<String>>();
	final _input = PublishSubject<File>();

	Function(File) get uploadItem => _input.sink.add;
	Stream<Future<String>> get item => _output.stream;

	Upload() {
		_input.transform(_fetch()).pipe(_output);
	}

	_fetch() {
		return StreamTransformer<File, Future<String>>.fromHandlers(
			handleData: (File file, sink) {
				sink.add(_repository.uploadItem(otp, file.postUri, file));
			}
		);
	}

	dispose() {
		_output.close();
		_input.close();
	}
}
