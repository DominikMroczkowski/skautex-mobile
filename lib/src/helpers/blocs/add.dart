import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/resources/repository.dart';
import 'package:flutter/material.dart';
import 'access.dart';

class Add<T> with Access {
	final _repository = Repository();

	final _output     = PublishSubject<Future<T>>();
	final _input      = PublishSubject<T>();

	var context;
	Function(T) get addItem    => _input.sink.add;
	Stream<Future<T>> get item => _output.stream;

	setContext(BuildContext context) {
		this.context = context;
	}

	Add() {
		_input.transform(_fetch()).pipe(_output);
	}

	_fetch() {
		return StreamTransformer<T, Future<T>>.fromHandlers(
			handleData: (T item, sink) {
				sink.add(_repository.addItem<T>(otp, item).then(
					(_) {
						Navigator.of(context).pushNamed('/home');
					},
					onError: (error) {
						showDialog(
							context: context,
							child: AlertDialog(
								title: Text('Błąd'),
								content: Text(error),
								actions: <Widget>[
									FlatButton(onPressed: Navigator.of(context).pop, child: Text('Ok'))
								]
							)
						);
					}
				));
			}
		);
	}

	dispose() {
		_output.close();
		_input.close();
	}
}
