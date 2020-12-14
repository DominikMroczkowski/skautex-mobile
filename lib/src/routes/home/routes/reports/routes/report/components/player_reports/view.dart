import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player_report.dart';
import 'package:skautex_mobile/src/routes/home/routes/reports/routes/report/bloc/bloc.dart' as report;
import 'bloc/bloc.dart';
import 'components/player_report/player_report.dart' as components;

class View extends StatelessWidget {

	Widget build(BuildContext context) {
		final bloc = Provider.of(context);
		return StreamBuilder(
			stream: bloc.reports,
			builder: (_, snapshot) {
				if (snapshot.hasData)
					return _data(snapshot.data, context, bloc);
				return _loading();
			}
		);
	}
	Widget _loading() {
		return Center(child: CircularProgressIndicator());
	}

	Widget _data(List<PlayerReport> list, BuildContext context, Bloc bloc) {
		return StreamBuilder(
			stream: bloc.report,
			builder: (context, snapshot) {
				return SingleChildScrollView(
					child: Column(
						children: [
							_dropdown(list, snapshot.data, bloc),
							components.PlayerReport(playerReport: snapshot.data, updateReport: report.Provider.of(context).update)
						],
					)
				);
			}
		);
	}

	Widget _dropdown(List<PlayerReport> list, PlayerReport value, Bloc bloc) {
		List<DropdownMenuItem<PlayerReport>> items = [];
		list.forEach(
			(i) {
				items.add(
					DropdownMenuItem(
						child: Text(i.player.toString()),
						value: i,
					)
				);
			}
		);

		return _padding(DropdownButtonFormField(
			items: items,
			onChanged: (i) {
				bloc.changeReport(i);
			},
			value: value,
			isExpanded: true,
			decoration: InputDecoration(
				labelText: "Wybierz zawodnika"
			),
		));
	}

	Widget _padding(Widget child) {
		return Container(
			child: child,
			padding: EdgeInsets.all(8.0)
		);
	}
}
