import '../domain/models/localidad_campana.dart';
import '../domain/models/colecta_group.dart';
import '../domain/models/contribution.dart';
import '../domain/models/foundation_post.dart';
import '../domain/models/chat_message.dart';

class MockData {
  static List<LocalidadCampana> get initialLocalidades => [
        LocalidadCampana(
          id: 'loc-1',
          nombre: 'Comunidad San Antonio de Lomerío',
          departamentoZona: 'Zona Rural Valles',
          descripcionComunidad:
              'Comunidad alejada donde las familias se dedican a la agricultura. Nuestra caravana navideña llevará alegría a los niños de la escuela comunitaria y caseríos cercanos con una gran chocolatada caliente, payasos y entrega de juguetes.',
          cantidadNinosEstimados: 140,
          fechaCaravana: DateTime.now().add(const Duration(days: 8)),
          estado: EstadoCaravana.enRecaudacion,
          emoji: '🏔️',
          puntoEncuentroSalida: 'Sede Fundación Moderna (06:00 AM)',
          necesidadesPuntuales: [
            '280 tazas de chocolatada caliente con canela',
            '140 porciones de panetón navideño tradicional',
            'Show de animación con duendes, música y piñatas',
            '140 juguetes clasificados por edades (0-12 años)',
          ],
          metaChocolatada: 220.0,
          recaudadoChocolatada: 190.0,
          metaJuegos: 150.0,
          recaudadoJuegos: 150.0,
          metaJuguetes: 700.0,
          recaudadoJuguetes: 520.0,
        ),
        LocalidadCampana(
          id: 'loc-2',
          nombre: 'Barrio Esperanza Alta',
          departamentoZona: 'Distrito Periurbano 12',
          descripcionComunidad:
              'Zona periférica vulnerable donde los niños no suelen recibir festejos en Navidad. Organizaremos una tarde recreativa en la cancha del barrio con juegos tradicionales, chocolatada con galletas y juguetes para todos.',
          cantidadNinosEstimados: 95,
          fechaCaravana: DateTime.now().add(const Duration(days: 10)),
          estado: EstadoCaravana.empaquetandoInsumos,
          emoji: '🏘️',
          puntoEncuentroSalida: 'Plaza del Maestro (08:30 AM)',
          necesidadesPuntuales: [
            '190 tazas de chocolatada y galletas surtidas',
            '95 raciones de panetón con chispas de chocolate',
            'Juegos inflables y dinámicas con monitores juveniles',
            '95 juguetes (pelotas, muñecas, autitos y juegos de mesa)',
          ],
          metaChocolatada: 160.0,
          recaudadoChocolatada: 160.0,
          metaJuegos: 120.0,
          recaudadoJuegos: 95.0,
          metaJuguetes: 480.0,
          recaudadoJuguetes: 410.0,
        ),
        LocalidadCampana(
          id: 'loc-3',
          nombre: 'Hogar Comunitario Rayito de Sol',
          departamentoZona: 'Sector Norte',
          descripcionComunidad:
              'Hogar y centro de apoyo escolar diurno que atiende a niños cuyos padres trabajan en reciclaje y comercio informal. ¡Meta alcanzada gracias al aporte de amigos y voluntarios!',
          cantidadNinosEstimados: 65,
          fechaCaravana: DateTime.now().add(const Duration(days: 11)),
          estado: EstadoCaravana.metaAlcanzada,
          emoji: '☀️',
          puntoEncuentroSalida: 'Sede Fundación Moderna (14:00 PM)',
          necesidadesPuntuales: [
            'Chocolatada caliente con leche entera y canela',
            'Panetones familiares para compartir en mesa redonda',
            'Taller de títeres y villancicos en vivo',
            '65 juguetes educativos y kits de arte',
          ],
          metaChocolatada: 110.0,
          recaudadoChocolatada: 110.0,
          metaJuegos: 90.0,
          recaudadoJuegos: 90.0,
          metaJuguetes: 350.0,
          recaudadoJuguetes: 350.0,
        ),
        LocalidadCampana(
          id: 'loc-4',
          nombre: 'Comunidad Indígena El Palmar',
          departamentoZona: 'Cuenca del Río - Tierras Bajas',
          descripcionComunidad:
              'Poblado de difícil acceso. La Caravana viajará en camionetas 4x4 llevando 180 juguetes clasificados, calderos grandes para chocolate caliente y voluntarios animadores para festejar con toda la comunidad.',
          cantidadNinosEstimados: 180,
          fechaCaravana: DateTime.now().add(const Duration(days: 12)),
          estado: EstadoCaravana.enRecaudacion,
          emoji: '🌴',
          puntoEncuentroSalida: 'Terminal Interprovincial (04:30 AM)',
          necesidadesPuntuales: [
            '360 vasos de chocolatada con canela y clavo',
            '180 panetones personales sellados',
            'Show de payasos, magia y concursos con premios',
            '180 juguetes resistentes para niños y niñas',
          ],
          metaChocolatada: 290.0,
          recaudadoChocolatada: 160.0,
          metaJuegos: 200.0,
          recaudadoJuegos: 130.0,
          metaJuguetes: 900.0,
          recaudadoJuguetes: 560.0,
        ),
      ];

