import '../domain/models/child_story.dart';
import '../domain/models/colecta_group.dart';
import '../domain/models/contribution.dart';
import '../domain/models/foundation_post.dart';
import '../domain/models/chat_message.dart';

class MockData {
  static List<ChildStory> get initialChildren => [
        ChildStory(
          id: 'child-1',
          nombre: 'Mateo Quispe',
          edad: 7,
          ciudadComunidad: 'Comunidad Los Sauces',
          historia:
              'Mateo camina cada día con una sonrisa gigante para ir a la escuela. Le apasiona aprender sobre la naturaleza y sueña con su primera bicicleta con rueditas de apoyo para recorrer el camino de tierra con sus amigos.',
          deseoRegalo: 'Bicicleta rodado 16 con casco y timbre de campana',
          categoria: GiftCategory.deportes,
          metaMonto: 95.0,
          montoRecaudado: 75.0,
          estado: GiftStatus.buscandoPadrinos,
          emoji: '🚲',
          fotoAvatarUrl: 'https://images.unsplash.com/photo-1543332164-6e82f355badc?auto=format&fit=crop&w=400&q=80',
          tags: ['Deportes', 'Bici', '7 años', 'Urgente'],
        ),
        ChildStory(
          id: 'child-2',
          nombre: 'Sofía Camacho',
          edad: 5,
          ciudadComunidad: 'Hogar Arcoíris de Luz',
          historia:
              'Sofía es una pequeña artista. Pasa horas dibujando mariposas y arcoíris con pedacitos de tiza. Su sueño navideño es tener su propio estuche de acuarelas profesionales y una muñeca que pueda peinar.',
          deseoRegalo: 'Set grande de arte/pintura y muñeca interactiva con accesorios',
          categoria: GiftCategory.educacionArte,
          metaMonto: 45.0,
          montoRecaudado: 45.0,
          estado: GiftStatus.comprando,
          emoji: '🎨',
          fotoAvatarUrl: 'https://images.unsplash.com/photo-1517456793572-1d8efd6dc135?auto=format&fit=crop&w=400&q=80',
          tags: ['Arte', 'Pintura', 'Muñeca', 'Meta Lista'],
        ),
        ChildStory(
          id: 'child-3',
          nombre: 'Lucas Herrera',
          edad: 9,
          ciudadComunidad: 'Barrio Esperanza Alta',
          historia:
              'Lucas es el arquero estrella de su escuela barrial. Siempre juega con zapatitos gastados y una pelota improvisada. Desea un balón oficial de fútbol y zapatillas deportivas con luces.',
          deseoRegalo: 'Balón de fútbol oficial, guantes de arquero y zapatillas deportivas talla 33',
          categoria: GiftCategory.deportes,
          metaMonto: 60.0,
          montoRecaudado: 35.0,
          estado: GiftStatus.buscandoPadrinos,
          emoji: '⚽',
          fotoAvatarUrl: 'https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?auto=format&fit=crop&w=400&q=80',
          tags: ['Fútbol', 'Deportes', 'Zapatillas', '9 años'],
        ),
        ChildStory(
          id: 'child-4',
          nombre: 'Valentina Rojas',
          edad: 6,
          ciudadComunidad: 'Comunidad San Isidro',
          historia:
              'Valentina adora los cuentos de dinosaurios y las estrellas. Está aprendiendo a leer y sueña con una mochila con luces, libros ilustrados con cuentos mágicos y un abrigo abrigador para el frío.',
          deseoRegalo: 'Mochila escolar de dinosaurios, colección de cuentos y campera térmica',
          categoria: GiftCategory.ropaCalzado,
          metaMonto: 50.0,
          montoRecaudado: 50.0,
          estado: GiftStatus.empaquetado,
          emoji: '📚',
          fotoAvatarUrl: 'https://images.unsplash.com/photo-1516627145497-ae6968895b74?auto=format&fit=crop&w=400&q=80',
          tags: ['Lectura', 'Ropa', 'Mochila', 'Empaquetado'],
        ),
        ChildStory(
          id: 'child-5',
          nombre: 'Thiago & Diego (Hermanitos)',
          edad: 4,
          ciudadComunidad: 'Comunidad El Valle',
          historia:
              'Estos dos hermanitos mellizos comparten todo. Su sueño conjunto es un camión de bomberos a escala con pista de carreras de madera para jugar juntos en la Navidad.',
          deseoRegalo: 'Pista de autos y camión de rescate de madera didáctico',
          categoria: GiftCategory.juguetes,
          metaMonto: 70.0,
          montoRecaudado: 25.0,
          estado: GiftStatus.buscandoPadrinos,
          emoji: '🚒',
          fotoAvatarUrl: 'https://images.unsplash.com/photo-1485546246426-74dc88dec4d9?auto=format&fit=crop&w=400&q=80',
          tags: ['Hermanitos', 'Juguetes', 'Madera', 'Didáctico'],
        ),
      ];

