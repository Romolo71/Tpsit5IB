import 'Film.dart';
import 'Sala.dart';

class Proiection {
  final Film film;
  final Sala sala;
  final String orario;
  final bool is3D;
  final List<String> postiVenduti;

  Proiection(this.film, this.sala, this.orario, this.is3D,
      [List<String>? postiGiaVenduti])
      : postiVenduti = postiGiaVenduti ?? [];

  @override
  String toString() =>
      '${film.titolo} | ${sala.toString()} | $orario | ${is3D ? "3D" : "2D"}';
}