  static List<ColectaGroup> get initialGroups => [
        ColectaGroup(
          id: 'group-1',
          localidadId: 'loc-1',
          localidadNombre: 'Comunidad San Antonio de Lomerío',
          pilar: PilarNavideno.chocolatada,
          nombreGrupo: 'Amigos por la Chocolatada de San Antonio ☕',
          organizadorNombre: 'Carlos Mendoza',
          organizadorEmail: 'carlos.mendoza@amigos.org',
          metaGrupo: 220.0,
          montoActual: 190.0,
          fechaLimite: DateTime.now().add(const Duration(days: 6)),
          descripcion:
              'Nos unimos entre amigos del colegio y trabajo para financiar el 100% de la chocolatada y panetones para los 140 niños de San Antonio.',
          codigoInvitacion: 'CHOCO-LOMERIO-2026',
          amigosParticipantes: [
            'Carlos Mendoza',
            'Andrea Villarroel',
            'Rodrigo Torrez',
            'Patricia Luna',
            'Javier Suárez',
          ],
        ),
        ColectaGroup(
          id: 'group-2',
          localidadId: 'loc-2',
          localidadNombre: 'Barrio Esperanza Alta',
          pilar: PilarNavideno.juguetes,
          nombreGrupo: 'Lote de Juguetes Esperanza Alta 🎁',
          organizadorNombre: 'Mariana Céspedes',
          organizadorEmail: 'mariana.c@empresa.com',
          metaGrupo: 480.0,
          montoActual: 410.0,
          fechaLimite: DateTime.now().add(const Duration(days: 7)),
          descripcion:
              'Colegas de oficina colaborando para comprar el lote de 95 juguetes por mayor para que ningún niño de Esperanza Alta se quede sin regalo.',
          codigoInvitacion: 'JUGUETES-ESPERANZA-95',
          amigosParticipantes: [
            'Mariana Céspedes',
            'Gabriel Ríos',
            'Claudia Dávila',
            'Sergio Banegas',
          ],
        ),
        ColectaGroup(
          id: 'group-3',
          localidadId: 'loc-1',
          localidadNombre: 'Comunidad San Antonio de Lomerío',
          pilar: PilarNavideno.juegosShow,
          nombreGrupo: 'Show Navideño y Juegos San Antonio 🎪',
          organizadorNombre: 'Daniela Morales',
          organizadorEmail: 'daniela.m@voluntarios.org',
          metaGrupo: 150.0,
          montoActual: 150.0,
          fechaLimite: DateTime.now().add(const Duration(days: 5)),
          descripcion:
              'Cubrimos el show de títeres, payasos, sonido portátil y piñatas para divertir a todos los niños de la comunidad.',
          codigoInvitacion: 'SHOW-LOMERIO-OK',
          amigosParticipantes: [
            'Daniela Morales',
            'Esteban Pinto',
            'Lucía Vargas',
          ],
        ),
      ];

