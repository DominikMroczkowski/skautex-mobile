import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'package:skautex_mobile/src/models/invitation_template.dart';
import 'package:path/path.dart';

import 'bloc/bloc.dart';
import 'components/delete/delete.dart';
import 'components/download/download.dart';

class View extends StatelessWidget {

	Widget build(context) {
		final bloc = Provider.of(context);

		return StreamList(
			itemsWatcher: bloc.itemsWatcher,
			requestWatcher: bloc.requestWatcher,
			tile: (i) => _tile(i, bloc),
		);
	}

	_tile(InvitationTemplate template, Bloc bloc) {
		return Card(
			child: ListTile(
				title: Text(template.name),
				subtitle: Text(basename(template.templateFile)),
				trailing: _actions(template, bloc),
			)
		);
	}

	Widget _actions(InvitationTemplate template, Bloc bloc) {
		final items = <PopupMenuItem>[
			PopupMenuItem(child: Delete(template: template, update: bloc.update), enabled: false),
			PopupMenuItem(child: Download(template: template), enabled: false)
		];
		return PopupMenuButton(
			itemBuilder:(_) => items
		);

	}
}
