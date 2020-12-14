import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

class Players extends ItemList<Player> {
	Players({context}) {
		otp = context;
		super.fetch(where: {'is_active': 'true'});
	}
}
