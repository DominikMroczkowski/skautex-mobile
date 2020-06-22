import 'package:flutter/material.dart';
import '../../widgets/homeDrawer.dart';
import '../../widgets/tile.dart';

class Options extends StatefulWidget {
	const Options({ Key key }) : super(key: key);

  @override
  createState() => _State();
}


class _State extends State<Options> {
	Widget build(context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Opcje')
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
		List<Widget> children = [];
		children.add(_header('Zweryfikowane urządzenia', Alignment.centerLeft));
		children += _devices();
		children.add(_header('Zmień hasło', Alignment.centerLeft));
		children.add(_changePassword());
		return children;
	}

	List<Widget> _devices() {
		return [
			Tile(children: <Widget>[],)
		];
	}

	Widget _changePassword() {
		return Container(
			child: Column(
				children: [
					_passwordField(),
					_changePasswordButton()
				]
			)
		);
	}

	_passwordField() {
		return TextFormField(
			decoration: InputDecoration(
				labelText: 'Hasło',
				border: new OutlineInputBorder(),
			)
		);
	}

	_changePasswordButton() {
		return RaisedButton(
			child: Text('Zmień'),
			color: Colors.blue,
			onPressed: null
		);
	}

	Widget _header(String name, Alignment alignment) {
		return Align(
			alignment: alignment,
			child: Text(
				name,
				style: TextStyle(
						fontSize: 16
				)
			)
		);
	}
}
