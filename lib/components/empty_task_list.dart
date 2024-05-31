import 'package:flutter/material.dart';
import 'package:ryc_desafio_do_modulo_basico/components/app_button.dart';
import 'package:ryc_desafio_do_modulo_basico/utils/app_routes.dart';

class EmptyTaskList extends StatelessWidget {
  const EmptyTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '404',
            style: TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          const Text(
            'Nenhuma tarefa encontrada!',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          AppElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.register);
            },
            child: const Text('Criar tarefa'),
          )
        ],
      ),
    );
  }
}
