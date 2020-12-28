import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'package:skautex_mobile/src/models/invitation.dart';
import 'bloc/bloc.dart';

import 'components/delete/delete.dart';
import 'components/download/download.dart';

class View extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);

		return StreamList(
			itemsWatcher: bloc.itemsWatcher,
			requestWatcher: bloc.requestWatcher,
			scrollable: false,
			tile: (i) => _tile(i)
		);
	}

	Widget _tile(Invitation i) {
		return Card(
			child: ListTile(
				title: Text('Trener ' + i.trainer.toString()),
				subtitle: Text('Data utworzenia: ' + i.creationDate.toString()),
				trailing: _popMenu(i)
			),
		);
	}

	Widget _popMenu(Invitation i) {
		final items = <PopupMenuItem>[
			PopupMenuItem(child: Download(invitation: i), enabled: false),
			PopupMenuItem(child: Delete(invitation: i), enabled: false)
		];
		return PopupMenuButton(
			itemBuilder:(_) => items
		);

	}
}
