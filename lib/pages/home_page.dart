import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body:  Center(
        child:Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 50),
              child:Icon(
                Icons.wb_sunny_outlined,
                size: 100,
                color: Colors.purple.shade100
              ),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              color: Colors.indigo.shade300,
              child:ListView(
                shrinkWrap: true,//solamente tomara el espacio que necesiten sus hijos
                padding: const EdgeInsets.all(10),
                children: [
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(top:10,bottom: 25),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.indigo.shade200,
                          Colors.purple.shade300
                        ]
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text("QUIZ APP",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/quiz-page');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.indigo.shade100,
                      elevation: 4,
                      side: const BorderSide(width: 1)
                    ),
                    child: const Text("Iniciar Quiz")
                  ),
                  OutlinedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/review-page');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.indigo.shade100,
                      elevation: 5,
                      side: const BorderSide(width: 1)
                    ),
                    child: const Text("Repasar Quiz")
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}