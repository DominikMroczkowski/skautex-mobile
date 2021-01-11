import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/positions.dart';
import 'package:skautex_mobile/src/helpers/widgets/home_drawer.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'package:skautex_mobile/src/models/ranking.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget {
	Widget build(context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Ranking zawodników'),
			),
			body: _body(context),
			drawer: HomeDrawer(),
			backgroundColor: Colors.white
		);
	}

	Widget _body(BuildContext context) {
		final bloc = Provider.of(context);

		return SingleChildScrollView(
			child: Column(
				children: [
					_padding(_choosePosition(bloc)),
					_top5(bloc)
				],
			),
		);
	}

	Widget _choosePosition(Bloc bloc) {
		List<DropdownMenuItem<String>> items = [];
		positions.forEach(
			(i) {
				items.add(DropdownMenuItem(
					value: i,
					child: Text(getPolishPosition(i))
				));
			}
		);

		return StreamBuilder(
			stream: bloc.position,
			builder: (_, snapshot) {
				if (snapshot.data != null && !positions.contains(snapshot.data))
					items.add(DropdownMenuItem(
						value: snapshot.data,
						child: Text(snapshot.data)
					));
				return DropdownButtonFormField(
					items: items,
					value: snapshot.data,
					onChanged: bloc.changePosition,
					decoration: InputDecoration(
						labelText: 'Pozycja',
						hintText: 'Wybierz pozycję'
					),
				);
			}
		);
	}

	Widget _top5(Bloc bloc) {
		return StreamList(
			itemsWatcher: bloc.top5,
			scrollable: false,
			tile: (i) => _padding(_rankingTile(i))
		);
	}

	Widget _rankingTile(Ranking i) {
		return Card(
			child: ListTile(
				leading: Text(i.score.toString()),
				title: Text(i.player.toString())
			)
		);
	}

	Widget _padding(Widget child) {
		return Container(
			child: child,
			padding: EdgeInsets.all(5.0)
		);
	}

}
