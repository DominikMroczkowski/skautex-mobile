import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';
import '../session/bloc.dart' as session;

import '../../models/user.dart';
import '../mixins/item.dart';

class Bloc extends Item<User> {
	final user = Item<User>();
	final contact = Item<User>();

	final _clicked;

	Bloc(BuildContext context) :
		_clicked = session.Provider.of(context).clicked {
		otp = context;
		user.otp = context;
	}

	fetchLastClicked() {
		fetchItem(_clicked.value);
	}
}
