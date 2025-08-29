class Drone {
  int id;
  int capacidadCargaKg;
  int autonomiaMin;

  Drone({
    required this.id,
    required this.capacidadCargaKg,
    required this.autonomiaMin,
  });

  void mostrarFicha() {
    print('La capacidad del drone es $capacidadCargaKg KG y tiene la autonomía de $autonomiaMin minutos.');
  }
}

class DroneMaritimo extends Drone {
  String resistenciaCorrosion;

  DroneMaritimo({
    required int id,
    required int capacidadCargaKg,
    required int autonomiaMin,
    required this.resistenciaCorrosion,
  }) : super(id: id, capacidadCargaKg: capacidadCargaKg, autonomiaMin: autonomiaMin);

  @override
  void mostrarFicha() {
    print('La capacidad del drone es $capacidadCargaKg KG, tiene la autonomía de $autonomiaMin minutos y la resistencia a corrosión es $resistenciaCorrosion');
  }
}

abstract class Trabajador {
  String nombre;
  int salarioMensual;

  Trabajador({
    required this.nombre,
    required this.salarioMensual,
  });

  int calcularBonificacion(int porcentajeBonificacion);
}

class AdministradorSistemas extends Trabajador {
  String carrera;

  AdministradorSistemas({
    required String nombre,
    required int salarioMensual,
    required this.carrera,
  }) : super(nombre: nombre, salarioMensual: salarioMensual);

  @override
  int calcularBonificacion(int porcentajeBonificacion) {
    int bonificacion = (salarioMensual * porcentajeBonificacion ~/ 100);
    print('$nombre, administrador de sistemas con carrera en $carrera, recibe una bonificación de $bonificacion.');
    return bonificacion;
  }
}

class TecnicoSoporte extends Trabajador {
  String especialidad;

  TecnicoSoporte({
    required String nombre,
    required int salarioMensual,
    required this.especialidad,
  }) : super(nombre: nombre, salarioMensual: salarioMensual);

  @override
  int calcularBonificacion(int porcentajeBonificacion) {
    int bonificacion = (salarioMensual * porcentajeBonificacion ~/ 100);
    print('$nombre, técnico de soporte especializado en $especialidad, recibe una bonificación de $bonificacion.');
    return bonificacion;
  }
}

void main() {
  final drone = Drone(id: 1, capacidadCargaKg: 12, autonomiaMin: 40);
  drone.mostrarFicha();

  final droneMaritimo = DroneMaritimo(
    id: 2,
    capacidadCargaKg: 11,
    autonomiaMin: 20,
    resistenciaCorrosion: 'alta',
  );
  droneMaritimo.mostrarFicha();

  final admin = AdministradorSistemas(nombre: 'Ana', salarioMensual: 2000, carrera: 'Ingeniería en Sistemas');
  admin.calcularBonificacion(18); 

  final tecnico = TecnicoSoporte(nombre: 'Luis', salarioMensual: 1500, especialidad: 'Redes');
  tecnico.calcularBonificacion(10); 
}
