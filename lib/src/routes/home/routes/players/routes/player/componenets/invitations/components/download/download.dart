import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/invitation.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Download extends StatelessWidget {
	final Invitation invitation;

	Download({this.invitation});

	Widget build(BuildContext context) {
		return Provider(
			child: View(),
			context: context,
			invitation: invitation
		);
	}
}
