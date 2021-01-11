import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/invitation_template.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final download;

	Provider({Key key, Widget child, BuildContext context, @required InvitationTemplate template}) :
		download = Bloc(context, template: template),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).download;
	}
}
