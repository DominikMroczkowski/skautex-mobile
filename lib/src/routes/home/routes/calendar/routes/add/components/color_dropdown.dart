import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/others/event_colors.dart';

class ColorDropdown extends StatelessWidget {
	final Function(String) change;
	final String value;

	ColorDropdown({@required this.value,  @required this.change});

	build(BuildContext context) {
		List<DropdownMenuItem<String>> items = [];

		eventColors.forEach(
			(i) =>
				items.add(
					DropdownMenuItem<String>(
						value: i,
						child: Container(height: 20.0, color: Color(HexColor(i).value))
					)
				)
		);

		return DropdownButtonFormField(
			items: items,
			onChanged: (String i) {i != null ?  change(i) : null;},
			value: value,
			isExpanded: true,
			decoration: InputDecoration(
				labelText: 'Wybierz kolor'
			)
		);
	}
}
