import 'user.dart';
import 'vehicle.dart';

class Scooter extends Vehicle {
  final int velocitatMaxima;

  Scooter({
    required super.id,
    required super.batteryPercentage,
    required super.preuPerMinut,
    this.velocitatMaxima = 25,
    super.enUs,
  }) {
    if (velocitatMaxima <= 0) throw ArgumentError('Velocidad no válida.');
  }

  @override
  double calcularCostReserva(int minuts, {User? usuari}) {
    validarMinuts(minuts);
    final cost = minuts * preuPerMinut;
    return usuari?.esVIP == true ? cost * 0.90 : cost;
  }
}
