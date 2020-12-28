import 'package:flutter/material.dart';

import 'bloc/bloc.dart';
import 'view.dart';

class AddInvitation extends StatelessWidget {
	AddInvitation();

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
		);
	}
}

