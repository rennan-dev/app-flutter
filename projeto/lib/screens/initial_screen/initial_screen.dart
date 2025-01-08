import 'package:entregar/screens/initial_screen/widgets/personagem.dart';
import 'package:entregar/services/character_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../form_screen/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final CharacterService characterService = CharacterService();

  Future<List<Personagem>> _getAllCharacters() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("accessToken");
    final email = prefs.getString("email");
    final id = prefs.getInt("id");

    if (token != null && email != null && id != null) {
      return await characterService.getAllCharacters(
        id: id.toString(),
        token: token,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
      return [];
    }
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
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao carregar personagens: ${snapshot.error}'),
                  );
                }

                if (snapshot.hasData && snapshot.data != null) {
                  final personagens = snapshot.data!;
                  if (personagens.isNotEmpty) {
                    return ListView.builder(
                      itemCount: personagens.length,
                      itemBuilder: (context, index) {
                        final personagem = personagens[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormScreen(
                                  formContext: context,
                                  personagem: personagem,
                                  isEditing: true,
                                ),
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
                          child: Personagem(
                            personagem.nome,
                            personagem.forca,
                            personagem.raca,
                            personagem.image,
                            id: personagem.id,
                            onRefresh: () => setState(() {}), // Atualiza ao remover personagem
                          ),
                        );
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
              builder: (contextNew) => FormScreen(formContext: context, isEditing: false,),
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
