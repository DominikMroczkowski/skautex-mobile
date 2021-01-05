import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/invitation_template.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Download extends StatelessWidget {
	final InvitationTemplate template;

	Download({this.template});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(template: template),
			template: template
		);
	}
}

