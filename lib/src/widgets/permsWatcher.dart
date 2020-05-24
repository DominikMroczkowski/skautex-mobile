import 'package:flutter/material.dart';

import '../blocs/user/bloc.dart' as user;

import '../models/permissions.dart';

class PermsWatcher {

	static Widget watcher(context, Widget child) {
		final u = user.Provider.of(context);

		return StreamBuilder(
			stream: u.me,
			builder: (context, snapshot) {
				return permsWatcher(context, child);
			}
		);
	}

	static Widget permsWatcher(context, Widget child) {
		final u = user.Provider.of(context);
		return StreamBuilder(
			stream: u.permissions,
			builder: (context, snapshot) {
				return FutureBuilder(
					future: snapshot.data,
					builder: (_, __) {
						return child;
					},
				);
			}
		);
	}

}
