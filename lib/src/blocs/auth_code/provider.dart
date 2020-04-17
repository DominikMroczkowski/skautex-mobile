import 'package:flutter/material.dart';
import 'auth_code.dart';

class Provider extends InheritedWidget {
	final authCode = AuthCodeBloc();

	Provider({Key key, Widget child})
		: super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static AuthCodeBloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).authCode;
	}

}
