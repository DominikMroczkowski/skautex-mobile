import 'package:flutter/material.dart';

import '../../blocs/login/bloc.dart' as login;
import '../../blocs/session/bloc.dart' as session;

class Login extends StatelessWidget {

	Widget build(context) {
		final l = login.Provider.of(context);
		final s = session.Provider.of(context);

		return Scaffold(
			body: SafeArea(
				child: mainNode(l, s, context)
			),
			appBar: AppBar(
				title: Text('Logowanie')
			),
		);
	}

	Widget mainNode(login.Bloc l, session.Bloc s, BuildContext c) {
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
						Container(margin: EdgeInsets.only(top: 10.0)),
						passwordField(l),
						Expanded(
							child: Container(margin: EdgeInsets.only(top: 20.0))
						),
						Row(
							children: [
								forgetPassword(c),
								Expanded( child: Container()),
								submitButton(l, s)
							]
						)
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

	Widget passwordField(login.Bloc l) {
		return StreamBuilder(
			stream: l.passwordObscure,
			builder: (context, snapshot) {
				return TextField(
					onChanged: l.changePassword,
					obscureText: l.getObscureValue(),
					decoration: InputDecoration(
						hintText: '********',
						labelText: 'Hasło',
						border: new OutlineInputBorder(),
						suffix: GestureDetector(
							onTap: () {l.changeObscure(!l.getObscureValue());},
							child: Icon(
								Icons.check,
	      							color: Colors.black,
								size: 20
	    						)
						),
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget submitButton(login.Bloc l, session.Bloc s) {
		return StreamBuilder(
			stream: l.submitValid,
			builder: (context, snapshot) {
				return RaisedButton(
					child: Text('Zaloguj'),
					color: Colors.blue,
					onPressed:
						snapshot.hasData ? () { l.submit(s); Navigator.pushNamed(context, '/auth_code');} : null
				);
			}
		);
	}

	Widget forgetPassword(BuildContext c) {
		return InkWell(
  			onTap: () {
				Navigator.pushNamed(c, '/change_password');
     			},
     			child: new Text(
				"ZAPOMNIAŁEŚ HASŁA?",
				style: TextStyle(color: Colors.blue)
			)
 		);
	}
}
