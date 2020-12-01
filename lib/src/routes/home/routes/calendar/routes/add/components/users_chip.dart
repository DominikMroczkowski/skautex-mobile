import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/user.dart';

class UsersChip extends StatelessWidget {
	final Function(List<User>) change;
	final List<User> value;

	UsersChip({@required this.change, @required this.value});

	build(BuildContext context) {
		if (value.isEmpty)
			return _noData();
		return _chips(value);
	}

	_chips(List<User> data) {
		List<Widget> children = [];
		data.forEach(
			(i) {
				children.add(_user(i));
			}
		);
		return Wrap(
			spacing: 5.0,
			children: children
		);
	}

	_user(User user) {
		return Chip(
			label: Text(user.toString()),
			deleteIcon: Icon(Icons.clear, size: 14),
			onDeleted: () {
				List<User> users = [];
				value.forEach(
					(i) {
						if (i.uri != user.uri)
							users.add(i);
					}
				);
				change(users);}
		);
	}

	_noData() {
		return Text('Nie wybrano poleceń');
	}
}
