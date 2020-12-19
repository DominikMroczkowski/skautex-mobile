import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:skautex_mobile/src/models/response_list.dart';

class StreamList extends StatelessWidget {

	final Stream<List> itemsWatcher;
	final Stream<Future<ResponseList>> requestWatcher;
	final Function tile;
	final Function notify;
	final AutoScrollController controller;

	StreamList({this.itemsWatcher, this.requestWatcher, this.tile, this.controller, this.notify});

	Widget build(BuildContext context) {
		if (requestWatcher != null) {
			return StreamBuilder(
				stream: requestWatcher,
				builder: (_, snapshot) {
					if (snapshot.hasData)
						return _itemsWatcherBuilder();
					return Center(child: Text('Brak danych'));
				}
			);
		}

		return StreamBuilder(
			stream: itemsWatcher,
			builder: (context, AsyncSnapshot<List> items) {
				if (!items.hasData)
					return Center(child: CircularProgressIndicator());
				if (items.data.isEmpty)
					return Center(child: Text('Brak danych'));
				return list(items.data);
			}
		);
	}

	_itemsWatcherBuilder() {
		return StreamBuilder(
			stream: itemsWatcher,
			builder: (context, AsyncSnapshot<List> items) {
				if (!items.hasData || items.data.isEmpty)
					return Center(child: CircularProgressIndicator());
				return list(items.data);
			}
		);
	}

	Widget list(List list) {
  	return ListView.builder(
			itemCount: list.length,
			itemBuilder: (context, int index) {
				if (controller == null)
					return index == list.length - 1 && requestWatcher != null ?
						Column(children: [tile(list[index]), _getMore()]) :
						tile(list[index]);
				return AutoScrollTag(
					key: ValueKey(index),
					index: index,
					child: index == list.length - 1 && requestWatcher != null ?
						Column(children: [tile(list[index]), _getMore()]) :
						tile(list[index]),
					controller: controller,
				);
			},
			padding: EdgeInsets.only(bottom: 80),
			shrinkWrap: true,
			controller: controller,
		);
	}

	Widget _getMore() {
		return StreamBuilder(
			stream: requestWatcher,
			builder: (_, AsyncSnapshot<Future<ResponseList>> snapshot) {
				if (snapshot.hasData)
					return FutureBuilder(
						future: snapshot.data,
						builder: (_, AsyncSnapshot<ResponseList> snapshot) {
							if (snapshot.connectionState == ConnectionState.done)
								return _moreButton(snapshot.data);
							return Container(child: Center(child: CircularProgressIndicator()), height: 40.0);
						}
					);
				return Container(width: 0.0, height: 0.0);
			}
		);
	}

	Widget _moreButton(ResponseList rl) {
		if (rl.next == null || notify == null)
			return Container(width: 0.0, height: 0.0);
		return FlatButton(
			child: Text('Więcej'),
			onPressed: () {
				Function.apply(notify, [], {#uri: rl.next});
			}
		);
	}
}
