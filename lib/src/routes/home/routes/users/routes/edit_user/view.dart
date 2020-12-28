import 'package:flutter/material.dart';

import 'bloc/bloc.dart' as editUser;

import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';
import 'package:skautex_mobile/src/helpers/widgets/home_drawer.dart';
import 'package:skautex_mobile/src/helpers/widgets/card_body.dart';
import 'package:skautex_mobile/src/helpers/widgets/view_item_list.dart';

import 'package:skautex_mobile/src/models/user.dart';

class View extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		editUser.Provider.of(context).init();
		return Scaffold(
			body: body(context),
			appBar: AppBar(
				title: Text('Edytuj użytkownika')
			),
			drawer: HomeDrawer(),
		);
	}

	Widget body(BuildContext context) {
		return SingleChildScrollView(
			child: Column(
				children: [
					CardBody(
						children: [
							ViewItemList.withCustomWidget(
								[['Nazwa', ''], ['Imię', ''], ['Nazwisko', ''], ['Email', ''], ['Hasło', '']],
								[_name(context), _firstName(context), _lastName(context), _email(context), _password(context)]
							),
							_submitButton(context)
						]
					),
				]
			),
		);
	}

	Widget _name(context) {
		final p = editUser.Provider.of(context);

		return StreamBuilder(
			stream: p.name,
			builder: (context, snapshot) {
				if (!snapshot.hasData)
					return CircularIndicator.color(Colors.blue);
				return TextFormField(
					initialValue: snapshot.data,
					onChanged: p.changeName,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _firstName(context) {
		final p = editUser.Provider.of(context);

		return StreamBuilder(
			stream: p.firstName,
			builder: (context, snapshot) {
				if (snapshot.data == null)
					return CircularIndicator.color(Colors.blue);
				return TextFormField(
					initialValue: snapshot.data,
					onChanged: p.changeFirstName,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _lastName(context) {
		final p = editUser.Provider.of(context);

		return StreamBuilder(
			stream: p.lastName,
			builder: (context, snapshot) {
				if (snapshot.data == null)
					return CircularIndicator.color(Colors.blue);
				return TextFormField(
					initialValue: snapshot.data,
					onChanged: p.changeLastName,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}


	Widget _email(context) {
		final p = editUser.Provider.of(context);

		return StreamBuilder(
			stream: p.email,
			builder: (context, snapshot) {
				if (snapshot.data == null)
					return CircularIndicator.color(Colors.blue);
				return TextFormField(
					initialValue: snapshot.data,
					onChanged: p.changeEmail,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _password(context) {
		final p = editUser.Provider.of(context);

		return StreamBuilder(
			stream: p.password,
			builder: (context, snapshot) {
				if (snapshot.data == null)
					return CircularIndicator.color(Colors.blue);
				return TextFormField(
					initialValue: snapshot.data,
					onChanged: p.changePassword,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _submitButton(context) {
		final p = editUser.Provider.of(context);

		return Row(
			children: [
				Expanded(child: Container()),
				RaisedButton(
					onPressed: () { p.update(); },
					child: _indicator(p),
					color: Colors.blue,
				),
				Expanded(child: Container())
			]
		);
	}

	Widget _indicator(editUser.Bloc p) {
		return  StreamBuilder(
			stream: p.item,
			builder: (context, AsyncSnapshot<Future<User>> snapshot) {
				if (snapshot.hasData)
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, AsyncSnapshot<User> snapshot) {
							if (!snapshot.hasData)
								return CircularIndicator();
							return Text('Edytuj');
						}
					);
				return Text('Edytuj');
			}
		);
	}
}
