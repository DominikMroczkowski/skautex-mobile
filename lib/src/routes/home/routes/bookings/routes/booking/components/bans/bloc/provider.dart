import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final bans;

	Provider({Key key, Widget child, BuildContext context, @required Booking booking}) :
		bans = Bloc(context, booking: booking),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).bans;
	}
}
