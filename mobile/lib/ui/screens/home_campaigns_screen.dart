import 'package:flutter/material.dart';
import '../../domain/models/localidad_campana.dart';
import '../core/app_theme.dart';
import '../core/widgets/festive_badge.dart';
import '../core/widgets/progress_stat_bar.dart';
import '../view_models/foundation_view_model.dart';
import 'localidad_detail_screen.dart';
import 'nueva_colecta_dialog.dart';

class HomeCampaignsScreen extends StatelessWidget {
  final FoundationViewModel viewModel;

  const HomeCampaignsScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final localidades = viewModel.localidades;

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                const Text('🎄 ', style: TextStyle(fontSize: 20)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fundación Moderna',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Misión Navidad por Localidades',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.rubyRed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: AppTheme.rubyRed),
                tooltip: 'Padrinos activos',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppTheme.pineGreen,
                      content: Text(
                        '¡${viewModel.totalPadrinosActivos} amigos y voluntarios ya se unieron a la caravana!',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              // Hero Banner Global de la Campaña Navideña
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B0000), Color(0xFFC41E3A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.rubyRed.withValues(alpha: 0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Misión Navideña 2026 ⭐',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FestiveBadge(
                          text: 'Caravana Activa',
                          color: Colors.white,
                          textColor: AppTheme.rubyRed,
                          icon: Icons.local_shipping,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Llevamos Chocolatada, Juegos & Juguetes a comunidades vulnerables con amigos solidarios.',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 16),

                    // Resumen numérico rápido
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildKpiMini('Niños', '${viewModel.totalNinosBeneficiados}', '👶'),
                        _buildKpiMini(
                          'Chocolatada',
                          '\$${viewModel.totalChocolatadaRecaudada.toStringAsFixed(0)}',
                          '☕',
                        ),
                        _buildKpiMini(
                          'Juguetes',
                          '\$${viewModel.totalJuguetesRecaudados.toStringAsFixed(0)}',
                          '🎁',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Barra de progreso general
                    ProgressStatBar(
                      label: 'Recaudación Comunitaria Total',
                      current: viewModel.totalMontoRecaudadoGeneral,
                      target: viewModel.metaTotalCampana,
                      progressColor: AppTheme.festiveGold,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Banner ético de Protección y Dignidad Infantil
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.pineGreen.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.pineGreen.withValues(alpha: 0.2),
                  ),
                ),
                child: const Row(
                  children: [
                    Text('🛡️', style: TextStyle(fontSize: 20)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Por protección infantil y dignidad, apoyamos por Localidades en lugar de publicar datos individuales. ¡Ningún niño se queda sin regalo!',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.pineGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Buscador de Localidades
              TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar localidad o zona rural...',
                  prefixIcon: const Icon(Icons.search, color: AppTheme.textMuted),
                  suffixIcon: viewModel.searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => viewModel.setSearchQuery(''),
                        )
                      : null,
                ),
                onChanged: (val) => viewModel.setSearchQuery(val),
              ),

              const SizedBox(height: 18),

              // Cabecera de la lista
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Localidades Beneficiarias (${localidades.length})',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Crear Colecta'),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (ctx) => NuevaColectaDialog(viewModel: viewModel),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Lista de Localidades
              if (localidades.isEmpty)
                _buildEmptyState(context)
              else
                ...localidades.map((loc) => _buildLocalidadCard(context, loc)),

              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKpiMini(String label, String value, String emoji) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.white70, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocalidadCard(BuildContext context, LocalidadCampana loc) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => LocalidadDetailScreen(
                localidad: loc,
                viewModel: viewModel,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header de la tarjeta
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppTheme.pineGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(loc.emoji, style: const TextStyle(fontSize: 26)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.nombre,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          loc.departamentoZona,
                          style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
                        ),
                      ],
                    ),
                  ),
                  FestiveBadge(
                    text: '${loc.cantidadNinosEstimados} Niños',
                    color: AppTheme.pineGreen.withValues(alpha: 0.12),
                    textColor: AppTheme.pineGreen,
                    icon: Icons.child_care,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                loc.descripcionComunidad,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12.5, color: Color(0xFF4A5568)),
              ),

              const SizedBox(height: 14),

              // Desglose de los 3 Pilares Comunitarios
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _buildPilarRow(
                      emoji: '☕',
                      name: 'Chocolatada',
                      current: loc.recaudadoChocolatada,
                      target: loc.metaChocolatada,
                      color: const Color(0xFF8B4513),
                    ),
                    const SizedBox(height: 6),
                    _buildPilarRow(
                      emoji: '🎪',
                      name: 'Juegos & Show',
                      current: loc.recaudadoJuegos,
                      target: loc.metaJuegos,
                      color: const Color(0xFFD97706),
                    ),
                    const SizedBox(height: 6),
                    _buildPilarRow(
                      emoji: '🎁',
                      name: 'Lote Juguetes',
                      current: loc.recaudadoJuguetes,
                      target: loc.metaJuguetes,
                      color: AppTheme.rubyRed,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Barra de progreso global
              ProgressStatBar(
                label: 'Avance Total de la Localidad',
                current: loc.recaudadoTotal,
                target: loc.metaTotal,
                progressColor: AppTheme.pineGreen,
              ),

              const SizedBox(height: 12),

              // Footer con botones de acción
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Caravana: ${loc.fechaCaravana.day}/${loc.fechaCaravana.month}',
                    style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          minimumSize: const Size(0, 32),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (ctx) => NuevaColectaDialog(
                              viewModel: viewModel,
                              preselectedLocalidad: loc,
                            ),
                          );
                        },
                        child: const Text('Colectar con Amigos', style: TextStyle(fontSize: 11)),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          minimumSize: const Size(0, 32),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => LocalidadDetailScreen(
                                localidad: loc,
                                viewModel: viewModel,
                              ),
                            ),
                          );
                        },
                        child: const Text('Ver Ficha', style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPilarRow({
    required String emoji,
    required String name,
    required double current,
    required double target,
    required Color color,
  }) {
    final pct = target <= 0 ? 0.0 : (current / target > 1.0 ? 1.0 : current / target);
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 6),
        SizedBox(
          width: 90,
          child: Text(
            name,
            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 6,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '\$${current.toStringAsFixed(0)} / \$${target.toStringAsFixed(0)}',
          style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text('🔍', style: TextStyle(fontSize: 40)),
          const SizedBox(height: 12),
          const Text(
            'No se encontraron localidades con ese filtro',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 6),
          const Text(
            'Prueba cambiando el término de búsqueda.',
            style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => viewModel.setSearchQuery(''),
            child: const Text('Limpiar búsqueda'),
          ),
        ],
      ),
    );
  }
}
