enum PilarNavideno {
  chocolatada,
  juegosShow,
  juguetes,
  integral,
}

enum EstadoCaravana {
  enRecaudacion,
  metaAlcanzada,
  empaquetandoInsumos,
  caravanaEnCamino,
  entregadoConExito,
}

class LocalidadCampana {
  final String id;
  final String nombre;
  final String departamentoZona;
  final String descripcionComunidad;
  final int cantidadNinosEstimados;
  final DateTime fechaCaravana;
  final EstadoCaravana estado;
  final String emoji;
  final String puntoEncuentroSalida;
  final List<String> necesidadesPuntuales;

  // Metas y recaudación de los 3 pilares comunitarios
  final double metaChocolatada;
  final double recaudadoChocolatada;

  final double metaJuegos;
  final double recaudadoJuegos;

  final double metaJuguetes;
  final double recaudadoJuguetes;

  const LocalidadCampana({
    required this.id,
    required this.nombre,
    required this.departamentoZona,
    required this.descripcionComunidad,
    required this.cantidadNinosEstimados,
    required this.fechaCaravana,
    required this.estado,
    required this.emoji,
    required this.puntoEncuentroSalida,
    this.necesidadesPuntuales = const [],
    required this.metaChocolatada,
    required this.recaudadoChocolatada,
    required this.metaJuegos,
    required this.recaudadoJuegos,
    required this.metaJuguetes,
    required this.recaudadoJuguetes,
  });

  // Cálculos totales combinados
  double get metaTotal => metaChocolatada + metaJuegos + metaJuguetes;
  double get recaudadoTotal =>
      recaudadoChocolatada + recaudadoJuegos + recaudadoJuguetes;

  double get restanteTotal =>
      (metaTotal - recaudadoTotal) > 0 ? (metaTotal - recaudadoTotal) : 0.0;

  double get porcentajeAvanceTotal {
    if (metaTotal <= 0) return 0;
    final p = recaudadoTotal / metaTotal;
    return p > 1.0 ? 1.0 : p;
  }

  // Porcentajes individuales de los 3 pilares
  double get avanceChocolatada {
    if (metaChocolatada <= 0) return 0;
    final p = recaudadoChocolatada / metaChocolatada;
    return p > 1.0 ? 1.0 : p;
  }

  double get avanceJuegos {
    if (metaJuegos <= 0) return 0;
    final p = recaudadoJuegos / metaJuegos;
    return p > 1.0 ? 1.0 : p;
  }

  double get avanceJuguetes {
    if (metaJuguetes <= 0) return 0;
    final p = recaudadoJuguetes / metaJuguetes;
    return p > 1.0 ? 1.0 : p;
  }

  bool get estaCompleta => recaudadoTotal >= metaTotal;

  String get estadoTexto {
    switch (estado) {
      case EstadoCaravana.enRecaudacion:
        return 'En recaudación comunitaria';
      case EstadoCaravana.metaAlcanzada:
        return '¡Meta alcanzada!';
      case EstadoCaravana.empaquetandoInsumos:
        return 'Empacando juguetes y chocolate';
      case EstadoCaravana.caravanaEnCamino:
        return 'Caravana en camino 🚚';
      case EstadoCaravana.entregadoConExito:
        return '¡Navidad celebrada con éxito! 🎉';
    }
  }

  int get diasParaCaravana {
    final diff = fechaCaravana.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }
}
