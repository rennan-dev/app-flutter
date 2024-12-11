

import 'package:entregar/components/personagem.dart';
import 'package:entregar/data/personagem_dao.dart';
import 'package:entregar/screens/form_screen.dart';
import 'package:entregar/services/character_service.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  CharacterService service = CharacterService();
  PersonagemDao personagemDao = PersonagemDao();

  Future<List<Personagem>> _getAllCharacters() async {
    // Obtenha os personagens do banco de dados
    List<Personagem> personagensBanco = await personagemDao.findAll();
    // Obtenha os personagens do serviço JSON
    List<Personagem> personagensJson = await service.getAllCharacters();

    // Combine os dois conjuntos de personagens, evitando duplicatas
    final nomesBanco = personagensBanco.map((p) => p.nome).toSet();
    for (var personagem in personagensJson) {
      if (!nomesBanco.contains(personagem.nome)) {
        personagensBanco.add(personagem);
        await personagemDao.save(personagem); // Salve no banco se vier do JSON
      }
    }
    return personagensBanco;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Personagens'),
        actions: [
          IconButton(
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.refresh),
          ),
        ],
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Personagem>>(
          future: _getAllCharacters(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text('Carregando...'),
                    ],
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasData && snapshot.data != null) {
                  final personagens = snapshot.data!;
                  if (personagens.isNotEmpty) {
                    return ListView.builder(
                      itemCount: personagens.length,
                      itemBuilder: (context, index) {
                        final personagem = personagens[index];
                        return personagem; // Exibe o card
                      },
                    );
                  } else {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, size: 128),
                          Text(
                            'Não há nenhum personagem.',
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: Text('Erro ao carregar personagens.'),
                  );
                }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(formContext: context),
            ),
          ).then((value) {
            if (value != null && value is String && value.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(value),
                  backgroundColor: value.contains('sucesso')
                      ? Colors.green
                      : Colors.red,
                ),
              );
            }
            setState(() {}); // Atualiza a lista de personagens
          });
        },
        backgroundColor: const Color(0xFF05A52F),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
