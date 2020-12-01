import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/delete.dart';
import 'package:skautex_mobile/src/models/event.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Delete {
	final Event event;
	final GlobalKey<NavigatorState> navigator;

	delete() {
		addItem(event.uri);
	}

	Bloc(context, {this.event, this.navigator}) {
		otp = context;
	}
}
