class PespModel {
  final String nombre;
  final String descripcion;

  PespModel({
    required this.nombre,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() {
    return {
      "nombre": nombre,
      "descripcion": descripcion,
    };
  }

  factory PespModel.fromJson(Map<String, dynamic> json) {
    return PespModel(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
    );
  }
}