import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:skautex_mobile/src/models/user.dart';

import 'bloc/bloc.dart';

class View extends StatelessWidget {
	build(BuildContext context) {
		final bloc = Provider.of(context);

		return StreamBuilder(
			stream: bloc.itemsWatcher,
			builder: (_, snapshot) {
				if (snapshot.hasData)
					return _buildDropdown(snapshot.data, bloc);
				return loading();
			}
		);
	}

	_buildDropdown(List<User> data, Bloc bloc) {
		List<DropdownMenuItem<User>> items = [];

		data.forEach(
			(i) {
				items.add(
					DropdownMenuItem<User>(
						value: i,
						child: Text(i.toString()),
					)
				);
			}
		);

		return StreamBuilder(
			stream: bloc.user,
			builder: (_, snapshot) {
				final value = (snapshot.hasData) ? snapshot.data : null;
				return _dropdown(items, value, bloc.changeUser);
			}
		);
	}

	Widget _dropdown(List<DropdownMenuItem<User>> items, User value, Function onChanged) {
		return SearchableDropdown.single(
			items: items,
			onChanged: onChanged,
			value: value,
			isExpanded: true,
			label: 'Wybierz trenera'
		);
	}

	loading() {
		return Column(
			children: [
				TextField(
					enabled: false,
					decoration: InputDecoration(labelText: 'Wybierz użytkownika'),
				),
				LinearProgressIndicator()
			],
		);
	}

}
