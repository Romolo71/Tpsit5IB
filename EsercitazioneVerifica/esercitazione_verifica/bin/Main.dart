import 'dart:io';

import 'Biglietto.dart';
import 'Cinema.dart';
import 'Proiection.dart';

Future<void> main(List<String> arguments) async {
  final cinema = Cinema.lumiere();
  final bigliettiAcquistati = <Biglietto>[];
  var continua = true;

  while (continua) {
    print('\n=== CINEMA LUMIÈRE ===');
    print('1. Vedere la programmazione');
    print('2. Vedere i dettagli di un film');
    print('3. Vedere i posti liberi di una proiezione');
    print('4. Acquistare un biglietto');
    print('5. Posti liberi per tutte le proiezioni');
    print('0. Esci');
    stdout.write('Scelta: ');

    final scelta = int.tryParse(stdin.readLineSync() ?? '');
    if (scelta == null) {
      print('Inserisci un numero valido.');
      continue;
    }

    try {
      switch (scelta) {
        case 1:
          final proiezioni = await _caricaProgrammazione(cinema);
          _stampaProiezioni(proiezioni);
          break;
        case 2:
          stdout.write('Titolo del film: ');
          final titolo = stdin.readLineSync()?.trim() ?? '';
          final film = await cinema.getFilm(titolo);
          print('\n$film');
          break;
        case 3:
          final proiezione = await _scegliProiezione(cinema);
          final posti = await cinema.getPostiLiberi(proiezione);
          print('Posti liberi: ${posti.isEmpty ? "nessuno" : posti.join(", ")}');
          break;
        case 4:
          final proiezione = await _scegliProiezione(cinema);
          final postiLiberi = await cinema.getPostiLiberi(proiezione);
          print('Posti liberi: ${postiLiberi.isEmpty ? "nessuno" : postiLiberi.join(", ")}');
          if (postiLiberi.isEmpty) break;

          stdout.write('Posto da acquistare (es. A3): ');
          final posto = (stdin.readLineSync() ?? '').trim().toUpperCase();
          stdout.write('Hai diritto al ridotto? (s/n): ');
          final ridotto = _rispostaSi(stdin.readLineSync());
          stdout.write('Vuoi un biglietto VIP? (s/n): ');
          final vip = _rispostaSi(stdin.readLineSync());

          print('Acquisto in corso...');
          final biglietto = await cinema.acquistaBiglietto(
            proiezione: proiezione,
            posto: posto,
            ridotto: ridotto,
            vip: vip,
          );
          bigliettiAcquistati.add(biglietto);
          print('Biglietto acquistato: $biglietto');
          break;
        case 5:
          print('Caricamento posti liberi...');
          final tuttiIPosti = await cinema.getPostiLiberiTutte();
          for (var i = 0; i < tuttiIPosti.length; i++) {
            print('${i + 1}. ${cinema.proiezioni[i]}: ${tuttiIPosti[i].length} posti liberi');
          }
          break;
        case 0:
          continua = false;
          break;
        default:
          print('Scelta non valida.');
          break;
      }
    } catch (errore) {
      print('Operazione non riuscita: ${_messaggioErrore(errore)}');
    }
  }

  print('\n=== RIEPILOGO ACQUISTI ===');
  if (bigliettiAcquistati.isEmpty) {
    print('Non hai acquistato biglietti.');
  } else {
    var totale = 0.0;
    for (final biglietto in bigliettiAcquistati) {
      print(biglietto);
      totale += biglietto.prezzo;
    }
    print('Totale speso: €${totale.toStringAsFixed(2)}');
  }
}

Future<List<Proiection>> _caricaProgrammazione(Cinema cinema) async {
  print('Caricamento programmazione...');
  return cinema.getProgrammazione();
}

Future<Proiection> _scegliProiezione(Cinema cinema) async {
  final proiezioni = await _caricaProgrammazione(cinema);
  _stampaProiezioni(proiezioni);
  stdout.write('Numero della proiezione: ');
  final numero = int.tryParse(stdin.readLineSync() ?? '');
  if (numero == null || numero < 1 || numero > proiezioni.length) {
    throw Exception('Numero di proiezione fuori dall’elenco.');
  }
  return proiezioni[numero - 1];
}

void _stampaProiezioni(List<Proiection> proiezioni) {
  print('\n--- PROGRAMMAZIONE DI OGGI ---');
  for (var i = 0; i < proiezioni.length; i++) {
    final proiezione = proiezioni[i];
    final valutazione = proiezione.film.valutazione?.toString() ?? 'nessuna recensione';
    print('${i + 1}. $proiezione | ${proiezione.film.durata} min | valutazione: $valutazione');
  }
}

bool _rispostaSi(String? risposta) =>
    risposta?.trim().toLowerCase() == 's' || risposta?.trim().toLowerCase() == 'si';

String _messaggioErrore(Object errore) =>
    errore is Exception ? errore.toString().replaceFirst('Exception: ', '') : errore.toString();
