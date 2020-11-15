import 'package:flutter/material.dart';
import 'bloc.dart';
import 'package:skautex_mobile/src/routes/home/routes/bookings/bloc/bloc.dart' as booking;

class Provider extends InheritedWidget {
	final addDialog;

	Provider({Key key, Widget child, BuildContext context, booking.Bloc bloc}) :
		addDialog = Bloc(context, bloc),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).addDialog;
	}
}
