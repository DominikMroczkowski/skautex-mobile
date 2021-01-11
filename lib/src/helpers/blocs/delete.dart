import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'access.dart';

class Delete with Access {
	final _repository = Repository();

	final _output     = PublishSubject<Future<Object>>();
	final _input      = PublishSubject<String>();
	final Function onSuccess;

	Function(String) get addItem    => _input.sink.add;
	Stream<Future<Object>> get item => _output.stream;

	Delete({this.onSuccess}) {
		_input.transform(_fetch()).pipe(_output);
	}

	_fetch() {
		return StreamTransformer<String, Future<Object>>.fromHandlers(
			handleData: (String uri, sink) {
				sink.add(_repository.deleteItem(otp, uri));
			}
		);
	}

	dispose() {
		_output.close();
		_input.close();
	}
}
