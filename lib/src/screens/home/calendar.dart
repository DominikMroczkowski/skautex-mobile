import 'package:flutter/material.dart';
import '../../widgets/homeDrawer.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
	const Calendar({ Key key }) : super(key: key);

  @override
  createState() => _State();
}

class _State extends State<Calendar> {
	CalendarController _calendarController;

	Widget build(context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Kalendarz')
			),
			drawer: HomeDrawer(),
			body: TableCalendar(
	    	calendarController: _calendarController
			)
	  );
	}

	@override
	void initState() {
	  super.initState();
	  _calendarController = CalendarController();
	}

	@override
	void dispose() {
	  _calendarController.dispose();
	  super.dispose();
	}
}
