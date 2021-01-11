import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/access.dart';
import 'package:skautex_mobile/src/resources/repository.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc with Access {
	final _output = PublishSubject<Future<Object>>();
	final _input  = PublishSubject<Object>();

	Stream<Future<Object>> get item => _output.stream;

	final _repository = Repository();

	sendCodeOnEmail() {
		_input.sink.add(Object());
	}

	Bloc({@required BuildContext context}) {
		otp = context;
		_input.transform(_fetch()).pipe(_output);
	}

	_fetch() {
		return StreamTransformer<Object, Future<Object>>.fromHandlers(
			handleData: (Object item, sink) {
				sink.add(_repository.sendCodeOnEmail(otp));
			}
		);
	}

	dispose() {
		_output.close();
	}
}
