import 'package:flutter/material.dart';
import '../../widgets/homeDrawer.dart';
import 'dart:math';
import 'package:date_format/date_format.dart';
import '../../models/player.dart';
import '../../models/user.dart';


class Task extends StatefulWidget {
	const Task({ Key key }) : super(key: key);

  @override
  createState() => _State();
}

_generateTasks() {
	List<TaskItem> list = [];
	var status = ['W trakcie', 'Ukończono'];
	var names = ["Mecz Drużyna #1 - Drużyna #2", "Obserwacja zawodnika XYZ"];

	for (int i = 0; i < 10; i++) {
		list.add(
			TaskItem(
				player: Player(
					name: 'Jan',
					surname: 'Kowalski',
				),
				creator: User(firstName: 'Jan', lastName: 'Kowalski'),
				date: DateTime.now().add(Duration(days: - (Random().nextInt(5)))),
				participant: User(firstName: 'Adam', lastName: 'Nowak'),
				status: status[Random().nextInt(status.length)],
				name: names[Random().nextInt(names.length)]
			)
		);
	}
	return list;
}

class _State extends State<Task> {
	List<TaskItem> _tasks = _generateTasks();

	Widget build(context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Zadania')
			),
			drawer: HomeDrawer(),
			body: SizedBox.expand(
				child: SingleChildScrollView(
					child: Container(
						child: Column(
							children: _children()
						),
						padding: EdgeInsets.all(5),
						color: Colors.white
					),
				)
			),
		);
	}

	List<Widget> _children() {
		List<Widget> list = [];
		_tasks.forEach((i) {
			list.add(_testTile(i));
		});
		return list;
	}

	Widget _testTile(TaskItem item) {
		return Card(
			child: Container(
				child: ExpansionTile(
					title: Row(children: <Widget>[
						Expanded(
							child: Text(item.name),
							flex: 60
						),
						Expanded(
							child: _indicator(item.status),
							flex: 40
						)
					],),
					children: [
						Text('Twórca: ' + item.participant.firstName + ' ' + item.participant.lastName),
						Text('Wykonawca: ' + item.creator.firstName + ' ' + item.creator.lastName),
						Text('Data: ' + formatDate(item.date, [yyyy, '-', mm, '-', dd])),
					],
				),
				padding: EdgeInsets.all(5.0)
			)
		);
	}

	Widget _indicator(String status) {
		MaterialColor color;
		if (status == 'Ukończono')
			color = Colors.green;
		if (status == 'W trakcie')
			color = Colors.orange;
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
			Expanded(child:Container()),
			circle,
			Container(padding: EdgeInsets.only(left: 5.0)),
			SizedBox(child: Text(status, overflow: TextOverflow.fade))
		]);
	}
}

class TaskItem {
	Player player;
	User participant;
	User creator;
	String type;
	String status;
	DateTime date;
	String name;

	TaskItem({
		this.player,
		this.participant,
		this.creator,
		this.status,
		this.date,
		this.name
	});
}
