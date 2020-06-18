import 'package:flutter/material.dart';
import '../../widgets/homeDrawer.dart';
import 'dart:math';
import 'package:date_format/date_format.dart';
import '../../models/player.dart';
import '../../models/user.dart';


class Test extends StatefulWidget {
	const Test({ Key key }) : super(key: key);

  @override
  createState() => _State();
}

_generateTests() {
	List<TestItem> list = [];
	var status = ['W trakcie', 'Ukończono'];
	var type = ['W grupie', 'Indywidualny'];

	for (int i = 0; i < 10; i++) {
		list.add(
			TestItem(
				player: Player(
					name: 'Jan',
					surname: 'Kowalski',
				),
				date: DateTime.now().add(Duration(days: - (Random().nextInt(5)))),
				trainer: User(firstName: 'Jan', lastName: 'Kowalski'),
				status: status[Random().nextInt(status.length)],
				type: type[Random().nextInt(type.length)]
			)
		);
	}

	return list;
}

class _State extends State<Test> {
	List<TestItem> _tests = _generateTests();

	Widget build(context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Testy')
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
		_tests.forEach((i) {
			list.add(_testTile(i));
		});
		return list;
	}

	Widget _testTile(TestItem item) {
		return Card(
			child: Container(
				child: ExpansionTile(
					title: Row(children: <Widget>[
						Text(item.player.name + ' ' + item.player.surname),
						Expanded(child: Container()),
						_indicator(item.status)
					],),
					children: [
						Text('Trener: ' + item.trainer.firstName + ' ' + item.trainer.lastName),
						Text('Data: ' + formatDate(item.date, [yyyy, '-', mm, '-', dd])),
						Text('Typ: ' + item.type)
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
			circle,
			Container(padding: EdgeInsets.only(left: 5.0)),
			Text(status)
		]);
	}
}

class TestItem {
	Player player;
	User trainer;
	String type;
	String status;
	DateTime date;

	TestItem({
		this.player,
		this.trainer,
		this.type,
		this.status,
		this.date
	});
}
