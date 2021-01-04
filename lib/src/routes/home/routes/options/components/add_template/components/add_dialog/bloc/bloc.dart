import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/upload.dart';
import 'package:skautex_mobile/src/models/file.dart';
import 'package:skautex_mobile/src/models/invitation_template.dart';
import 'package:path/path.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Upload<InvitationTemplate> {
	final Function reloadTemplates;
	final _file = BehaviorSubject<String>();
	final _name = BehaviorSubject<String>();

	get file => _file.stream;
	get changeFile => _file.sink.add;

	get name => _name.stream;
	get changeName => _name.sink.add;

	Bloc(BuildContext context, {this.reloadTemplates}) {
		otp = context;
		item.listen((i) => i.then((i) {reloadTemplates();}));
	}

	addTemplate() {
		uploadItem(
			InvitationTemplate(
				name: basename(_file.value),
				templateFile: _file.value
			)
		);
	}

	dispose() {
		_file.close();
		_name.close();
		super.dispose();
	}
}
