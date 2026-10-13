class ColectaGroup {
  final String id;
  final String childId;
  final String childName;
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
    required this.childId,
    required this.childName,
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

  double get porcentajeAvance {
    if (metaGrupo <= 0) return 0;
    final p = montoActual / metaGrupo;
    return p > 1.0 ? 1.0 : p;
  }

  double get restante => (metaGrupo - montoActual) > 0 ? metaGrupo - montoActual : 0.0;

  bool get estaCompletada => montoActual >= metaGrupo;

  int get diasRestantes {
    final diff = fechaLimite.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }

  ColectaGroup copyWith({
    double? montoActual,
    List<String>? amigosParticipantes,
  }) {
    return ColectaGroup(
      id: id,
      childId: childId,
      childName: childName,
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