  static List<Contribution> get initialContributions => [
        Contribution(
          id: 'contrib-1',
          colectaId: 'group-1',
          localidadId: 'loc-1',
          donorName: 'Andrea Villarroel',
          amount: 30.0,
          mensajeNavideno: '¡Que no falte chocolate caliente ni sonrisas!',
          date: DateTime.now().subtract(const Duration(days: 1)),
          metodo: PaymentMethod.qrTransferencia,
        ),
        Contribution(
          id: 'contrib-2',
          colectaId: 'group-1',
          localidadId: 'loc-1',
          donorName: 'Rodrigo Torrez',
          amount: 25.0,
          mensajeNavideno: 'Con mucho amor para la chocolatada de los chicos.',
          date: DateTime.now().subtract(const Duration(hours: 14)),
          metodo: PaymentMethod.qrTransferencia,
        ),
        Contribution(
          id: 'contrib-3',
          colectaId: 'group-2',
          localidadId: 'loc-2',
          donorName: 'Gabriel Ríos',
          amount: 50.0,
          mensajeNavideno: 'Sumando para que alcancen los juguetes para todos.',
          date: DateTime.now().subtract(const Duration(hours: 6)),
          metodo: PaymentMethod.tarjeta,
        ),
      ];

  static List<FoundationPost> get initialPosts => [
        FoundationPost(
          id: 'post-1',
          title: '🎄 ¡Ya superamos el 75% de la meta en Chocolatada y Juguetes!',
          content:
              'Querida comunidad solidaria: Gracias a las colectas entre amigos para San Antonio de Lomerío y Esperanza Alta, ya tenemos asegurado el chocolate caliente y más de 300 juguetes empacados. ¡Sigamos uniendo fuerzas!',
          authorName: 'Equipo de Voluntariado',
          date: DateTime.now().subtract(const Duration(hours: 5)),
          category: PostCategory.hito,
          likesCount: 156,
          badgeText: 'Hito 75%',
          iconName: 'celebration',
        ),
        FoundationPost(
          id: 'post-2',
          title: '☕ Punto Central de Acopio de Panetones y Chocolate',
          content:
              'Si tu grupo de amigos o empresa recolectó panetones, cajas de leche o juguetes físicos, pueden traerlos a la sede de la Fundación (Av. Las Palmeras #450) de 09:00 a 19:00 hrs. ¡Tenemos voluntarios clasificando donaciones!',
          authorName: 'Equipo de Logística',
          date: DateTime.now().subtract(const Duration(days: 1)),
          category: PostCategory.logisticaEntrega,
          likesCount: 112,
          badgeText: 'Puntos de Recepción',
          iconName: 'inventory_2',
        ),
        FoundationPost(
          id: 'post-3',
          title: '🎪 Convocatoria a Voluntarios Animadores para los Juegos',
          content:
              'Buscamos voluntarios con espíritu navideño que deseen acompañar a la Caravana para coordinar las dinámicas, juegos infantiles y entrega de chocolate. ¡Inscríbete en la sede o por el canal oficial!',
          authorName: 'Fundación Moderna',
          date: DateTime.now().subtract(const Duration(days: 2)),
          category: PostCategory.noticia,
          likesCount: 204,
          badgeText: 'Caravana Navideña',
          iconName: 'event',
        ),
      ];

  static List<ChatMessage> get initialChatMessages => [
        ChatMessage(
          id: 'chat-1',
          colectaId: 'group-1',
          senderName: 'Carlos Mendoza',
          text:
              '¡Hola a todos! Armé este grupo para que cubramos entre nosotros toda la chocolatada de San Antonio.',
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          isOrganizer: true,
        ),
        ChatMessage(
          id: 'chat-2',
          colectaId: 'group-1',
          senderName: 'Andrea Villarroel',
          text: '¡Excelente iniciativa! Ya transferí \$30 por QR. ¿Quién va a comprar las barras de chocolate?',
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        ),
        ChatMessage(
          id: 'chat-3',
          colectaId: 'group-1',
          senderName: 'Carlos Mendoza',
          text: 'Hablé con la distribuidora y nos darán precio mayorista por 280 raciones con panetón.',
          timestamp: DateTime.now().subtract(const Duration(hours: 18)),
          isOrganizer: true,
        ),
        ChatMessage(
          id: 'chat-4',
          colectaId: 'group-1',
          senderName: 'Rodrigo Torrez',
          text: 'Aporté \$25 más. ¡Ya casi completamos la meta de la chocolatada! 🎉',
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        ),
      ];
}
