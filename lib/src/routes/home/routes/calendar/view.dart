import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/homeDrawer.dart';

import 'components/events/events.dart';
import 'components/table_calendar/table_calendar.dart';


class View extends StatelessWidget {

	Widget build(context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Kalendarz')
			),
			drawer: HomeDrawer(),
			body: _body(context)
		);
	}

	Widget _body(BuildContext context) {
		return Column(
			children: <Widget>[
				TableCalendar(),
				Expanded(child: Events())
			],
		);
	}
}
