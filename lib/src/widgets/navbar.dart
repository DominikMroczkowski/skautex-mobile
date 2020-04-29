import 'package:flutter/material.dart';
import '../blocs/user/bloc.dart';

class AuthCode extends StatelessWidget {

	Widget build(context) {
		final user = Provider.of(context);

		return mainNode(user);
	}

	Widget mainNode(Bloc bloc) {
		return Container(
      			decoration: BoxDecoration(color: Colors.white),
			alignment: Alignment.left,
			child: Column(
				children: [
					userField(bloc),
					submitButton(bloc),
					noDevice(bloc)
				]
			),
		);
	}

	Widget userField(Bloc bloc) {
		return StreamBuilder(
			stream bloc.id,
			builder: (context, snapshot) {
				return Row(
					children: [
						user.image,
						Column(
							children: [
								Text(user.name),
								Text(user.role)
							]
						)
					]
				);
			}
		);
	}
}
