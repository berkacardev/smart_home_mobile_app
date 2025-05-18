import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home_mobile_app/feature/view/home/home_view.dart';
import 'package:smart_home_mobile_app/product/initializer/starter.dart';

Future<void> main() async {
  await StarterInitializer.initialize();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akıllı Evim',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
