import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/user.dart';
import 'package:skautex_mobile/src/helpers/blocs/add.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Add<User> {

	final _username  = BehaviorSubject<String>();
	final _firstname = BehaviorSubject<String>();
	final _lastname  = BehaviorSubject<String>();
	final _email     = BehaviorSubject<String>();
	final _password  = BehaviorSubject<String>();

	Stream<String> get name => _username.stream;
	Stream<String> get firstName => _firstname.stream;
	Stream<String> get lastName => _lastname.stream;
	Stream<String> get email => _email.stream;
	Stream<String> get password => _password.stream;

	Function(String) get changeName => _username.sink.add;
	Function(String) get changeFirstName => _firstname.sink.add;
	Function(String) get changeLastName => _lastname.sink.add;
	Function(String) get changeEmail => _email.sink.add;
	Function(String) get changePassword => _password.sink.add;

	Bloc(BuildContext context) {
		otp = context;
		setContext(context);
		item.transform(_errorMessenger(context));
	}

	add() {
		User user = User(
			username: _username.value,
			firstName: _firstname.value,
			lastName: _lastname.value,
			email: _email.value,
			password: _password.value
		);
		addItem(user);
	}

	_errorMessenger(BuildContext context) {
		return StreamTransformer<Future<User>, Future<User>>.fromHandlers(
			handleData: (Future<User> item, sink) {
				print('Why does it now working oh god ');
				item.then(
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
				);
			}
		);
	}

	dispose() {
		_username.close();
		_firstname.close();
		_lastname.close();
		_email.close();
		_password.close();
	}
}
