import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/invitation.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Delete extends StatelessWidget {
	final Invitation invitation;
	final Function update;

	Delete({@required this.invitation, @required this.update});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			invitation: invitation,
			update: update
		);
	}
}

