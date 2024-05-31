import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ryc_desafio_do_modulo_basico/components/app_button.dart';
import 'package:ryc_desafio_do_modulo_basico/models/task_model.dart';
import 'package:ryc_desafio_do_modulo_basico/providers/task_list_provider.dart';
import 'package:ryc_desafio_do_modulo_basico/utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formData = <String, String> {
    'title': '',
    'description': '',
  };

  final _formKey = GlobalKey<FormState>();

  final _dateFieldController = TextEditingController();
  DateTime? _selectedDateTime;

  bool _disableSubmitBtn = false;

  void _submitForm() async {
    setState(() {
      _disableSubmitBtn = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _formKey.currentState!.reset();
      final newTask = TaskModel(
        title: _formData['title']!,
        description: _formData['description'] ?? '',
        date: _selectedDateTime!,
      );

      context.read<TaskListProvider>().addTask(newTask);

      Navigator.of(context).pop();
    }
    setState(() {
      _disableSubmitBtn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final initialTitle = ModalRoute.of(context)?.settings.arguments ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: (initialTitle ?? '') as String,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                  ),
                ),
                onSaved: (value) => _formData['title'] = value!,
                validator: (String? value) {
                  if (!isRequired(value)) {
                    return 'Título é obrigatório';
                  }

                  if (!minChars(value!, 3)) {
                    return 'O título deve conter ao menos 3 caracteres';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                  ),
                ),
                maxLines: 3,
                onSaved: (value) => _formData['description'] = value ?? '',
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _dateFieldController,
                decoration: const InputDecoration(
                  labelText: 'Data limite',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                  ),
                ),
                showCursor: false,
                enableInteractiveSelection: false,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now().add(
                      const Duration(days: 1),
                    ),
                    lastDate: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                  ).then(
                    (newDate) {
                      if (newDate != null) {
                        setState(() {
                          _dateFieldController.text =
                              DateFormat('dd/MM/yyyy').format(newDate);
                          _selectedDateTime = newDate;
                        });
                      }
                    },
                  );
                },
                validator: (String? value) {
                  if (!isRequired(value)) {
                    return 'Data limite é obrigatório';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppElevatedButton(
                      onPressed: _disableSubmitBtn ? null : _submitForm,
                      child: const Text('Salvar'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
