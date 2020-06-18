import 'package:intl/intl.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../widgets/homeDrawer.dart';
import 'package:date_format/date_format.dart';
import '../../models/user.dart';

class Expenses extends StatefulWidget {
	const Expenses({ Key key }) : super(key: key);

  @override
  createState() => _State();
}

_generateExpanses() {
	List<Expense> list = [];

	for (int i = 0; i < 10; i++) {
		list.add(
			Expense(
				_type.values[Random().nextInt(_type.values.length)],
				DateTime.now().add(Duration(days: - (Random().nextInt(5)))),
				User(firstName: 'Jan', lastName: 'Kowalski'),
				Random().nextDouble()
			)
		);
	}

	return list;
}

class _State extends State<Expenses> {
	List<Expense> _expenses = _generateExpanses();

	final _formatCurrency = new NumberFormat.simpleCurrency();
	Widget build(context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Wydatki')
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
			floatingActionButton: _addButton(context)
		);
	}

	List<Widget> _children() {
		List<Widget> list = [];
		_expenses.sort((Expense a, Expense b) => a.date.compareTo(b.date));
		bool first = true;
		DateTime date;
		_expenses.forEach((i) {
			if (first) {
				list.add(_header(formatDate(i.date, [yyyy, '-', mm, '-', dd]), Alignment.center));
				date = i.date;
				first = false;
			}
			if (i.date.day != date.day)
				list.add(_header(formatDate(i.date, [yyyy, '-', mm, '-', dd]), Alignment.center));

			list.add(_bookTile(i));
			date = i.date;
		});
		return list;
	}

	Widget _bookTile(Expense book) {
		return Card(
			child: Container(
				child: ExpansionTile(
					title: Row(children: [Text(_names[book.type.index]), Expanded(child: Container()), Text(_formatCurrency.format(book.money))]),
					children: [
						Text(book.user.firstName + ' ' + book.user.lastName),
						Text('Data: ' + formatDate(book.date, [yyyy, '-', mm, '-', dd])),
					],
				),
				padding: EdgeInsets.all(5.0)
			)
		);
	}

	Widget _header(String name, Alignment alignment) {
		return Container(
			child: Align(
			alignment: alignment,
			child: Text(
				name,
				style: TextStyle(
						fontSize: 22
				)
			)
		),
		padding: EdgeInsets.all(5)
		);
	}

	Widget _addButton(BuildContext context) {
		return FloatingActionButton(
     	onPressed: () {
				_showDialog(context);
     	},
     	child: Icon(Icons.add),
    	backgroundColor: Colors.blue,
    );
	}

	_showDialog(BuildContext context) async {
		final Expense sliderValue = await showDialog(
  		context: context,
  		builder: (context) => MyDialog(),
		);
		if (sliderValue != null) {
			setState(() {
				sliderValue.user = User();
				sliderValue.user.lastName = 'Kowalski';
				sliderValue.user.firstName = 'Jan';
				_expenses.add(sliderValue);
			});
		}
	}
}


class MyDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyDialogState();
  }
}

class _MyDialogState extends State<MyDialog> {
			Expense _toAdd = Expense();

      @override
      Widget build(BuildContext context) {

        return _alert(context);
      }

		_alert(context) {
			return AlertDialog(
				title: Text("Dodaj"),
				content: _form(),
				actions: [
					FlatButton(
						child: Text('Dodaj'),
						onPressed:() {
							Navigator.of(context).pop(_toAdd);
						}
					),
					FlatButton(child: Text('Anuluj'), onPressed:() {Navigator.of(context).pop(null);})
				]
			);
		}

		_form() {
			return SingleChildScrollView(
				child: Column(
				children: <Widget>[
					DropdownButton<_type>(
						items: _dropdownItems(),
						onChanged: (_type i) {
							setState(() {
								_toAdd.type = i;
							});
						},
						value: _toAdd.type
					),
					_datePicker(),
					_moneyField(),
				],
			));
	}

	_datePicker() {
		return GestureDetector(
		  onTap: () async {
				DateTime date = await showDatePicker(context: context, firstDate: DateTime.utc(1970, 1, 1), lastDate: DateTime.now(), initialDate: DateTime.utc(2000, 1, 1));
				if (date != null)
					setState( () {
						_toAdd.date = date;
					});
			},
  		child: AbsorbPointer(
    		child: _dateField(context)
  		)
		);
	}

	_moneyField() {
		return TextFormField(
			keyboardType: TextInputType.numberWithOptions(decimal: true),
			onChanged: (i) {
				setState(() { _toAdd.money = double.parse(i);});
			}
		);
	}

	Widget _dateField(context) {
		var controller = TextEditingController(text: _toAdd.date.toString());
		return TextField(
			controller: controller,
		);
	}

	List<DropdownMenuItem<_type>> _dropdownItems() {
		List<DropdownMenuItem<_type>> list = [];

		_type.values.forEach(
			(i) {
				list.add(
						DropdownMenuItem<_type>(value: i, child: Text(_names[i.index]))
				);
			}
		);
		return list;
	}
}

enum _type {
	fuel, hotel, food, inne
}

const _names = [
	'Paliwo', 'Hotel', 'Jedzenie', 'Inne'
];

class Expense {
	_type type;
	DateTime date;
	String optional;
	double money;
	User user;

	Expense([this.type, this.date, this.user, this.money, this.optional]);
}
