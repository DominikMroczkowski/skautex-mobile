import 'package:flutter/material.dart';

class Login extends StatelessWidget {

	Widget build(context) {
		return SafeArea(
			child: mainNode()
		);
	}

	Widget mainNode() {
		return Container(
      			decoration: BoxDecoration(color: Colors.grey[100]),
			padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
			alignment: Alignment.center,
			child: Container (
				padding: EdgeInsets.all(20.0),
				constraints: BoxConstraints(maxHeight: 320),
				child: Column(
					children: [
						emailField(),
						passwordField(),
						Container(margin: EdgeInsets.only(top: 20.0)),
						submitButton(),
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

	Widget emailField() {
		return TextField(
			keyboardType: TextInputType.emailAddress,
			decoration: InputDecoration(
				hintText: 'simple@example.com',
				labelText: 'Email',
			)
		);
	}

	Widget passwordField() {
		return TextField(
			keyboardType: TextInputType.emailAddress,
			decoration: InputDecoration(
				hintText: 'password',
				labelText: 'Password',
			)
		);
	}

	Widget submitButton() {
		return RaisedButton(
			child: Text('Login'),
			color: Colors.blue,
		);
	}

	Widget forgetPassword() {
		return InkWell(
  			onTap: () {
     			},
     			child: new Text(
				"Remind password",
				style: TextStyle(color: Colors.blue)
			)
 		);
	}
}
