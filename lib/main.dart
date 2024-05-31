import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryc_desafio_do_modulo_basico/providers/task_list_provider.dart';
import 'package:ryc_desafio_do_modulo_basico/providers/player_stats_provider.dart';
import 'package:ryc_desafio_do_modulo_basico/utils/app_routes.dart';
import 'package:ryc_desafio_do_modulo_basico/screens/register_screen.dart';
import 'package:ryc_desafio_do_modulo_basico/screens/main_screen.dart';
import 'package:ryc_desafio_do_modulo_basico/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskListProvider()),
        ChangeNotifierProvider(create: (_) => PlayerStatsProvider()),
      ],
      child: MaterialApp(
        title: 'Task Game',
        theme: lightTheme,
        home: const MainScreen(),
        routes: {
          AppRoutes.register: (context) => const RegisterScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
