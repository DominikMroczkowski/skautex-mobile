import 'package:flutter/material.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget {
	final String title;

	View({@required this.title});

	Widget build(context) {
		final bloc = Provider.of(context);

		return StreamBuilder(
			stream: bloc.editable,
			builder: (_, snapshot) {
				if (!snapshot.hasData || snapshot.data == false)
					return _titleBar(bloc);
				return _searchBar(bloc);
			},
		);
	}

	_titleBar(Bloc bloc) {
		return Row(
			children: [
				Expanded(child: _title(bloc)),
				_button(bloc.edit)
			]
		);
	}

	_title(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.title,
			builder: (_, snapshot) {
				if (snapshot.hasData)
					return Text(snapshot.data.toString());
				return Text(bloc.defaultTitle.toString());
			}
		);
	}

	Widget _searchBar(Bloc bloc) {
		return Row(
			children: [
				Expanded(child: _textField(bloc)),
				_button(bloc.search)
			]
		);
	}

	_button(Function function) {
		return FlatButton(
			onPressed: function,
			child: Icon(
				Icons.search,
				color: Colors.white
			)
		);
	}

	Widget _textField(Bloc bloc) {
		return Container(
			child: TextFormField(
				onChanged: bloc.changeInput,
				decoration: InputDecoration(
					fillColor: Colors.white,
					hintText: 'Wyszukaj',
					filled: true,
					border: OutlineInputBorder(
						borderRadius: BorderRadius.circular(5.0)
					)
				),
			),
			padding: EdgeInsets.all(3.0)
		);
	}
}
