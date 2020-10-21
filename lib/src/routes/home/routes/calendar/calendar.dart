import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/models/user.dart';
import 'package:skautex_mobile/src/helpers/widgets/homeDrawer.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
	const Calendar({ Key key }) : super(key: key);

  @override
  createState() => _State();
}

class Event {
	String name;
	List<Player> player;
	User user;

	Event({this.name, this.player, this.user});
}

class _State extends State<Calendar> {
	CalendarController _calendarController;
	List selected = [];
	Map<DateTime, List<dynamic>> events = {
		DateTime.now() : ['Obserwacja 1', 'Obserwacja 2']
	};

	Widget build(context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Kalendarz')
			),
			drawer: HomeDrawer(),
			body: SizedBox.expand(
				child: SingleChildScrollView (
					child: Column(
						children: <Widget>[
							TableCalendar(
				    		calendarController: _calendarController,
								locale: 'pl_PL',
								events: events,
								onDaySelected: (date, list) {
									setState(
										() {
											selected = list;
									});
								},
							),
							_list()
						],
					),
				)
			)
		);
	}

	_list() {
		return Column(
			children: selected.map(
				(i) {
					return Card(
						child: Container(
							child: Column (
								children: [
									Row( children: [
										Expanded(child:Text(i),)
									]
									)
								]
							),
							padding: EdgeInsets.all(15.0),
						),
					);
				}
			).toList()
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
