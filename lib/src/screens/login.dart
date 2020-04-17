import 'package:flutter/material.dart';
import '../blocs/login/login.dart';

class Login extends StatelessWidget {

	Widget build(context) {
		final bloc = Provider.of(context);

		return SafeArea(
			child: mainNode(bloc)
		);
	}

	Widget mainNode(LoginBloc bloc) {
		return Container(
      			decoration: BoxDecoration(color: Colors.grey[100]),
			padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
			alignment: Alignment.center,
			child: Container (
				padding: EdgeInsets.all(20.0),
				constraints: BoxConstraints(maxHeight: 320),
				child: Column(
					children: [
						emailField(bloc),
						passwordField(bloc),
						Expanded(
							child: Container(margin: EdgeInsets.only(top: 20.0))
						),
						submitButton(bloc),
						forgetPassword()
					]
				),
      				decoration: BoxDecoration(
					color: Colors.white,
					borderRadius: BorderRadius.circular(10.0)
				),
			)
		);
	}

	Widget emailField(LoginBloc bloc) {
		return StreamBuilder(
			stream: bloc.email,
			builder: (context, snapshot) {
				return TextField(
					onChanged: bloc.changeEmail,
					keyboardType: TextInputType.emailAddress,
					decoration: InputDecoration(
						hintText: 'simple@example.com',
						labelText: 'Email',
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget passwordField(LoginBloc bloc) {
		return StreamBuilder(
			stream: bloc.password,
			builder: (context, snapshot) {
				return TextField(
					onChanged: bloc.changePassword,
					obscureText: true,
					decoration: InputDecoration(
						hintText: '********',
						labelText: 'Hasło',
						errorText: snapshot.error
					)
				);
			}

		);
	}

	Widget submitButton(LoginBloc bloc) {
		return StreamBuilder(
			stream: bloc.submitValid,
			builder: (context, snapshot) {
				return RaisedButton(
					child: Text('Zaloguj'),
					color: Colors.blue,
					onPressed: snapshot.hasData ? bloc.submit : null
				);
			}
		);
	}

	Widget forgetPassword() {
		return InkWell(
  			onTap: () {
     			},
     			child: new Text(
				"Przypomnij hasło",
				style: TextStyle(color: Colors.blue)
			)
 		);
	}
}
