import 'package:alura/components/task.dart';
import 'package:alura/data/task_inherited.dart';
import 'package:alura/screens/form_screen.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {

  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: const Text('Nanatsu no Taizai', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue, // Cor da sua escolha
        ),
        body: ListView(
          children: TaskInherited.of(context).taskList,
          padding: EdgeInsets.only(top: 8, bottom: 70),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (contextNew) => FormScreen(taskContext: context,)));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}