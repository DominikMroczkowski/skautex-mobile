class InvitationTemplate {
	String uri;
	String name;
	String templateFile;

	InvitationTemplate({this.uri, this.name, this.templateFile});

	InvitationTemplate.fromJson(Map<String, dynamic> parsedJson):
		uri = parsedJson['url'],
		name = parsedJson['name'],
		templateFile = parsedJson['template'];

	toString() => name;

	toPost() {
		return {
			'name': name
		};
	}
}
