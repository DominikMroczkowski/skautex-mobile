import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/helpers/blocs/item.dart';
import 'package:skautex_mobile/src/helpers/blocs/delete.dart';
import 'package:skautex_mobile/src/models/user.dart';
import 'package:skautex_mobile/src/bloc/bloc.dart' as session;

class Bloc {
	final user = Item<User>();
	final _deactivate = Delete();

	final _clicked;

	Bloc(BuildContext context) :
		_clicked = session.Provider.of(context).clicked {
		user.otp = context;
		_deactivate.otp = context;
	}

	get deactivateOutput => _deactivate.item;

	deactivate() async {
		user.item.listen(
			(future) async {
				User _val = await future;
				_deactivate.addItem(_val.uri);
			}
		);
	}

	fetchLastClicked() {
		user.fetchItem(_clicked.value);
	}
}
