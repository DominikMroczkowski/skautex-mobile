import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/contact_detail.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Delete extends StatelessWidget {
	final ContactDetail contactDetail;
	final Function update;

	Delete({@required this.contactDetail, @required this.update});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			contactDetail: contactDetail,
			update: update
		);
	}
}

