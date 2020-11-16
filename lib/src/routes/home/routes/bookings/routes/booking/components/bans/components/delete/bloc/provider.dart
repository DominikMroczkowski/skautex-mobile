import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking_blacklist.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final ban;

	Provider({Key key, Widget child, BuildContext context, BookingBlacklist blacklist}) :
		ban = Bloc(context, blacklist: blacklist),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).ban;
	}
}
