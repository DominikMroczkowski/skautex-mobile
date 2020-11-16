import 'package:flutter/material.dart';
import 'bloc.dart';
import 'package:skautex_mobile/src/models/booking.dart';

class Provider extends InheritedWidget {
	final book;

	Provider({Key key, Widget child, BuildContext context, Booking booking}) :
		book = Bloc(context, booking),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).book;
	}
}
