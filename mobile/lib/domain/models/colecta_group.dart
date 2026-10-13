import 'localidad_campana.dart';

class ColectaGroup {
  final String id;
  final String localidadId;
  final String localidadNombre;
  final PilarNavideno pilar;
  final String nombreGrupo;
  final String organizadorNombre;
  final String organizadorEmail;
  final double metaGrupo;
  final double montoActual;
  final DateTime fechaLimite;
  final String descripcion;
  final String codigoInvitacion;
  final List<String> amigosParticipantes;

  const ColectaGroup({
    required this.id,
    required this.localidadId,
    required this.localidadNombre,
    this.pilar = PilarNavideno.integral,
    required this.nombreGrupo,
    required this.organizadorNombre,
    required this.organizadorEmail,
    required this.metaGrupo,
    required this.montoActual,
    required this.fechaLimite,
    required this.descripcion,
    required this.codigoInvitacion,
    this.amigosParticipantes = const [],
  });

  // Getters de conveniencia
  String get childId => localidadId;
  String get childName => localidadNombre;

  double get porcentajeAvance {
    if (metaGrupo <= 0) return 0;
    final p = montoActual / metaGrupo;
    return p > 1.0 ? 1.0 : p;
  }

  double get restante =>
      (metaGrupo - montoActual) > 0 ? metaGrupo - montoActual : 0.0;

  bool get estaCompletada => montoActual >= metaGrupo;

  int get diasRestantes {
    final diff = fechaLimite.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }

  String get pilarTexto {
    switch (pilar) {
      case PilarNavideno.chocolatada:
        return '☕ Chocolatada & Panetón';
      case PilarNavideno.juegosShow:
        return '🎪 Juegos & Show';
      case PilarNavideno.juguetes:
        return '🎁 Lote de Juguetes';
      case PilarNavideno.integral:
        return '🎄 Fiesta Navideña Completa';
    }
  }

  ColectaGroup copyWith({
    double? montoActual,
    List<String>? amigosParticipantes,
  }) {
    return ColectaGroup(
      id: id,
      localidadId: localidadId,
      localidadNombre: localidadNombre,
      pilar: pilar,
      nombreGrupo: nombreGrupo,
      organizadorNombre: organizadorNombre,
      organizadorEmail: organizadorEmail,
      metaGrupo: metaGrupo,
      montoActual: montoActual ?? this.montoActual,
      fechaLimite: fechaLimite,
      descripcion: descripcion,
      codigoInvitacion: codigoInvitacion,
      amigosParticipantes: amigosParticipantes ?? this.amigosParticipantes,
    );
  }
}
