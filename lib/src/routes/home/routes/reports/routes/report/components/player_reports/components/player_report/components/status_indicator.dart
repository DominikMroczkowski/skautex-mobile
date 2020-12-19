import 'package:flutter/material.dart';

	Widget _statusIndicator(String status) {
		var polish = {
			'TODO' : 'Do zrobienia',
			'CLOSED' : 'Zamknięty',
			'DONE' : 'Zrobiony'
		};

		MaterialColor color;
		if (status == 'TODO')
			color = Colors.red;
		if (status == 'CLOSED')
			color = Colors.green;
		if (status == 'DONE')
			color = Colors.green;

    Widget circle = new Container(
			constraints: new BoxConstraints(
    		minHeight: 10.0,
    		minWidth: 10.0,),
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );

		return Row(children: <Widget>[
			circle,
			Container(padding: EdgeInsets.only(left: 5.0)),
			Text(polish[status])
		]);
	}

