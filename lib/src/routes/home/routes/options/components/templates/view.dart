import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'package:skautex_mobile/src/models/invitation_template.dart';
import 'package:path/path.dart';

import 'bloc/bloc.dart';

class View extends StatelessWidget {

	Widget build(context) {
		final bloc = Provider.of(context);

		return StreamList(
			itemsWatcher: bloc.itemsWatcher,
			requestWatcher: bloc.requestWatcher,
			tile: (i) => _tile(i),
		);
	}

	_tile(InvitationTemplate template) {
		return Card(
			child: ListTile(
				title: Text(template.name),
				subtitle: Text(basename(template.templateFile)),
			)
		);
	}

}
