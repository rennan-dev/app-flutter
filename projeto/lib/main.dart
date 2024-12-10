import 'package:entregar/data/personagem_provider.dart';
import 'package:entregar/screens/initial_screen.dart';
import 'package:entregar/services/character_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());

  CharacterService service = CharacterService();
  service.register("Olá Mundo novamente");
  service.getCharacters();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AluraQuest',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PersonagemProvider(child: const InitialScreen(),),
    );
  }
}



