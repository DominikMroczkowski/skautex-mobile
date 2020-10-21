import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/update.dart';
import 'package:skautex_mobile/src/helpers/blocs/item.dart';
import 'package:skautex_mobile/src/models/user.dart';
import 'package:skautex_mobile/src/bloc/bloc.dart' as session;
import 'package:skautex_mobile/src/routes/home/routes/users/routes/user/bloc/bloc.dart' as user;

import 'provider.dart';
export 'provider.dart';

class Bloc extends Update<User> {
	final Item<User> _init = Item<User>();

	final _uri       = BehaviorSubject<String>();
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

	final _clicked;
	Bloc(BuildContext context) :
		_clicked = session.Provider.of(context).clicked {
		otp = context;
		_init.otp = context;

		_init.item.listen(
			(Future<User> future) async {
				var user = await future;
				print('Does it have values' + user.uri);
				_uri.sink.add(user.uri);
				_username.sink.add(user.username);
				_firstname.sink.add(user.firstName);
				_lastname.sink.add(user.lastName);
				_email.sink.add(user.email);
				_password.sink.add('');
			}
		);

		item.listen(
			(Future<User> future) async {
				await future;
				user.Provider.of(context).fetchLastClicked();
				Navigator.of(context).popUntil((route) {
					return '/home/user' == route.settings.name;
				});
			}
		);
	}

	init() {
		_init.fetchItem(_clicked.value);
	}

	update() {
		User user = User(
			uri: _uri.value,
			username: _username.value,
			firstName: _firstname.value,
			lastName: _lastname.value,
			email: _email.value,
			password: _password.value
		);
		updateItem(user);
	}

	dispose() {
		_uri.close();
		_username.close();
		_firstname.close();
		_lastname.close();
		_email.close();
		_password.close();
	}
}
