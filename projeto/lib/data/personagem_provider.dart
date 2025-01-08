import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/initial_screen/widgets/personagem.dart';

class PersonagemProvider extends InheritedWidget {
  PersonagemProvider({
    super.key,
    required super.child,
  });

  final List<Personagem> personagemList = [];

  void newPersonagem(String nome, String raca, int forca, String urlImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt("id");
    personagemList.add(Personagem(nome, forca, raca, urlImage, userId!));
  }

  static PersonagemProvider of(BuildContext context) {
    final PersonagemProvider? result =
    context.dependOnInheritedWidgetOfExactType<PersonagemProvider>();
    assert(result != null, 'No PersonagemProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(PersonagemProvider oldWidget) {
    return oldWidget.personagemList.length != personagemList.length;
  }
}