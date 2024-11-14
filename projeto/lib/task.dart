import 'package:flutter/material.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String titulo;
  final int difficulty;
  final String foto;

  const Task(this.titulo, this.difficulty, this.foto, {super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int nivel = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
                        child: Image.network(
                          widget.foto,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 200,
                            child: Text(widget.titulo, style: TextStyle(fontSize: 20), overflow: TextOverflow.ellipsis,)),
                        Difficulty(dificuldadeLevel: widget.difficulty),
                      ],
                    ),
                    Container(
                      height: 65,
                      width: 65,
                      child: ElevatedButton(onPressed: () {

                        setState(() {
                          nivel++;
                        });
                      },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          child: Column(
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
                      child: Container(
                        child:
                        LinearProgressIndicator(
                          color: Colors.white,
                          value: widget.difficulty>0? (nivel/widget.difficulty)/10 : 1,
                        ),
                        width: 200,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('Nível: ${nivel}', style: TextStyle(fontSize: 18, color: Colors.white),),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}