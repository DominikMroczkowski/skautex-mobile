import 'package:skautex_mobile/src/models/file.dart';
import 'package:skautex_mobile/src/models/invitation_template.dart';
import 'package:skautex_mobile/src/models/user.dart';
import 'package:skautex_mobile/src/models/player.dart';

class Invitation {
	String uri;
	User trainer;
	User owner;
	InvitationTemplate template;
	Player player;
	String startDate;
	String endDate;
	String creationDate;
	File invitation;

	Invitation({this.uri, this.trainer, this.owner, this.template, this.player, this.startDate, this.endDate, this.invitation});

	Invitation.fromJson(Map<String, dynamic> parsedJson):
		uri = parsedJson['url'],
		startDate = parsedJson['start_date'],
		endDate = parsedJson['end_date'],
		creationDate = parsedJson['creation_date'],
		trainer = User.fromJson(parsedJson['trainer']),
		owner = User.fromJson(parsedJson['owner']),
		player = Player.fromJson(parsedJson['player']),
		template = InvitationTemplate.fromJson(parsedJson['invitation_template']),
		invitation = File(uri: parsedJson['invitation_file']);

	Map<String, dynamic> toJson() {
		var map = <String, dynamic> {
			'url': uri,
			'start_date': startDate,
			'end_date': endDate,
			'owner': owner?.uri,
			'player': player?.uri,
			'trainer': trainer?.uri,
			'invitation_template': template?.uri
		};

		return map;
	}

	Map<String, dynamic> toPost() {
		var map = toJson();
		map.remove('url');
		map.remove('owner');
		return map;
	}
}
