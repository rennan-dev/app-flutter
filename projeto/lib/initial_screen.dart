import 'package:alura/task.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {

  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text('Nanatsu no Taizai', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue, // Cor da sua escolha
        ),
        body: AnimatedOpacity(
          opacity: opacidade?1:0,
          duration: Duration(milliseconds: 1000),
          child: ListView(
            children: [
              Task('Diane', 3, 'https://s4.anilist.co/file/anilistcdn/character/large/b74653-XpMcsLVZBnkZ.jpg'),
              Task('King', 4, 'https://s4.anilist.co/file/anilistcdn/character/large/b83801-52RnDXQDZ1I7.png'),
              Task('Ban', 4, 'https://s4.anilist.co/file/anilistcdn/character/large/b77605-NrjhQwZwgJ3l.png'),
              Task('Meliodas', 5, 'https://s4.anilist.co/file/anilistcdn/character/large/b72921-XDHNd1wflN6P.png'),
              Task('Hawk', 1, 'https://s4.anilist.co/file/anilistcdn/character/large/n86683-ZXPoLZnKqNtx.png'),
              Task('Gilthunder', 2, 'https://s4.anilist.co/file/anilistcdn/character/large/b74285-qGwNsXKYRPcC.png'),
              Task('Elizabeth', 2, 'https://s4.anilist.co/file/anilistcdn/character/large/b72923-a6q29qhfSAM5.png'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          onPressed: () {
            setState(() {
              opacidade = !opacidade;
            });
          },
          child: Icon(Icons.remove_red_eye),
        ),
      ),
    );
  }
}