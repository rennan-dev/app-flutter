import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tarefas'),
        ),
        body: ListView(
          children: [
            Task('Aprender Flutter'),
            Task('A arte da guerra'),
            Task('O declínio de um homem'),
            Task('Aprender Java'),
            Task('Aprender Dart'),
            Task('Aprender C++'),
            Task('Aprender Node.Js'),
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){print('botao precionado');}),
      ),
    );
  }
}



class Task extends StatelessWidget {
  final String titulo;
  const Task(this.titulo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Stack(
          children: [
            Container(color: Colors.blue, height: 140,),
            Container(color: Colors.white, height: 100, child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(color: Colors.black26, height: 100, width: 72,),
                Container(
                    width: 200,
                    child: Text(titulo, style: TextStyle(fontSize: 20), overflow: TextOverflow.ellipsis,)),
                ElevatedButton(onPressed: (){}, child: Icon(Icons.arrow_drop_up))
              ],
            ),)
          ],
        ),
      ),
    );
  }
}
