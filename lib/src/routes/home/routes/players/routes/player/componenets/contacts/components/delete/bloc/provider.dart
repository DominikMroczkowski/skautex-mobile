import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/contact_detail.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final delete;

	Provider({Key key, Widget child, BuildContext context, @required ContactDetail contactDetail, @required Function update}) :
		delete = Bloc(context, contactDetail: contactDetail, update: update),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).delete;
	}
}
