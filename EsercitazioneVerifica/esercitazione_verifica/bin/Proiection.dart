import 'Film.dart';
import 'Sala.dart';
class Proiection {
  List<String> selled;
  Map<Film, Sala> proiections;
  double durata;
  bool is3D;

  Proiection(this.proiections, this.durata, this.is3D, this.selled);
}