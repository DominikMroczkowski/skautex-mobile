import 'package:flutter/material.dart';
import '../blocs/auth_code/bloc.dart';

class AuthCode extends StatelessWidget {

	Widget build(context) {
		final bloc = Provider.of(context);

		return Scaffold(
			body: SafeArea( child: mainNode(bloc)),
			appBar: AppBar(
				title: Text('Podaj kod')
			),
		);
	}

	Widget mainNode(Bloc bloc) {
		return Container(
      			decoration: BoxDecoration(color: Colors.grey[100]),
			padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
			alignment: Alignment.center,
			child: Container (
				padding: EdgeInsets.all(20.0),
				constraints: BoxConstraints(maxHeight: 320),
				child: Column(
					children: [
						codeField(bloc),
						Expanded(
							child: Container(margin: EdgeInsets.only(top: 20.0))
						),
						Row(
							children: [
								noDevice(bloc),
								Expanded( child: Container()),
								submitButton(bloc),
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

	Widget codeField(Bloc bloc) {
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

	Widget submitButton(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.submitValid,
			builder: (context, snapshot) {
				return RaisedButton(
					child: Text('Zaloguj'),
					color: Colors.blue,
					onPressed: snapshot.hasData ? () {bloc.submit(); Navigator.of(context).pushNamedAndRemoveUntil('/home', ModalRoute.withName('/'));} : null
				);
			}
		);
	}

	Widget noDevice(Bloc bloc) {
		return InkWell(
     			onTap: (){},
     			child: new Text(
				"Nie mam urządzenia",
				style: TextStyle(color: Colors.blue)
			)
 		);
	}

}
