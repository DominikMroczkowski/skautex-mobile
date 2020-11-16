import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/user.dart';
import 'package:skautex_mobile/src/routes/home/routes/bookings/routes/booking/components/bans/components/add/bloc/bloc.dart' as add;
import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<User> {
	final add.Bloc _addBloc;

	changeUser(User user) {
		_addBloc.changeUser(user);
	}

	Bloc(BuildContext context, {add.Bloc bloc}):
		this._addBloc = bloc {
		otp = context;
		super.fetch();
	}
}
