import 'package:flutter/material.dart';

import 'bloc/bloc.dart';
import 'view.dart';

class AddReport extends StatelessWidget {
	final Function updateUpperPage;

	AddReport({@required this.updateUpperPage});

	Widget build(BuildContext context) {
		return Provider(child: View(), context: context, updateUpperPage: updateUpperPage);
	}
}
