import 'package:entregar/components/personagem.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';

class PersonagemDao {
  static const String tableSQL = 'CREATE TABLE $_tableName('
      '$_name TEXT,'
      '$_raca TEXT,'
      '$_forca INTEGER,'
      '$_imagem TEXT'
      ');';

  static const String _tableName = 'characterTable';
  static const String _name = 'name';
  static const String _raca = 'raca';
  static const String _forca = 'forca';
  static const String _imagem = 'image';

  save(PersonagemCard personagem) async {
    print('Acessando o cadastro de personagem');
    final Database bancoDeDados = await getDatabase();
    var personagensExists = await find(personagem.nome);
    Map<String, dynamic> personagemMap = toMap(personagem);
    if(personagensExists.isEmpty) {
      print('O personagem nao existia');
      return await bancoDeDados..insert(_tableName, personagemMap);
    }else {
      print('O personagem já existia');
      return await bancoDeDados.update(_tableName, personagemMap, where: '$_name = ?', whereArgs: [personagem.nome]);
    }
  }

  Future<List<PersonagemCard>> find(String personagemName) async {
    print('Acessando o find(String personagemName');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(_tableName, where: '$_name = ?', whereArgs: [personagemName]);
    print('personagem encontrado: ${toList(result)}');
    return toList(result);
  }

  Future<List<PersonagemCard>> findAll() async {
    print('\n\nEstamos acessando o findAll()\n\n');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(_tableName);
    print('Dados da table: $result');
    return toList(result);
  }

  List<PersonagemCard> toList(List<Map<String, dynamic>> mapPersonagens) {
    print('Acessando toList');
    List<PersonagemCard> personagensList = [];
    for(Map<String,dynamic> linha in mapPersonagens) {
      final PersonagemCard personagem = PersonagemCard(linha[_name], linha[_forca], linha[_raca], linha[_imagem]);
      personagensList.add(personagem);
    }
    return personagensList;
  }

  delete(String nomePersonagem) async {
    print('Deletando personagem');
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(_tableName, where: '$_name = ?', whereArgs: [nomePersonagem]);
  }

  Map<String,dynamic> toMap(PersonagemCard personagem) {
    print('Acesando o toMap');
    final Map<String,dynamic> mapaDePersonagens = {};
    mapaDePersonagens[_name] = personagem.nome;
    mapaDePersonagens[_forca] = personagem.forca;
    mapaDePersonagens[_raca] = personagem.raca;
    mapaDePersonagens[_imagem] = personagem.image;
    return mapaDePersonagens;
  }
}