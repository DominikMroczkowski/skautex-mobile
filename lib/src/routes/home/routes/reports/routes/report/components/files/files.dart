import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/report.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Files extends StatelessWidget {
	final Report report;

	Files({this.report});

	Widget build(BuildContext context) {
		return Provider(
			child: View(),
			context: context
		);
	}
}
