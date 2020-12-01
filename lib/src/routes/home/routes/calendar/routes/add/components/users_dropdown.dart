import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:skautex_mobile/src/models/user.dart';

class UsersDropdown extends StatelessWidget {
	final Function(List<User>) change;
	final Stream<Future<List<User>>> stream;
	final List<User> value;

	UsersDropdown({@required this.stream, @required this.value, @required this.change});

	build(BuildContext context) {
		return StreamBuilder(
			stream: stream,
			builder: (_, snapshot) {
				if (snapshot.hasData)
					return FutureBuilder(
						future: snapshot.data,
						builder: (_, snapshot) {
							if (snapshot.hasData)
								return _dropdown(snapshot.data);
							return loading();
						}
					);
				return loading();
			}
		);
	}

	_dropdown(List<User> data) {
		List<DropdownMenuItem<User>> items = [];

		data.forEach(
			(i) {
				if (value.contains(i))
					return;
				items.add(
					DropdownMenuItem<User>(
						value: i,
						child: Text(i.firstName + ' ' + i.lastName + ' #' + i.username),
					)
				);
			}
		);

		return SearchableDropdown.single(
			items: items,
			onChanged: (User i) {
				List<User> add = List.from(value);
				i != null ? add.add(i) : null;
				change(add);
			},
			value: value,
			isExpanded: true,
		);
	}

	loading() {
		return Column(
			children: [
				TextField(
					enabled: false,
				),
				LinearProgressIndicator()
			],
		);
	}

}
