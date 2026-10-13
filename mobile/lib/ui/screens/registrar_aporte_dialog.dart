import 'package:flutter/material.dart';
import '../../domain/models/colecta_group.dart';
import '../../domain/models/contribution.dart';
import '../core/app_theme.dart';
import '../view_models/foundation_view_model.dart';

class RegistrarAporteDialog extends StatefulWidget {
  final ColectaGroup group;
  final FoundationViewModel viewModel;

  const RegistrarAporteDialog({
    super.key,
    required this.group,
    required this.viewModel,
  });

  @override
  State<RegistrarAporteDialog> createState() => _RegistrarAporteDialogState();
}

class _RegistrarAporteDialogState extends State<RegistrarAporteDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late TextEditingController _messageController;
  PaymentMethod _selectedMethod = PaymentMethod.qrTransferencia;
  bool _isAnonymous = false;
  bool _isSubmitting = false;

  final List<double> _quickAmounts = [10, 20, 30, 50];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.viewModel.currentUserName);
    _amountController = TextEditingController(text: '20');
    _messageController = TextEditingController(
      text: '¡Que esta Navidad esté llena de sonrisas y magia! Con mucho cariño.',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El monto debe ser mayor a 0')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    await widget.viewModel.addContribution(
      colectaId: widget.group.id,
      childId: widget.group.childId,
      donorName: _isAnonymous ? 'Amigo Anónimo' : _nameController.text.trim(),
      amount: amount,
      mensajeNavideno: _messageController.text.trim(),
      metodo: _selectedMethod,
      isAnonymous: _isAnonymous,
    );

    if (mounted) {
      setState(() => _isSubmitting = false);
      Navigator.pop(context);

      // Celebration dialog
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Text('✨', style: TextStyle(fontSize: 26)),
              SizedBox(width: 8),
              Text('¡Aporte Registrado!', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Has sumado \$${amount.toStringAsFixed(0)} a la colecta "${widget.group.nombreGrupo}".',
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 12),
              const Text(
                'Tu mensaje navideño ya fue publicado en el muro del grupo y el avance del regalo se actualizó.',
                style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('¡Excelente!'),
            ),
          ],
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
              Row(
                children: [
                  const Text('🎁', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sumar mi Aporte',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                        ),
                        Text(
                          widget.group.nombreGrupo,
                          style: const TextStyle(color: AppTheme.pineGreen, fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Montos rápidos
              const Text(
                'Monto a Aportar (\$USD):',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Row(
                children: _quickAmounts.map((q) {
                  final isSelected = _amountController.text == q.toStringAsFixed(0);
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: isSelected ? AppTheme.pineGreen : Colors.white,
                          foregroundColor: isSelected ? Colors.white : AppTheme.pineGreen,
                          side: BorderSide(
                            color: isSelected ? AppTheme.pineGreen : AppTheme.borderLight,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        onPressed: () {
                          setState(() {
                            _amountController.text = q.toStringAsFixed(0);
                          });
                        },
                        child: Text('\$$q'),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Otro Monto Personalizado',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Ingresa el monto' : null,
              ),

              const SizedBox(height: 16),

              // Tu Nombre
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Tu Nombre Completo',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Ingresa tu nombre' : null,
              ),

              const SizedBox(height: 12),

              // Checkbox anónimo
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: _isAnonymous,
                title: const Text(
                  'Aportar como donante anónimo',
                  style: TextStyle(fontSize: 14),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (val) => setState(() => _isAnonymous = val ?? false),
              ),

              const SizedBox(height: 8),

              // Mensaje Navideño
              TextFormField(
                controller: _messageController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Mensaje Navideño para el Niño y el Grupo',
                  hintText: 'Escribe unas palabras de aliento y cariño...',
                ),
              ),

              const SizedBox(height: 16),

              // Método de Pago
              const Text(
                'Método de Pago:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),
              RadioGroup<PaymentMethod>(
                groupValue: _selectedMethod,
                onChanged: (v) {
                  if (v != null) setState(() => _selectedMethod = v);
                },
                child: Column(
                  children: [
                    RadioListTile<PaymentMethod>(
                      contentPadding: EdgeInsets.zero,
                      value: PaymentMethod.qrTransferencia,
                      title: const Row(
                        children: [
                          Icon(Icons.qr_code_2, color: AppTheme.pineGreen, size: 20),
                          SizedBox(width: 8),
                          Text('QR Simple / Transferencia Bancaria', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    RadioListTile<PaymentMethod>(
                      contentPadding: EdgeInsets.zero,
                      value: PaymentMethod.tarjeta,
                      title: const Row(
                        children: [
                          Icon(Icons.credit_card, color: AppTheme.rubyRed, size: 20),
                          SizedBox(width: 8),
                          Text('Tarjeta Débito / Crédito', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    RadioListTile<PaymentMethod>(
                      contentPadding: EdgeInsets.zero,
                      value: PaymentMethod.efectivoPuntoAcopio,
                      title: const Row(
                        children: [
                          Icon(Icons.inventory_2_outlined, color: AppTheme.festiveGold, size: 20),
                          SizedBox(width: 8),
                          Text('Punto de Acopio Físico (Efectivo/Regalo)', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text('Confirmar y Registrar Aporte Navideño'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
