import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/invitation_template.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Delete extends StatelessWidget {
	final InvitationTemplate template;
	final Function update;

	Delete({@required this.template, @required this.update});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			template: template,
			update: update
		);
	}
}

