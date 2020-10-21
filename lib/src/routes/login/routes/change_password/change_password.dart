import 'package:flutter/material.dart';
import '../../blocs/login/bloc.dart' as login;

class ChangePassword extends StatelessWidget {

	Widget build(context) {
		final l = login.Provider.of(context);

		return Scaffold(
			body:  SafeArea(
				child: mainNode(l)
			),
			appBar: AppBar(
				title: Text('Podaj email')
			),
		);
	}

	Widget mainNode(login.Bloc l) {
		return Container(
      			decoration: BoxDecoration(color: Colors.grey[100]),
			padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
			alignment: Alignment.center,
			child: Container (
				padding: EdgeInsets.all(20.0),
				constraints: BoxConstraints(maxHeight: 320),
				child: Column(
					children: [
						emailField(l),
						Expanded(
							child: Container(margin: EdgeInsets.only(top: 20.0))
						),
						submitButton(l),
					]
				),
      				decoration: BoxDecoration(
					color: Colors.white,
					borderRadius: BorderRadius.circular(10.0)
				),
			)
		);
	}

	Widget emailField(login.Bloc l) {
		return StreamBuilder(
			stream: l.email,
			builder: (context, snapshot) {
				return TextFormField(
					onChanged: l.changeEmail,
					initialValue: l.getEmailValue(),
					keyboardType: TextInputType.emailAddress,
					decoration: InputDecoration(
						hintText: 'simple@example.com',
						labelText: 'Email',
						border: new OutlineInputBorder(),
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget submitButton(login.Bloc l) {
		return StreamBuilder(
			stream: l.email,
			builder: (context, snapshot) {
				return RaisedButton(
					child: Text('Przypomnij'),
					color: Colors.blue,
					onPressed:
						snapshot.hasData ? () {Navigator.pushNamed(context, '/');} : null
				);
			}
		);
	}
}
