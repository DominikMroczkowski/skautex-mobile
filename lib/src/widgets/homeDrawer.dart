import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
	Widget build(context) {
		return Drawer(
			child: ListView(
      				padding: EdgeInsets.all(0.0),
          			children: <Widget> [
					_header(),
					_tools(context)
          			],
        		),
		);
	}

	Widget _header() {
		return Container(child: DrawerHeader(
              		child: Row(children: [
				Container(
					height: 70.0,
					width: 70.0,
                    			decoration: new BoxDecoration(
                        			shape: BoxShape.circle,
                        			image: new DecorationImage(
                            				fit: BoxFit.cover,
							image: NetworkImage('https://images2.minutemediacdn.com/image/upload/c_crop,h_1414,w_2101,x_20,y_0/v1565279671/shape/mentalfloss/578211-gettyimages-542930526.jpg?itok=Le7nMAZH')
                    					)
						)
				),
				Container(
					width: 10
				),
				_names()
			]
			),

              		decoration: BoxDecoration(
                		color: Colors.white,
              		),
            		),
                    	height: 120.0,);
	}

	Widget _names() {
		return Expanded(
				child: Container( child: Column(
					children: [

			Align(
				alignment: Alignment.centerLeft,
				child: FittedBox(
    fit: BoxFit.scaleDown, child: Text(
							'Jan Kowalski',
							overflow: TextOverflow.ellipsis,
							maxLines: 1,
							style: TextStyle( fontSize: 20)
						)
			)),

			Align(
				alignment: Alignment.centerLeft,
				child: Text(
							'Dyrektor',
							style: TextStyle( fontSize: 15)
						))
					]
				))
			);
	}

	Widget _tools(BuildContext c) {
		return Column(
			children: [
				_element('Strona główna', Icons.home, '/home', c),
				_element('Zawodnicy', Icons.person_pin, '/player', c),
				_element('Rekomendacje', Icons.favorite, '/players', c),
				_element('Kalendarz', Icons.event, '/players', c),
				_element('Zadania', Icons.check, '/players', c),
				_element('Wydatki', Icons.poll, '/players', c),
				_element('Rezerwacje', Icons.save, '/players', c),
				Divider(),
				_dynamicContent(),
				Divider(),
				_element('Użytkownicy', Icons.person_outline, '/home', c),
				_element('Opcje', Icons.tune, '/players', c),

			]
		);
	}

	Widget _dynamicContent() {
		return Container();
	}

	Widget _element(String text, IconData icon, String path, BuildContext c) {
		return ListTile(
       			title: Text(text, style: TextStyle(color: Colors.grey[700])),
			leading: Icon(
      				icon,
      				color: Colors.grey[700],
    			),
			dense: true,
        	      	onTap: () {
				Navigator.of(c).pushNamed(path);
        	      	},
        	);
	}
}
