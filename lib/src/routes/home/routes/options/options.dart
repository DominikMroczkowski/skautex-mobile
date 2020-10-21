import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/homeDrawer.dart';

class Options extends StatefulWidget {
	const Options({ Key key }) : super(key: key);

  @override
  createState() => _State();
}

class Device {
	String name;
	String address;
	Device({this.name, this.address});
}

class _State extends State<Options> {
	List<Device> _devicesList = [
		Device(name: "Sony Xperia", address: "Waszawa, Polska"),
		Device(name: "Samsung Galaxy", address: "Waszawa, Polska"),
		Device(name: "Icecat", address: "Konin, Polska"),
	];

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
		return _devicesList.map((i) => _deviceTile(i)).toList();
	}

	Widget _deviceTile(Device device) {
		return Container(
			child: _buildTile(device),
			padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
		);
	}

	Widget _buildTile(Device device) {
		return Card(
			child: Column(
				children: <Widget>[
					Align(
						child: Text(device.name),
						alignment: Alignment.centerLeft
					),
					Align(
						child: Text(device.address),
						alignment: Alignment.centerLeft
					),
					Row(
						children: <Widget>[
							FlatButton(child: Text('Usuń'), onPressed: null),
							Expanded(child: Container())
						],
					)
				],
			)
		);
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
