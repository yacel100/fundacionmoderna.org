# 🎁 Fundación Moderna - Misión Navidad

Aplicación móvil desarrollada en **Flutter** para coordinar y transparentar las campañas navideñas de recolección de regalos infantiles mediante colectas organizadas entre amigos, familiares y empresas solidarias.

---

## 📱 Estructura del Repositorio

```text
fundacionmoderna.org/
└── mobile/                      # Aplicación móvil Flutter (Android / iOS / Web)
    ├── lib/
    │   ├── domain/              # Modelos de dominio
    │   │   ├── child_story.dart      # Historias, deseos y metas de cada niño
    │   │   ├── colecta_group.dart    # Grupos de recaudación entre amigos
    │   │   ├── contribution.dart     # Aportes registrados y métodos de pago
    │   │   ├── chat_message.dart     # Mensajes de coordinación del grupo
    │   │   └── foundation_post.dart  # Comunicados oficiales y centros de acopio
    │   ├── data/                # Capa de datos y repositorio
    │   │   ├── colectas_repository.dart
    │   │   └── mock_data.dart        # Datos iniciales realistas de simulación
    │   ├── ui/
    │   │   ├── core/            # Sistema de diseño navideño y temas
    │   │   │   ├── app_theme.dart
    │   │   │   └── widgets/     # Insignias festivas y barras de progreso
    │   │   ├── view_models/     # MVVM con ChangeNotifier
    │   │   │   └── foundation_view_model.dart
    │   │   └── screens/         # Pantallas principales
    │   │       ├── home_campaigns_screen.dart   # Explorador de cartas de niños y filtros
    │   │       ├── child_detail_screen.dart     # Ficha del niño y botón para crear colecta
    │   │       ├── mis_colectas_screen.dart     # Directorio de colectas activas
    │   │       ├── colecta_detail_screen.dart   # Chat en vivo y lista de aportes
    │   │       ├── nueva_colecta_dialog.dart    # Modal para iniciar colecta entre amigos
    │   │       ├── registrar_aporte_dialog.dart # Modal para aportar (QR, tarjeta, efectivo)
    │   │       ├── comunicados_screen.dart      # Canal oficial de noticias y puntos de acopio
    │   │       └── mi_impacto_screen.dart       # Certificado digital de honor y estadísticas
    │   └── main.dart            # Entrada principal con navegación por pestañas
    └── test/
        └── widget_test.dart     # Pruebas automatizadas de la interfaz
```

---

## 🚀 Cómo Ejecutar la Aplicación

1. Dirígete a la carpeta móvil:
   ```bash
   cd mobile
   ```

2. Instala las dependencias:
   ```bash
   flutter pub get
   ```

3. Ejecuta en tu dispositivo o emulador:
   ```bash
   flutter run
   ```
   *(También puedes ejecutar en Chrome con `flutter run -d chrome`)*

4. Ejecutar pruebas unitarias:
   ```bash
   flutter test
   ```
