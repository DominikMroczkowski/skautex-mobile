import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/invitation.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Delete extends StatelessWidget {
	final Invitation invitation;

	Delete({@required this.invitation});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			invitation: invitation
		);
	}
}

