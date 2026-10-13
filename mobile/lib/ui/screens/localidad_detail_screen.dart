import 'package:flutter/material.dart';
import '../../domain/models/localidad_campana.dart';
import '../core/app_theme.dart';
import '../core/widgets/festive_badge.dart';
import '../core/widgets/progress_stat_bar.dart';
import '../view_models/foundation_view_model.dart';
import 'nueva_colecta_dialog.dart';

class LocalidadDetailScreen extends StatelessWidget {
  final LocalidadCampana localidad;
  final FoundationViewModel viewModel;

  const LocalidadDetailScreen({
    super.key,
    required this.localidad,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final currentLoc = viewModel.localidades.firstWhere(
          (l) => l.id == localidad.id,
          orElse: () => localidad,
        );

        final dias = currentLoc.diasParaCaravana;

        return Scaffold(
          appBar: AppBar(
            title: Text(currentLoc.nombre),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined),
                tooltip: 'Compartir campaña',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppTheme.pineGreen,
                      content: Text(
                        'Enlace de campaña copiado para invitar amigos a apoyar a ${currentLoc.nombre}',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Hero Banner de la Localidad
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F5132), Color(0xFF198754)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.pineGreen.withValues(alpha: 0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              currentLoc.emoji,
                              style: const TextStyle(fontSize: 32),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentLoc.nombre,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                currentLoc.departamentoZona,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FestiveBadge(
                          text: '${currentLoc.cantidadNinosEstimados} Niños beneficiados',
                          color: AppTheme.festiveGold,
                          textColor: const Color(0xFF5A4100),
                          icon: Icons.family_restroom,
                        ),
                        FestiveBadge(
                          text: dias == 0
                              ? '¡Caravana es HOY!'
                              : 'Faltan $dias días para la Caravana',
                          color: Colors.white.withValues(alpha: 0.2),
                          textColor: Colors.white,
                          icon: Icons.event,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Progreso total
                    ProgressStatBar(
                      label: 'Meta Comunitaria Integral',
                      current: currentLoc.recaudadoTotal,
                      target: currentLoc.metaTotal,
                      progressColor: AppTheme.festiveGold,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Sección: Los 3 Pilares Navideños
              const Text(
                'Los 3 Pilares de la Fiesta Navideña 🎄',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Cada localidad recibe una celebración comunitaria con chocolatada, juegos recreativos y entrega de juguetes.',
                style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
              ),
              const SizedBox(height: 14),

              // Pilar 1: Chocolatada & Panetón
              _buildPilarCard(
                iconEmoji: '☕',
                title: 'Chocolatada Navideña & Panetón',
                subtitle:
                    'Chocolate caliente tradicional preparado en calderos con canela, clavo de olor y raciones de panetón.',
                current: currentLoc.recaudadoChocolatada,
                target: currentLoc.metaChocolatada,
                color: const Color(0xFF8B4513),
              ),
              const SizedBox(height: 12),

              // Pilar 2: Juegos & Show
              _buildPilarCard(
                iconEmoji: '🎪',
                title: 'Juegos, Animación & Show Navideño',
                subtitle:
                    'Payasos, títeres, música festiva, juegos recreativos, piñatas y monitores juveniles de la fundación.',
                current: currentLoc.recaudadoJuegos,
                target: currentLoc.metaJuegos,
                color: const Color(0xFFD97706),
              ),
              const SizedBox(height: 12),

              // Pilar 3: Lote de Juguetes
              _buildPilarCard(
                iconEmoji: '🎁',
                title: 'Lote de Juguetes por Edades',
                subtitle:
                    'Juguetes nuevos clasificados (0-3, 4-7, 8-12 años): pelotas, muñecas, autitos, juegos didácticos y sets de arte.',
                current: currentLoc.recaudadoJuguetes,
                target: currentLoc.metaJuguetes,
                color: AppTheme.rubyRed,
              ),

              const SizedBox(height: 20),

              // Descripción de la Comunidad y Logística
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info_outline, color: AppTheme.pineGreen, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Sobre la Comunidad',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      currentLoc.descripcionComunidad,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const Divider(height: 24),
                    const Row(
                      children: [
                        Icon(Icons.local_shipping_outlined, color: AppTheme.pineGreen, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Logística de la Caravana',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Punto de partida: ${currentLoc.puntoEncuentroSalida}',
                      style: const TextStyle(fontSize: 13, color: AppTheme.textMuted),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Lista de insumos necesarios:',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    ...currentLoc.necesidadesPuntuales.map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline,
                                color: AppTheme.pineGreen, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Botón de acción para crear colecta entre amigos
              ElevatedButton.icon(
                icon: const Icon(Icons.group_add),
                label: const Text('Iniciar Colecta entre Amigos para esta Localidad'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (ctx) => NuevaColectaDialog(
                      viewModel: viewModel,
                      preselectedLocalidad: currentLoc,
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPilarCard({
    required String iconEmoji,
    required String title,
    required String subtitle,
    required double current,
    required double target,
    required Color color,
  }) {
    final pct = target <= 0 ? 0.0 : (current / target > 1.0 ? 1.0 : current / target);
    final completo = current >= target;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: completo ? color.withValues(alpha: 0.5) : AppTheme.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(iconEmoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              if (completo)
                const FestiveBadge(
                  text: '¡Meta lograda!',
                  color: Color(0xFFD1E7DD),
                  textColor: Color(0xFF0F5132),
                  icon: Icons.check,
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 8,
              backgroundColor: AppTheme.progressBackground,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recaudado: \$${current.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text(
                'Meta: \$${target.toStringAsFixed(0)} (${(pct * 100).toInt()}%)',
                style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
