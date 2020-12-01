import 'package:skautex_mobile/src/models/event_type.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

class Types extends ItemList<EventType> {
	Types({context}) {
		otp = context;
		super.fetch();
	}
}
