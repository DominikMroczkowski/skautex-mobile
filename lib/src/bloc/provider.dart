import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final session;

	Provider({Key key, Widget child, BuildContext context}) :
		session = Bloc(context: context),
		super(key: key, child: child) {
			session.triggerDbLoader();
		}

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		var b = (context.inheritFromWidgetOfExactType(Provider) as Provider).session;
		b.setContext(context);
		return b;
	}
}
