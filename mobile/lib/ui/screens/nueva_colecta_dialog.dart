import 'package:flutter/material.dart';
import '../../domain/models/localidad_campana.dart';
import '../core/app_theme.dart';
import '../view_models/foundation_view_model.dart';

class NuevaColectaDialog extends StatefulWidget {
  final FoundationViewModel viewModel;
  final LocalidadCampana? preselectedLocalidad;

  const NuevaColectaDialog({
    super.key,
    required this.viewModel,
    this.preselectedLocalidad,
  });

  @override
  State<NuevaColectaDialog> createState() => _NuevaColectaDialogState();
}

class _NuevaColectaDialogState extends State<NuevaColectaDialog> {
  final _formKey = GlobalKey<FormState>();
  late LocalidadCampana? _selectedLocalidad;
  PilarNavideno _selectedPilar = PilarNavideno.chocolatada;

  late TextEditingController _nombreGrupoController;
  late TextEditingController _organizadorController;
  late TextEditingController _emailController;
  late TextEditingController _metaController;
  late TextEditingController _descController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedLocalidad = widget.preselectedLocalidad ??
        (widget.viewModel.localidades.isNotEmpty
            ? widget.viewModel.localidades.first
            : null);

    _nombreGrupoController =
        TextEditingController(text: 'Amigos Solidarios por la Navidad ☕');
    _organizadorController =
        TextEditingController(text: widget.viewModel.currentUserName);
    _emailController =
        TextEditingController(text: 'amigos.navidad@fundacionmoderna.org');
    _metaController = TextEditingController(text: '150');
    _descController = TextEditingController(
      text:
          'Nos organizamos entre amigos para financiar este pilar de la fiesta navideña comunitaria y compartir alegría.',
    );

    _updateSugerencia();
  }

  void _updateSugerencia() {
    if (_selectedLocalidad == null) return;
    double suggested = 150;
    String pilarName = 'Chocolatada';
    switch (_selectedPilar) {
      case PilarNavideno.chocolatada:
        suggested = _selectedLocalidad!.metaChocolatada;
        pilarName = 'Chocolatada & Panetón';
        break;
      case PilarNavideno.juegosShow:
        suggested = _selectedLocalidad!.metaJuegos;
        pilarName = 'Juegos & Show';
        break;
      case PilarNavideno.juguetes:
        suggested = _selectedLocalidad!.metaJuguetes;
        pilarName = 'Lote de Juguetes';
        break;
      case PilarNavideno.integral:
        suggested = _selectedLocalidad!.metaTotal;
        pilarName = 'Fiesta Completa';
        break;
    }
    _metaController.text = suggested.toStringAsFixed(0);
    _nombreGrupoController.text =
        'Amigos por $pilarName en ${_selectedLocalidad!.nombre} 🎁';
  }

  @override
  void dispose() {
    _nombreGrupoController.dispose();
    _organizadorController.dispose();
    _emailController.dispose();
    _metaController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _selectedLocalidad == null) {
      return;
    }

    setState(() => _isSaving = true);

    final meta = double.tryParse(_metaController.text.trim()) ?? 150.0;

    await widget.viewModel.createNewColecta(
      localidadId: _selectedLocalidad!.id,
      localidadNombre: _selectedLocalidad!.nombre,
      pilar: _selectedPilar,
      nombreGrupo: _nombreGrupoController.text.trim(),
      organizadorNombre: _organizadorController.text.trim(),
      organizadorEmail: _emailController.text.trim(),
      metaGrupo: meta,
      fechaLimite: DateTime.now().add(const Duration(days: 10)),
      descripcion: _descController.text.trim(),
    );

    if (mounted) {
      setState(() => _isSaving = false);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppTheme.pineGreen,
          content: Text(
            '🎉 ¡Colecta comunitaria creada! Ya puedes invitar a tus amigos por WhatsApp.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.borderLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Text('🎄', style: TextStyle(fontSize: 22)),
                  SizedBox(width: 8),
                  Text(
                    'Nueva Colecta entre Amigos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Crea un grupo con amigos o compañeros de trabajo para apoyar a una localidad con chocolatada, juegos o juguetes.',
                style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
              ),
              const SizedBox(height: 20),

              // Localidad Selector
              const Text(
                'Localidad Comunitaria:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.borderLight),
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<LocalidadCampana>(
                    isExpanded: true,
                    value: _selectedLocalidad,
                    items: widget.viewModel.localidades.map((loc) {
                      return DropdownMenuItem<LocalidadCampana>(
                        value: loc,
                        child: Row(
                          children: [
                            Text(loc.emoji,
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${loc.nombre} (${loc.cantidadNinosEstimados} niños)',
                                style: const TextStyle(fontSize: 13.5),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedLocalidad = val;
                          _updateSugerencia();
                        });
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Pilar Selector
              const Text(
                'Pilar a Financiar:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.borderLight),
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<PilarNavideno>(
                    isExpanded: true,
                    value: _selectedPilar,
                    items: const [
                      DropdownMenuItem(
                        value: PilarNavideno.chocolatada,
                        child: Text('☕ Chocolatada Navideña & Panetón'),
                      ),
                      DropdownMenuItem(
                        value: PilarNavideno.juegosShow,
                        child: Text('🎪 Juegos, Show & Animación Infantil'),
                      ),
                      DropdownMenuItem(
                        value: PilarNavideno.juguetes,
                        child: Text('🎁 Lote de Juguetes por Edades'),
                      ),
                      DropdownMenuItem(
                        value: PilarNavideno.integral,
                        child: Text('🎄 Fiesta Navideña Completa'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedPilar = val;
                          _updateSugerencia();
                        });
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Nombre del Grupo
              const Text(
                'Nombre del Grupo:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _nombreGrupoController,
                decoration: const InputDecoration(
                  hintText: 'Ej. Amigos de Promoción por San Antonio',
                ),
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Requerido' : null,
              ),

              const SizedBox(height: 16),

              // Meta Financiera ($)
              const Text(
                'Meta a Recaudar (\$ USD):',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _metaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixText: '\$ ',
                  hintText: '150',
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Requerido';
                  final n = double.tryParse(val.trim());
                  if (n == null || n <= 0) return 'Monto inválido';
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Organizador
              const Text(
                'Organizador:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _organizadorController,
                decoration: const InputDecoration(
                  hintText: 'Tu nombre completo',
                ),
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Requerido' : null,
              ),

              const SizedBox(height: 16),

              // Mensaje motivacional
              const Text(
                'Mensaje para tus amigos:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _descController,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: '¿Por qué nos unimos en esta colecta?',
                ),
              ),

              const SizedBox(height: 24),

              // Botón de Envío
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _submit,
                  child: _isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Crear Colecta y Obtener Enlace de Invitación'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
