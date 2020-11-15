import 'package:flutter/material.dart';
import 'bloc/bloc.dart' as userList;
import 'view.dart';

class Reservations extends StatelessWidget {
	Widget build(BuildContext context) {
		return userList.Provider(
			context: context,
			child: View()
		);
	}
}

