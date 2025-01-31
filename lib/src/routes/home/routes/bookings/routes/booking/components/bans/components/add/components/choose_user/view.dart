import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';
import 'bloc/bloc.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:skautex_mobile/src/models/user.dart';

class View extends StatelessWidget {

	Widget build(context) {
		final bloc = Provider.of(context);
		return StreamBuilder(
			stream: bloc.itemsWatcher,
			builder: (_, snapshot) {
				if (snapshot.hasData) {
					List<DropdownMenuItem<User>> items = [];
					snapshot.data.forEach(
						(i) =>
							items.add(
								DropdownMenuItem<User>(
									value: i,
									child: Text(i.username + ' - ' + i.firstName+ ' ' + i.lastName)
								)
							)
					);
					return SearchableDropdown.single(
						items: items,
						onChanged: (User i) {i != null ?  bloc.changeUser(i) : null;},
						isExpanded: true,
						displayClearIcon: false,
					);
				}
				return CircularIndicator();
			}
		);
	}
}

