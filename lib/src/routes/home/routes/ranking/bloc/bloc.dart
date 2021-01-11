import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/player.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/models/ranking.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

class Bloc extends ItemList<Ranking> {
	final _choosenPostion = BehaviorSubject<String>();
	final _top5 = BehaviorSubject<List<Ranking>>();

	get changePosition => _choosenPostion.sink.add;
	get position => _choosenPostion.stream;
	Stream get top5 => _top5.stream;

	Bloc(BuildContext context) {
		otp = context;
		super.fetch();
		Rx.combineLatest([itemsWatcher as Stream, _choosenPostion.stream], toTop5 ).pipe(_top5);
	}

	List<Ranking> toTop5(list) {
		List<Ranking> all = list[0];
		String position = list[1];
		if (all == null || position == null)
			return [];
		List<Ranking> top5 = [];
		all.forEach(
			(Ranking i) {
				if (i.player.position == position)
					top5.add(i);
			}
		);
		return top5;
	}

	dispose() {
		_choosenPostion.close();
		_top5.close();
		super.dispose();
	}
}
