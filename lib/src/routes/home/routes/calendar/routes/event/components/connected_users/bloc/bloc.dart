import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/event.dart';
import 'package:skautex_mobile/src/models/user.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<User> {
	final Event event;

	Bloc({this.event}) {
		super.fetch(uri: event.uri + '/connected_users/');
	}
}
