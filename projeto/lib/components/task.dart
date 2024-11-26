import 'package:flutter/material.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String titulo;
  final int difficulty;
  final String foto;

  Task(this.titulo, this.difficulty, this.foto, {super.key});

  int nivel = 0;
  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

  bool assetOrNetwork() {
    if(widget.foto.contains('http')) {
      return false;
    }else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.blue,
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100, child:

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.black26,
                    ),
                    height: 100, width: 72,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: assetOrNetwork()?
                            Image.asset(widget.foto, fit: BoxFit.cover,)
                            :
                            Image.network(widget.foto, fit: BoxFit.cover,),

                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 200,
                          child: Text(widget.titulo, style: const TextStyle(fontSize: 20), overflow: TextOverflow.ellipsis,)),
                      Difficulty(dificuldadeLevel: widget.difficulty),
                    ],
                  ),
                  SizedBox(
                    height: 65,
                    width: 65,
                    child: ElevatedButton(onPressed: () {

                      setState(() {
                        widget.nivel++;
                      });
                    },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.arrow_drop_up, color: Colors.white,),
                            Text("UP", style: TextStyle(fontSize:11, color: Colors.white),),
                          ],
                        )),
                  )
                ],
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 200,
                      child:
                      LinearProgressIndicator(
                        color: Colors.white,
                        value: widget.difficulty>0? (widget.nivel/widget.difficulty)/10 : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Nível: ${widget.nivel}', style: const TextStyle(fontSize: 18, color: Colors.white),),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}