import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final add;

	Provider({Key key, Widget child, BuildContext context, Booking booking}) :
		add = Bloc(context, booking: booking),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return context.dependOnInheritedWidgetOfExactType<Provider>().add;
	}
}
