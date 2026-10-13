# 🗺️ Hoja de Ruta y Backlog de Desarrollo: Fundación Moderna - Misión Navidad

Este documento detalla la visión, la nueva lógica de negocio enfocada en comunidades y el desglose de todas las tareas y funcionalidades pendientes de realizar.

---

## 🎯 1. Cambio Fundamental de Lógica: Protección de Menores & Enfoque por Localidades

### 🛡️ Principio de Dignidad y Privacidad Infantil
Por ética, seguridad y normativa de protección de datos de menores de edad, **NO se expondrán perfiles individuales, nombres directos ni fotografías de rostros de niños vulnerables**.

### 🏘️ Nuevo Eje de Acción: Campañas por Localidades / Comunidades
Las campañas se organizan por **Localidades o Barrios Vulnerables** donde la Fundación Moderna llevará la Caravana Navideña. 

Cada localidad cuenta con una meta comunitaria integral dividida en **3 Pilares Navideños**:
1. ☕ **Chocolatada Navideña & Panetón:** Leche, chocolate en barra, canela, panetones, galletas, tazas y raciones para los niños y familias de la comunidad.
2. 🎪 **Juegos, Show Navideño & Animación:** Dinámicas grupales, payasos, personajes navideños, música, globos, concursos y piñatas para regalar un día inolvidable de diversión.
3. 🎁 **Juguetes & Regalos Colectivos:** Lotes clasificados de juguetes según grupos de edad (0-3 años, 4-7 años, 8-12 años), pelotas, muñecas, autos, juegos didácticos y kits de arte.

### 👥 Colectas entre Amigos Basadas en Comunidades
Los grupos de amigos y empresas se unen para financiar:
- La meta integral de una localidad específica (ej. *"Comunidad San Antonio: 120 niños"*).
- Un pilar específico (ej. *"Grupo Amigos: Nos encargamos de toda la chocolatada de la Localidad Los Pinos"*).

---

## 📋 2. Backlog de Tareas Pendientes por Fases

### 🔹 Fase 1: Adaptación de Modelos y UI al Modelo Comunitario (En Curso)
- [x] Crear documento maestro de Roadmap y especificación funcional (`ROADMAP.md`).
- [ ] Refactorizar modelo de datos: Crear `LocalidadCampana` en reemplazo de fichas individuales de niños.
- [ ] Incorporar los 3 pilares en cada localidad:
  - Presupuesto y avance de **Chocolatada** (ej. \$200 meta).
  - Presupuesto y avance de **Juegos & Show** (ej. \$150 meta).
  - Presupuesto y avance de **Juguetes** (ej. \$650 meta).
- [ ] Actualizar pantalla de inicio (`HomeCampaignsScreen`) con selector de localidades, desglose de los 3 pilares y contador de niños beneficiados.
- [ ] Adaptar pantalla de detalle (`LocalidadDetailScreen`) con mapa/ubicación de la comunidad, logística de la visita y botón para apadrinar o iniciar colecta grupal.
- [ ] Adaptar modal de creación de colecta (`NuevaColectaDialog`) para seleccionar la localidad y el pilar que se desea apoyar.
- [ ] Actualizar modal de aportes (`RegistrarAporteDialog`) para destinar el aporte a una localidad o pilar.

### 🔹 Fase 2: Backend, API REST y Persistencia en Nube
- [ ] Definir esquemas relacionales en PostgreSQL (compatible con Neon / Supabase):
  - Tabla `localidades` (id, nombre, departamento/provincia, cupo_ninos, meta_chocolatada, meta_juegos, meta_juguetes, recaudado_chocolatada, recaudado_juegos, recaudado_juguetes, fecha_caravana, estado).
  - Tabla `colectas` (id, localidad_id, nombre_grupo, meta, recaudado, codigo_invitacion, creador_id).
  - Tabla `aportes` (id, colecta_id, localidad_id, donante, monto, mensaje, metodo_pago, fecha).
  - Tabla `chat_mensajes` (id, colecta_id, remitente, mensaje, timestamp).
  - Tabla `comunicados` (id, titulo, contenido, categoria, fecha, likes).
- [ ] Desarrollar servicio backend con Go (Gin / GORM) o Node.js.
- [ ] Implementar capa de repositorio HTTP en Flutter (`HttpColectasRepository`) consumiendo la API REST con manejo de offline y sincronización.

### 🔹 Fase 3: Pasarela de Pagos & Generación de QR Bancario
- [ ] Generación dinámica de QR interoperable (QR Simple / Transferencia bancaria local) con monto exacto precargado.
- [ ] Verificación de pagos automática vía webhook o manual mediante comprobante de transferencia adjunto.
- [ ] Opción de donación física: Registro de donación en especie (bolsas de leche, cajas de panetón, lotes de juguetes) con asignación de punto de acopio.

### 🔹 Fase 4: Autenticación, Roles y Voluntariado
- [ ] Login social (Google Sign-In, Apple Sign-In o enlace mágico por WhatsApp/SMS).
- [ ] Roles de usuario:
  - **Donante / Padrino:** Crea colectas, aporta y recibe certificados digitales.
  - **Coordinador de Localidad:** Actualiza el avance físico de la chocolatada, show y empaque de juguetes.
  - **Voluntario de Caravana:** Se inscribe para viajar el día de la entrega a ayudar en la animación y servicio de chocolate.
- [ ] Módulo de inscripción de voluntarios para el día del viaje navideño.

### 🔹 Fase 5: Logística de la Caravana Navideña
- [ ] Control de inventario en tiempo real de centros de acopio:
  - Kilos de chocolate y unidades de panetón recepcionados.
  - Juguetes clasificados por rango de edad y género en almacén.
- [ ] Hoja de ruta de la caravana: Horarios de salida, transporte, puntos de encuentro y recomendaciones climáticas.
- [ ] Modo offline para coordinadores durante el viaje a zonas rurales sin señal celular.

### 🔹 Fase 6: Galería de Transparencia y Rendición de Cuentas Post-Navidad
- [ ] Álbum comunitario del evento: Fotografías del show, de la chocolatada comunitaria y del festejo general (cuidando no exponer rostros vulnerables en primeros planos).
- [ ] Resumen financiero auditado: Publicación transparente de facturas de compra de juguetes por mayor, insumos de chocolate y gastos de transporte.
- [ ] Descarga de certificado anual conmemorativo de impacto social para cada participante y empresa colaboradora.

---

## 📌 3. Prioridad Inmediata
1. **Refactorizar el código Flutter activo:**
   - Crear el modelo `LocalidadCampana` con los 3 pilares (**Chocolatada**, **Juegos**, **Juguetes**).
   - Adaptar `ColectaGroup` para vincularse a localidades.
   - Actualizar `MockData` con comunidades reales y sus metas comunitarias.
   - Refactorizar las pantallas del explorador y detalle para exhibir este nuevo modelo con la estética festiva premium.
   - Ejecutar pruebas y verificar con Hot Reload en Chrome.
