import 'package:flutter/material.dart';

import 'bloc/bloc.dart' as users;
import 'view.dart';

class Users extends StatelessWidget {
	Widget build(context) {
		return users.Provider(
			context: context,
			child: View()
		);
	}
}


