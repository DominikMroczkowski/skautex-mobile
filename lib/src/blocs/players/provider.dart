import 'package:flutter/material.dart';
import 'bloc.dart';
import '../session/bloc.dart' as session;

class Provider extends InheritedWidget {
	final players = Bloc();

	Provider({Key key, Widget child})
		: super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		var s = session.Provider.of(context);
		s.setContext(context);

		var p = (context.inheritFromWidgetOfExactType(Provider) as Provider).players;
		p.setAccess(s.otp);

		return p;
	}

}
