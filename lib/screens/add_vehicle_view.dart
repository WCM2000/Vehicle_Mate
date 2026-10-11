import 'package:flutter/material.dart';

typedef AddVehicleSubmit = Future<void> Function({
  required String plateNumber,
  String? model,
  required double weeklyQuota,
});

class AddVehicleView extends StatefulWidget {
  const AddVehicleView({super.key, required this.onSubmit});

  final AddVehicleSubmit onSubmit;

  @override
  State<AddVehicleView> createState() => _AddVehicleViewState();
}

class _AddVehicleViewState extends State<AddVehicleView> {
  final _plateController = TextEditingController();
  final _modelController = TextEditingController();
  final _quotaController = TextEditingController(text: '20.0');

  @override
  void dispose() {
    _plateController.dispose();
    _modelController.dispose();
    _quotaController.dispose();
    super.dispose();
  }

  void _submit() {
    final plate = _plateController.text.trim();
    final quota = double.tryParse(_quotaController.text.trim());
    if (plate.isEmpty || quota == null || quota <= 0) return;

    final model = _modelController.text.trim();
    widget.onSubmit(
      plateNumber: plate,
      model: model.isEmpty ? null : model,
      weeklyQuota: quota,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add your vehicle')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _plateController,
                decoration: const InputDecoration(labelText: 'Plate number'),
                textCapitalization: TextCapitalization.characters,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _modelController,
                decoration: const InputDecoration(labelText: 'Vehicle model'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _quotaController,
                decoration: const InputDecoration(
                  labelText: 'Initial weekly quota (L)',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _submit,
                child: const Text('Save vehicle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
