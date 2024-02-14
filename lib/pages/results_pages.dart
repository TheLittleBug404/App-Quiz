import 'package:flutter/material.dart';
import 'package:quiz_aplicacion/clases/quiz.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key,required this.quiz});
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          quiz.name,
          style: Theme.of(context).textTheme.displayMedium
          ),
        elevation: 20,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ), 
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 3,right: 3,top: 2,bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.indigo.shade50,
                  width: 2
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                  Text(
                    "Preguntas ${quiz.question.length}",
                    style: Theme.of(context).textTheme.bodyLarge
                  ),
                  Text(
                    'Correctas ${quiz.percent}%',
                    style: Theme.of(context).textTheme.bodyLarge
                  )
                ]
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true, //ocupa la menor catidad de nuestra pantalla
                itemCount: quiz.question.length,  //cantidad de preguntas que colocaremos
                itemBuilder: ( _ ,index){//cuando no utilizamos el context colocamos el guion bajo
                  return Card(
                    //si se contesto la pregunta correctamente le colocaremos un verde si no un rojo
                    color: quiz.question[index].correct ? Colors.green.shade200 : Colors.red.shade200,
                    child: ListTile(
                      //leading sera el icono que nos dira si estubo bien o mal
                      leading: quiz.question[index].correct 
                        ? Icon(Icons.check,color: Colors.green.shade900) 
                        : Icon(Icons.close,color: Colors.red.shade900),
                      title: Text(quiz.question[index].question),//aca me aparecera la pregunta
                      subtitle: Text(quiz.question[index].selected),//este nos muestra el que se seleccionomos
                      trailing: Text(quiz.question[index].answer)//en aca me saldra la respuesta correcta
                    ),
                  );
                }
              )
            )
          ],
        )
      )
    );
  }
}