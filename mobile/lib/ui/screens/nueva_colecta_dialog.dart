import 'package:flutter/material.dart';
import '../../domain/models/child_story.dart';
import '../core/app_theme.dart';
import '../view_models/foundation_view_model.dart';

class NuevaColectaDialog extends StatefulWidget {
  final FoundationViewModel viewModel;
  final ChildStory? preselectedChild;

  const NuevaColectaDialog({
    super.key,
    required this.viewModel,
    this.preselectedChild,
  });

  @override
  State<NuevaColectaDialog> createState() => _NuevaColectaDialogState();
}

class _NuevaColectaDialogState extends State<NuevaColectaDialog> {
  final _formKey = GlobalKey<FormState>();
  late ChildStory? _selectedChild;
  late TextEditingController _nombreGrupoController;
  late TextEditingController _organizadorController;
  late TextEditingController _emailController;
  late TextEditingController _metaController;
  late TextEditingController _descController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedChild = widget.preselectedChild ??
        (widget.viewModel.children.isNotEmpty ? widget.viewModel.children.first : null);

    _nombreGrupoController = TextEditingController(text: 'Amigos & Familiares Solidarios 🎁');
    _organizadorController = TextEditingController(text: widget.viewModel.currentUserName);
    _emailController = TextEditingController(text: 'contacto@fundacionmoderna.org');
    _metaController = TextEditingController(
      text: _selectedChild != null ? _selectedChild!.metaMonto.toStringAsFixed(0) : '60',
    );
    _descController = TextEditingController(
      text: 'Nos unimos entre amigos para comprar el regalo navideño soñado y compartir esta alegría.',
    );
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
    if (!_formKey.currentState!.validate() || _selectedChild == null) return;

    setState(() => _isSaving = true);

    final meta = double.tryParse(_metaController.text.trim()) ?? _selectedChild!.metaMonto;

    await widget.viewModel.createNewColecta(
      childId: _selectedChild!.id,
      childName: '${_selectedChild!.nombre} (${_selectedChild!.deseoRegalo})',
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
          backgroundColor: AppTheme.emerald,
          content: Text('🎉 ¡Colecta creada con éxito! Ya puedes invitar a tus amigos.'),
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
                      color: AppTheme.textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Crea un grupo con amigos o compañeros para apadrinar juntos el regalo de un niño.',
                style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
              ),
              const SizedBox(height: 20),

              // Niño Selector
              const Text(
                'Niño / Causa Navideña:',
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
                  child: DropdownButton<ChildStory>(
                    isExpanded: true,
                    value: _selectedChild,
                    items: widget.viewModel.children.map((c) {
                      return DropdownMenuItem<ChildStory>(
                        value: c,
                        child: Text(
                          '${c.emoji} ${c.nombre} (${c.edad} a) - ${c.deseoRegalo}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedChild = val;
                          _metaController.text = val.metaMonto.toStringAsFixed(0);
                        });
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Nombre del Grupo
              const Text(
                'Nombre del Grupo de Amigos:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _nombreGrupoController,
                decoration: const InputDecoration(
                  hintText: 'Ej. Promo 2018, Equipo de Marketing, Familia López',
                  prefixIcon: Icon(Icons.people_outline),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Ingresa un nombre para el grupo' : null,
              ),

              const SizedBox(height: 16),

              // Meta y Organizador Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tu Nombre (Organizador):',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _organizadorController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Meta Total (\$USD):',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _metaController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.attach_money),
                          ),
                          validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Mensaje motivador
              const Text(
                'Mensaje de invitación para el grupo:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _descController,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: 'Cuéntales a tus amigos de qué trata esta colecta...',
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _submit,
                  child: _isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
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
