import 'dart:math';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import '../../models/player.dart';
import '../../models/user.dart';
import '../../widgets/homeDrawer.dart';

class Recommended extends StatefulWidget {
	const Recommended({ Key key }) : super(key: key);

  @override
  createState() => _State();
}

_generateExpanses() {
	List<Recomendation> list = [];

	for (int i = 0; i < 10; i++) {
		list.add(
			Recomendation(
				Player(
					name: 'Jan',
					surname: 'Kowalski',
				),
				DateTime.now().add(Duration(days: - (Random().nextInt(5)))),
				User(firstName: 'Jan', lastName: 'Kowalski'),
			)
		);
	}

	return list;
}

class _State extends State<Recommended> {
	List<Recomendation> _expenses = _generateExpanses();

	Widget build(context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Polecenia')
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
		_expenses.sort((Recomendation a, Recomendation b) => a.date.compareTo(b.date));
		_expenses.forEach((i) {
			list.add(_bookTile(i));
		});
		return list;
	}

	Widget _bookTile(Recomendation book) {
		return Card(
			child: Container(
				child: ExpansionTile(
					title: Text(book.player.name + ' ' + book.player.surname),
					children: [
						Text('Trener: ' + book.user.firstName + ' ' + book.user.lastName),
						Text('Data: ' + formatDate(book.date, [yyyy, '-', mm, '-', dd])),
					],
				),
				padding: EdgeInsets.all(5.0)
			)
		);
	}
}
class Recomendation {
	Player player;
	User user;
	DateTime date;

	Recomendation([this.player, this.date, this.user, ]);
}
