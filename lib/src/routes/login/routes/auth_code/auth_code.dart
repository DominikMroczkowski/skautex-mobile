import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/bloc/bloc.dart' as session;
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';

import 'bloc/bloc.dart' as auth_code;

class AuthCode extends StatelessWidget {

	Widget build(context) {
		final a = auth_code.Provider.of(context);
		final s = session.Provider.of(context);

		return Scaffold(
			body: SafeArea( child: mainNode(a, s)),
			appBar: AppBar(
				title: Text('Podaj kod')
			),
		);
	}

	Widget mainNode(a, s) {
		return Container(
      			decoration: BoxDecoration(color: Colors.grey[100]),
			padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
			alignment: Alignment.center,
			child: Container (
				padding: EdgeInsets.all(20.0),
				constraints: BoxConstraints(maxHeight: 320),
				child: Column(
					children: [
						codeField(a),
						Expanded(
							child: Container(margin: EdgeInsets.only(top: 20.0))
						),
						Row(
							children: [
								noDevice(s),
								Expanded( child: Container()),
								submitButton(a, s),
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

	Widget codeField(auth_code.Bloc bloc) {
		return StreamBuilder(
			stream: bloc.code,
			builder: (context, snapshot) {
				return TextField(
					onChanged: bloc.changeCode,
					keyboardType: TextInputType.number,
					decoration: InputDecoration(
						hintText: '123456',
						labelText: 'Kod',
						border: new OutlineInputBorder(),
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget submitButton(auth_code.Bloc a, session.Bloc s) {
		return StreamBuilder(
			stream: a.submitValid,
			builder: (context, snapshot) {
				return RaisedButton(
					child: indicator(s, a),
					color: Colors.blue,
					onPressed:
						snapshot.hasData ? () {a.submit(s);} : null
				);
			}
		);
	}

	Widget indicator(session.Bloc s, auth_code.Bloc a) {
		return  StreamBuilder(
			stream: s.otp,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, snapshot) {
							if (!snapshot.hasData && !snapshot.hasError) {
								return CircularIndicator();
							}
							return Text('Zaloguj');
						}
					);

				}
				return Text('Zaloguj');
			}
		);
	}

	Widget noDevice(session.Bloc s) {
		return FlatButton(
     			onPressed: () {
				s.sendCodeOnEmail();
			},
     			child: new Text(
				"Nie mam urządzenia",
				style: TextStyle(color: Colors.blue)
			)
 		);
	}

}
