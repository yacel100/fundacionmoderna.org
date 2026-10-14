import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/widgets/festive_badge.dart';
import '../view_models/foundation_view_model.dart';

class MiImpactoScreen extends StatelessWidget {
  final FoundationViewModel viewModel;

  const MiImpactoScreen({
    super.key,
    required this.viewModel,
  });

  void _showCertificateModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.festiveGold, width: 3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('⭐', style: TextStyle(fontSize: 24)),
                  SizedBox(width: 8),
                  Text(
                    'CERTIFICADO DE HONOR',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.pineGreen,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('⭐', style: TextStyle(fontSize: 24)),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'Misión Navidad 2026 • Fundación Moderna',
                style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
              ),
              const SizedBox(height: 20),
              const Text(
                'Otorga este reconocimiento de gratitud a:',
                style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 8),
              Text(
                viewModel.currentUserName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.modernaGreen,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Por unir corazones y apadrinar con amor a las comunidades y niños en esta Navidad.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.lightGold,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '🏅 Padrino Mágico Oficial',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.festiveGold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Cerrar'),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.pineGreen),
                    icon: const Icon(Icons.share, size: 18),
                    label: const Text('Compartir'),
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: AppTheme.pineGreen,
                          content: Text('Certificado listo para compartir en historias y WhatsApp!'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final myContribs = viewModel.allContributions
            .where((c) => c.donorName == viewModel.currentUserName)
            .toList();

        final totalMyDonations =
            myContribs.fold(0.0, (acc, c) => acc + c.amount);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Mi Pasaporte Solidario'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // User Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.rubyRed, AppTheme.brightRuby],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white,
                      child: Text('🎅', style: TextStyle(fontSize: 36)),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      viewModel.currentUserName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Padrino Navideño Activo • Fundación Moderna',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 14),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text('Cambiar Nombre de Padrino'),
                      onPressed: () {
                        _showEditNameDialog(context);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // KPI Stats Grid
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Aporte Total',
                      value: '\$${totalMyDonations.toStringAsFixed(0)}',
                      icon: Icons.favorite,
                      color: AppTheme.rubyRed,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Regalos Apoyados',
                      value: '${myContribs.length}',
                      icon: Icons.card_giftcard,
                      color: AppTheme.pineGreen,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Grupos Unidos',
                      value: '${viewModel.groups.length}',
                      icon: Icons.group,
                      color: AppTheme.festiveGold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Certificate Promotion Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppTheme.lightGold,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Text('📜', style: TextStyle(fontSize: 30)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Certificado de Gratitud',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppTheme.textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Obtén tu reconocimiento oficial para compartir con tus amigos.',
                              style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                foregroundColor: AppTheme.rubyRed,
                              ),
                              onPressed: () => _showCertificateModal(context),
                              child: const Text('Ver y Descargar Certificado →'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Historial de tus Aportes Navideños',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 12),

              if (myContribs.isEmpty)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.borderLight),
                  ),
                  child: const Center(
                    child: Text(
                      'Aún no has registrado un aporte directo con tu nombre actual.\nÚnete a una colecta y suma tu regalo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                    ),
                  ),
                )
              else
                ...myContribs.map((c) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: AppTheme.lightGold,
                          child: Text('🎁'),
                        ),
                        title: Text('Aporte de \$${c.amount.toStringAsFixed(0)}'),
                        subtitle: Text(
                          '"${c.mensajeNavideno}"',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: FestiveBadge(
                          text: c.metodoTexto,
                          backgroundColor: AppTheme.softBackground,
                          textColor: AppTheme.textMuted,
                        ),
                      ),
                    )),
            ],
          ),
        );
      },
    );
  }

  void _showEditNameDialog(BuildContext context) {
    final controller = TextEditingController(text: viewModel.currentUserName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nombre de Padrino'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Tu Nombre'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                viewModel.setCurrentUserName(controller.text.trim());
              }
              Navigator.pop(ctx);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
          ),
        ],
      ),
    );
  }
}
