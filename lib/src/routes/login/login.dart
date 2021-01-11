import 'package:flutter/material.dart';

import 'package:skautex_mobile/src/bloc/bloc.dart' as session;
import 'package:skautex_mobile/src/routes/login/bloc/bloc.dart' as login;
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';

class Login extends StatelessWidget {
	Widget build(BuildContext context) {
		return login.Provider(
			child: View()
		);
	}
}

class View extends StatelessWidget {
	Widget build(BuildContext context) {
		return Scaffold(
			body: SafeArea(
				child: body(context)
			),
			appBar: AppBar(
				title: Text('Logowanie')
			),
		);
	}

	Widget body(c) {
		final s = session.Provider.of(c);
		final l = login.Provider.of(c);

		return StreamBuilder(
			stream: s.otp,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, snapshot) {
							if (snapshot.hasError) {
								return mainNode(l, s, c);
							}
							return Center(child: CircularProgressIndicator());
						}
					);
				}
				return mainNode(l, s, c);
			}
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
				bool submitValid = false;
				if (snapshot.hasData)
					submitValid = snapshot.data;
				return RaisedButton(
					child: LoginIndicator(stream: s.jwt),
					color: Colors.blue,
					onPressed: submitValid ? () {l.submit(s);} : null
				);
			}
		);
	}

	Widget forgetPassword(BuildContext c) {
		return Container(
			height: 0.0,
			width: 0.0
		);
	}
}

class LoginIndicator extends StatelessWidget {
	final Stream stream;
	LoginIndicator({this.stream});

	build(BuildContext context) {
		return StreamBuilder(
			stream: stream,
			builder: (_, snapshot) {
				if (snapshot.hasData) {
					return FutureBuilder(
						future: snapshot.data,
						builder: (_, snapshot) {
							if ((!snapshot.hasData && !snapshot.hasError))
								return CircularIndicator();
							return Text('Zaloguj');
						}
					);
				}
				return Text('Zaloguj');
			}
		);
	}

	void logErrors(String jWT, BuildContext context) {
		showDialog(
			context: context,
			child: AlertDialog(
				title: Text('Błąd'),
				content: Text(jWT),
				actions: <Widget>[
					FlatButton(
						onPressed: Navigator.of(context, rootNavigator: true).pop,
						child: Text('Ok')
					)
				]
			)
		);
	}
}
