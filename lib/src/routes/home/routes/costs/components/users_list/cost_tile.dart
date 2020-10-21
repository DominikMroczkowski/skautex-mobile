import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/cost.dart';
import 'package:skautex_mobile/src/helpers/widgets/tile.dart';

createCostTile(cost) {
	return CostTile(cost: cost);
}

class CostTile extends StatelessWidget {
	final Cost cost;

	CostTile({this.cost});

	Widget build(context) {
		return Container(
			child: buildTile(context, cost),
			padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
		);
	}

	Widget buildTile(BuildContext context, Cost cost) {
		List<Widget> children = [
			Align(
				child: Text(
					cost.name,
					style: TextStyle(
						fontSize: 18,
					)
				),
				alignment: Alignment.topLeft,
			),
		];

		return Tile(
			children: children,
			func: onTileTap,
			args: null,
			positionalArgs: [context]
		);
	}

	onTileTap(context)	{
		print('XD');
	}
}
