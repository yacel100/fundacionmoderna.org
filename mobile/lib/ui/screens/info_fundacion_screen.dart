import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../view_models/foundation_view_model.dart';
import 'nueva_colecta_dialog.dart';
import 'registrar_aporte_dialog.dart';

class InfoFundacionScreen extends StatelessWidget {
  final FoundationViewModel viewModel;

  const InfoFundacionScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softBackground,
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/logo_moderna.gif',
                height: 26,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            ),
            const SizedBox(width: 8),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textHeading,
                ),
                children: [
                  TextSpan(text: 'Fundación moderna'),
                  TextSpan(
                    text: '.',
                    style: TextStyle(
                      color: AppTheme.rubyRed,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppTheme.rubyLightBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.rubyRed.withValues(alpha: 0.3),
                ),
              ),
              child: const Text(
                'Misión Navidad',
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.rubyRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // 🎄 HERO BANNER CON IMAGEN Y PALETA ROJO RUBÍ & DORADO
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              children: [
                // Imagen de fondo
                Image.asset(
                  'assets/images/hero_banner.jpg',
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 240,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppTheme.rubyRed, Color(0xFF7A0010)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    );
                  },
                ),
                // Gradiente oscuro y rubí sobre la imagen
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.rubyRed.withValues(alpha: 0.88),
                        const Color(0xFF7A0010).withValues(alpha: 0.85),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
                // Contenido del Hero
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                          ),
                        ),
                        child: const Text(
                          '⭐ Caravana Solidaria Navideña 2026',
                          style: TextStyle(
                            color: AppTheme.lightGold,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Llevamos la Magia y Esperanza de la Navidad',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Chocolatadas comunitarias, shows infantiles y juguetes nuevos para cientos de niños en sectores vulnerables.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Fila de Estadísticas
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildMiniKpi(
                              '+${viewModel.totalNinosBeneficiados}', 'Niños'),
                          _buildMiniKpi(
                              '${viewModel.localidades.length}', 'Comunidades'),
                          _buildMiniKpi('100%', 'Transparencia'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // 🛡️ BANNER ÉTICO DE PROTECCIÓN INFANTIL
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF092C1B), AppTheme.pineGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.pineGreen.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('🛡️', style: TextStyle(fontSize: 28)),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Compromiso Ético de Protección Infantil',
                        style: TextStyle(
                          color: AppTheme.lightGold,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Por dignidad y seguridad, NO publicamos fotos ni datos de niños vulnerables. Apoyamos de forma comunitaria por Localidades, asegurando que todos los niños reciban la misma alegría.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // 🎪☕🎁 LOS 3 PILARES NAVIDEÑOS
          const Text(
            'Los 3 Pilares de Misión Navidad 🎄',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textHeading,
            ),
          ),
          const SizedBox(height: 10),

          _buildPilarCard(
            emoji: '☕',
            title: '1. Chocolatada & Panetón',
            description:
                'Chocolate caliente tradicional preparado en calderos con canela, clavo de olor y leche fresca, servido con raciones de panetón para las familias.',
            color: AppTheme.chocoColor,
            bgColor: const Color(0xFFFEF3C7),
          ),

          const SizedBox(height: 10),

          _buildPilarCard(
            emoji: '🎪',
            title: '2. Juegos, Show & Dinámicas',
            description:
                'Espectáculo infantil con música navideña, elenco de payasos voluntarios, concursos, dinámicas recreativas y piñatas llenas de diversión.',
            color: AppTheme.juegosColor,
            bgColor: const Color(0xFFFFF7ED),
          ),

          const SizedBox(height: 10),

          _buildPilarCard(
            emoji: '🎁',
            title: '3. Lotes de Juguetes Colectivos',
            description:
                'Juguetes nuevos, seguros y clasificados por edades (0-3, 4-7 y 8-12 años), entregados en bolsas festivas individuales a cada niño.',
            color: AppTheme.juguetesColor,
            bgColor: const Color(0xFFFFE4E6),
          ),

          const SizedBox(height: 22),

          // 👥 CÓMO FUNCIONA LA COLECTA ENTRE AMIGOS
          const Text(
            '¿Cómo Funciona la Colecta con Amigos? 👥',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textHeading,
            ),
          ),
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: Column(
              children: [
                _buildStepItem(
                  number: '1',
                  title: 'Elige una Localidad o Pilar',
                  desc:
                      'Selecciona la comunidad o pilar que deseas patrocinar con tu grupo.',
                  color: AppTheme.rubyRed,
                ),
                const Divider(height: 20),
                _buildStepItem(
                  number: '2',
                  title: 'Crea tu Grupo e Invita',
                  desc:
                      'Asigna un nombre a tu colecta y comparte el enlace de invitación por WhatsApp.',
                  color: AppTheme.festiveGold,
                ),
                const Divider(height: 20),
                _buildStepItem(
                  number: '3',
                  title: 'Aporten por QR o Transferencia',
                  desc:
                      'Registren sus aportes y sigan el avance grupal en tiempo real.',
                  color: AppTheme.pineGreen,
                ),
                const Divider(height: 20),
                _buildStepItem(
                  number: '4',
                  title: 'Reporte y Certificado de Gratitud',
                  desc:
                      'Recibe fotografías del festejo y tu Certificado Digital oficial.',
                  color: AppTheme.rubyRed,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // BOTONES DE ACCIÓN PRINCIPALES
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.favorite_border, size: 18),
                  label: const Text('Sumar Aporte'),
                  onPressed: () => _showDonacionDirectaModal(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.group_add, size: 18),
                  label: const Text('Crear Colecta'),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (ctx) =>
                          NuevaColectaDialog(viewModel: viewModel),
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildMiniKpi(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.lightGold,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPilarCard({
    required String emoji,
    required String title,
    required String description,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textBody,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem({
    required String number,
    required String title,
    required String desc,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: color,
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: AppTheme.textHeading,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: AppTheme.textMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDonacionDirectaModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.borderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text('🎁', style: TextStyle(fontSize: 36)),
              const SizedBox(height: 8),
              const Text(
                'Sumar Aporte a Misión Navidad',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textHeading,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Tu aporte financia chocolatada caliente, shows y juguetes.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.5, color: AppTheme.textMuted),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderLight),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.qr_code_2,
                        size: 90, color: AppTheme.rubyRed),
                    const SizedBox(height: 8),
                    const Text(
                      'Escanea con cualquier app bancaria o billetera móvil',
                      style: TextStyle(fontSize: 11.5, color: AppTheme.textMuted),
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cuenta Oficial Fundación Moderna',
                              style: TextStyle(
                                  fontSize: 11, color: AppTheme.textMuted),
                            ),
                            Text(
                              '0011-0123-0200894567',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textHeading,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.rubyRed,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            minimumSize: const Size(0, 32),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: AppTheme.pineGreen,
                                content: Text('¡Número de cuenta copiado! ✓'),
                              ),
                            );
                          },
                          child: const Text('Copiar',
                              style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (viewModel.groups.isNotEmpty)
                TextButton.icon(
                  icon: const Icon(Icons.group, size: 16),
                  label: const Text('O aportar a través de un grupo activo →'),
                  onPressed: () {
                    Navigator.pop(ctx);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (c) => RegistrarAporteDialog(
                        group: viewModel.groups.first,
                        viewModel: viewModel,
                      ),
                    );
                  },
                ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
