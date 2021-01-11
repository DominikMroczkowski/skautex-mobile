import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/event.dart';
import 'package:skautex_mobile/src/models/connected_users.dart';
import 'package:skautex_mobile/src/models/user.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<ConnectedUser> {
	final Event event;

	Bloc(BuildContext context, {this.event}) : super(paging: 8) {
		otp = context;
		fetch(uri: event.uri + 'connected_users/');
	}
}
