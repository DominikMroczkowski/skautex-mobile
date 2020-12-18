import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final codeOnMail;

	Provider({Key key, Widget child, @required sessionBloc}):
		codeOnMail = Bloc(sessionBloc: sessionBloc),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).codeOnMail;
	}

}
