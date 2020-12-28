List<String> positions = [
  "goalkeeper",
	"side defender",
  "central defender",
  "defensive help",
  "middle help 8",
  "middle help 10",
  "side help 10",
  "attacker"
];

String getPolishPosition(String position) {
	if (!positions.contains(position))
		return position;
	final pl = [
		'Bramkarz',
		"Pomocnik Boczny"
		'Pomocnik Środkowy',
		'Obrońca Boczny',
		'Środkowy Pomocnik 8',
		'Środkowy Pomocnik 10',
		'Boczny Pomocnik 10',
		'Napastnik'
	];
	return pl[positions.indexOf(position)];
}
