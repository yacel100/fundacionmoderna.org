import 'package:flutter/material.dart';
import '../../domain/models/localidad_campana.dart';
import '../core/app_theme.dart';
import '../core/widgets/festive_badge.dart';
import '../core/widgets/progress_stat_bar.dart';
import '../view_models/foundation_view_model.dart';
import 'info_fundacion_screen.dart';
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    'assets/images/logo_moderna.gif',
                    height: 28,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
            actions: [
              IconButton(
                icon: const Icon(Icons.info_outline, color: AppTheme.rubyRed),
                tooltip: 'Conoce Fundación Moderna',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) =>
                          InfoFundacionScreen(viewModel: viewModel),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite,
                    color: AppTheme.rubyRed),
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
              // 🎄 Hero Banner Principal Festivo
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.rubyRed, AppTheme.brightRuby],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.rubyRed.withValues(alpha: 0.28),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Misión Navideña 2026 ⭐',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.local_shipping,
                                  size: 14, color: AppTheme.rubyRed),
                              SizedBox(width: 4),
                              Text(
                                'Caravana Activa',
                                style: TextStyle(
                                  color: AppTheme.rubyRed,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Llevamos Chocolatada, Juegos & Juguetes a comunidades vulnerables junto a amigos solidarios.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Resumen numérico de la web
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildKpiMini('Niños',
                            '${viewModel.totalNinosBeneficiados}', '👶'),
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
                    const SizedBox(height: 18),

                    // Barra de progreso general sobre fondo blanco traslúcido
                    ProgressStatBar(
                      label: 'Recaudación Comunitaria Total',
                      current: viewModel.totalMontoRecaudadoGeneral,
                      target: viewModel.metaTotalCampana,
                      progressColor: Colors.white,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Banner ético de Protección Infantil y Enfoque Comunitario
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppTheme.borderLight),
                ),
                child: const Row(
                  children: [
                    Text('🛡️', style: TextStyle(fontSize: 22)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Por dignidad y protección infantil, apoyamos por Localidades en lugar de publicar datos de niños individuales. ¡Llevamos alegría a toda la comunidad!',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: AppTheme.textBody,
                          height: 1.35,
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
                  hintText: 'Buscar localidad o comunidad...',
                  prefixIcon:
                      const Icon(Icons.search, color: AppTheme.rubyRed),
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
                      color: AppTheme.textHeading,
                    ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.rubyRed,
                    ),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text(
                      'Crear Colecta',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (ctx) =>
                            NuevaColectaDialog(viewModel: viewModel),
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 10.5),
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
                      color: AppTheme.greenLightBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child:
                          Text(loc.emoji, style: const TextStyle(fontSize: 26)),
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
                            color: AppTheme.textHeading,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          loc.departamentoZona,
                          style: const TextStyle(
                              fontSize: 12, color: AppTheme.textMuted),
                        ),
                      ],
                    ),
                  ),
                  FestiveBadge(
                    text: '${loc.cantidadNinosEstimados} Niños',
                    backgroundColor: AppTheme.greenLightBg,
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
                style: const TextStyle(
                  fontSize: 12.5,
                  color: AppTheme.textBody,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 14),

              // Desglose de los 3 Pilares Comunitarios
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildPilarRow(
                      emoji: '☕',
                      name: 'Chocolatada',
                      current: loc.recaudadoChocolatada,
                      target: loc.metaChocolatada,
                      color: AppTheme.chocoColor,
                    ),
                    const SizedBox(height: 6),
                    _buildPilarRow(
                      emoji: '🎪',
                      name: 'Juegos & Show',
                      current: loc.recaudadoJuegos,
                      target: loc.metaJuegos,
                      color: AppTheme.juegosColor,
                    ),
                    const SizedBox(height: 6),
                    _buildPilarRow(
                      emoji: '🎁',
                      name: 'Lote Juguetes',
                      current: loc.recaudadoJuguetes,
                      target: loc.metaJuguetes,
                      color: AppTheme.juguetesColor,
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

              const SizedBox(height: 14),

              // Footer con botones de acción
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Caravana: ${loc.fechaCaravana.day}/${loc.fechaCaravana.month}',
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.textMuted),
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          minimumSize: const Size(0, 34),
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
                        child: const Text('Colectar',
                            style: TextStyle(fontSize: 12)),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.rubyRed,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          minimumSize: const Size(0, 34),
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
                        child: const Text('Ver Ficha',
                            style: TextStyle(fontSize: 12)),
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
    final pct =
        target <= 0 ? 0.0 : (current / target > 1.0 ? 1.0 : current / target);
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
