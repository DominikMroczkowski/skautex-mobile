import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';
import '../session/bloc.dart' as session;

import '../../models/user.dart';
import '../mixins/item.dart';

class Bloc {
	final user = Item<User>();

	final _clicked;

	Bloc(BuildContext context) :
		_clicked = session.Provider.of(context).clicked {
		user.otp = context;
	}

	fetchLastClicked() {
		user.fetchItem(_clicked.value);
	}
}
