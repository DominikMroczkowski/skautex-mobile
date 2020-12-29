import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'package:skautex_mobile/src/models/contact_detail.dart';
import 'bloc/bloc.dart';

import 'components/delete/delete.dart';

class View extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);

		return StreamList(
			itemsWatcher: bloc.itemsWatcher,
			requestWatcher: bloc.requestWatcher,
			scrollable: false,
			tile: (i) => _tile(i, bloc)
		);
	}

	Widget _tile(ContactDetail i, Bloc bloc) {
		return Card(
			child: ListTile(
				title: Text('Trener ' + i.type),
				subtitle: Text( i.value.toString()),
				trailing: _popMenu(i, bloc)
			),
		);
	}

	Widget _popMenu(ContactDetail i, Bloc bloc) {
		final items = <PopupMenuItem>[
			PopupMenuItem(child: Delete(contactDetail: i, update: bloc.reloadContacts), enabled: false)
		];
		return PopupMenuButton(
			itemBuilder:(_) => items
		);

	}
}