  static List<ColectaGroup> get initialGroups => [
        ColectaGroup(
          id: 'group-1',
          childId: 'child-1',
          childName: 'Mateo Quispe (7 años - Bicicleta)',
          nombreGrupo: 'Amigos de la Promo 2018 🎓',
          organizadorNombre: 'Carlos Mendoza',
          organizadorEmail: 'carlos.mendoza@email.com',
          metaGrupo: 95.0,
          montoActual: 75.0,
          fechaLimite: DateTime.now().add(const Duration(days: 8)),
          descripcion:
              'Nos juntamos los de la promo para comprarle entre todos la bicicleta a Mateo y llevársela con su casco y luces navideñas.',
          codigoInvitacion: 'PROMO18-NAVIDAD',
          amigosParticipantes: [
            'Carlos Mendoza',
            'Andrea Villarroel',
            'Rodrigo Torrez',
            'Mariana Paz',
          ],
        ),
        ColectaGroup(
          id: 'group-2',
          childId: 'child-3',
          childName: 'Lucas Herrera (9 años - Balón y Zapatillas)',
          nombreGrupo: 'Colegas Tech & Café ☕💻',
          organizadorNombre: 'Lucía Fernández',
          organizadorEmail: 'lucia.f@email.com',
          metaGrupo: 60.0,
          montoActual: 35.0,
          fechaLimite: DateTime.now().add(const Duration(days: 12)),
          descripcion:
              'Colecta entre los compañeros del equipo de sistemas. Ya pusimos la mitad para el kit de fútbol de Lucas. ¡Súmate con cualquier monto!',
          codigoInvitacion: 'TECH-LUCAS-2026',
          amigosParticipantes: [
            'Lucía Fernández',
            'Marcos Siles',
            'Javier Flores',
          ],
        ),
      ];

  static List<Contribution> get initialContributions => [
        Contribution(
          id: 'contrib-1',
          colectaId: 'group-1',
          childId: 'child-1',
          donorName: 'Carlos Mendoza',
          amount: 25.0,
          mensajeNavideno: '¡Para que Mateo ruede por todos lados esta Navidad! Un abrazo gigante.',
          date: DateTime.now().subtract(const Duration(days: 2)),
          metodo: PaymentMethod.qrTransferencia,
        ),
        Contribution(
          id: 'contrib-2',
          colectaId: 'group-1',
          childId: 'child-1',
          donorName: 'Andrea Villarroel',
          amount: 30.0,
          mensajeNavideno: 'Con mucho cariño Mateo, ¡nunca dejes de soñar y pedalear fuerte!',
          date: DateTime.now().subtract(const Duration(days: 1)),
          metodo: PaymentMethod.qrTransferencia,
        ),
        Contribution(
          id: 'contrib-3',
          colectaId: 'group-1',
          childId: 'child-1',
          donorName: 'Rodrigo Torrez',
          amount: 20.0,
          mensajeNavideno: '¡Sumando para el casco y las luces de seguridad!',
          date: DateTime.now().subtract(const Duration(hours: 4)),
          metodo: PaymentMethod.qrTransferencia,
        ),
        Contribution(
          id: 'contrib-4',
          colectaId: 'group-2',
          childId: 'child-3',
          donorName: 'Lucía Fernández',
          amount: 20.0,
          mensajeNavideno: '¡Ese gol de media cancha te espera Lucas! Mucha fuerza campeón.',
          date: DateTime.now().subtract(const Duration(days: 1)),
          metodo: PaymentMethod.tarjeta,
        ),
        Contribution(
          id: 'contrib-5',
          colectaId: 'group-2',
          childId: 'child-3',
          donorName: 'Marcos Siles',
          amount: 15.0,
          mensajeNavideno: 'Apoyando al próximo arquero de la selección.',
          date: DateTime.now().subtract(const Duration(hours: 8)),
          metodo: PaymentMethod.qrTransferencia,
        ),
      ];

  static List<FoundationPost> get initialPosts => [
        FoundationPost(
          id: 'post-1',
          title: '🎄 ¡Llegamos a 85 niños apadrinados en esta primera semana!',
          content:
              'Querida comunidad de Fundación Moderna: Gracias a las colectas organizadas entre amigos y empresas solidarias, ya tenemos más del 70% de las cartas de Navidad cubiertas. ¡Sigamos uniendo corazones!',
          authorName: 'Dirección de Voluntariado',
          date: DateTime.now().subtract(const Duration(hours: 5)),
          category: PostCategory.hito,
          likesCount: 142,
          badgeText: 'Hito 70%',
          iconName: 'celebration',
        ),
        FoundationPost(
          id: 'post-2',
          title: '📦 Punto Central de Acopio y Empaque Navideño',
          content:
              'Si tu grupo de amigos ya compró el regalo físico, pueden traerlo a la sede de la Fundación (Av. Las Palmeras #450) de 09:00 a 19:00 hrs. Tendremos papel de regalo, moños y tarjetas navideñas disponibles para que personalicen su paquete.',
          authorName: 'Equipo de Logística',
          date: DateTime.now().subtract(const Duration(days: 1)),
          category: PostCategory.logisticaEntrega,
          likesCount: 98,
          badgeText: 'Puntos de Recepción',
          iconName: 'inventory_2',
        ),
        FoundationPost(
          id: 'post-3',
          title: '✨ Invitación al Taller de Envoltura y Cartas con Amor',
          content:
              'Este sábado tendremos una tarde comunitaria con música navideña, chocolate caliente y galletas para empacar los regalos recaudados. ¡Trae a tus amigos y padrinos!',
          authorName: 'Fundación Moderna',
          date: DateTime.now().subtract(const Duration(days: 2)),
          category: PostCategory.noticia,
          likesCount: 187,
          badgeText: 'Evento Especial',
          iconName: 'event',
        ),
      ];

  static List<ChatMessage> get initialChatMessages => [
        ChatMessage(
          id: 'chat-1',
          colectaId: 'group-1',
          senderName: 'Carlos Mendoza',
          text: '¡Hola amigos! Creé este grupo para que le compremos la bici a Mateo.',
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          isOrganizer: true,
        ),
        ChatMessage(
          id: 'chat-2',
          colectaId: 'group-1',
          senderName: 'Andrea Villarroel',
          text: '¡Me encanta! Ya transferí \$30 por QR. ¿Quién va a ir a buscarla?',
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        ),
        ChatMessage(
          id: 'chat-3',
          colectaId: 'group-1',
          senderName: 'Carlos Mendoza',
          text: 'Yo puedo ir este viernes después del trabajo a la bicicletería.',
          timestamp: DateTime.now().subtract(const Duration(hours: 18)),
          isOrganizer: true,
        ),
        ChatMessage(
          id: 'chat-4',
          colectaId: 'group-1',
          senderName: 'Rodrigo Torrez',
          text: 'Listo, aporté \$20. Solo nos faltan \$20 más para completar los \$95 🎉',
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        ),
      ];
}
