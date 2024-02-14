import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_aplicacion/clases/question.dart';
import 'dart:convert';

import 'package:quiz_aplicacion/clases/quiz.dart';
import 'package:quiz_aplicacion/pages/results_pages.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  int totalQuestions = 5;
  int totalOptions = 4;
  //esta variable sera para ver en que variable estamos
  int questionIndex = 0;
  //esta variable sera para poder controlar la barra de progreso
  int progressIndex = 0;

  Quiz quiz = Quiz(name: 'Quiz de capitales', question: []);

  Future<void> readJson() async{
    //cargamos el archivo Json en un String
    final String response = await rootBundle.loadString('assets/paises.json');
    //decodificamos en una lista el archivo JSON
    final List<dynamic> data = await json.decode(response);
    List<int>optionsList = List<int>.generate(data.length,(i)=>i);
    //en esta lista agregaremos lo indices de la lista para que no se repitan las preguntas
    List<int>questionsAdded =[];

    while(true){
      //son shuffle la lista se volvera aleatoria
      optionsList.shuffle();
      int answer = optionsList[0];
      if(questionsAdded.contains(answer)) continue;
      questionsAdded.add(answer);
      List<String>otherOptions = [];
      //por cada opcion dentro de la lsita de opciones
      for(var options in optionsList.sublist(1,totalOptions)){
        otherOptions.add(data[options]['capital']);
      }
      Question question = Question.fromJson(data[answer]);
      question.adicionarOpciones(otherOptions);
      quiz.question.add(question);

      if(quiz.question.length >= totalQuestions)break;
    }
    setState(() {
      
    });
  }
  @override
  void initState(){
    super.initState();
    //funcion que cargue nuestro archivo JSON y creara un Quiz con estos datos
    readJson();
  }
  //metodo para seleccionar la opcion de las respuestas
  void _optionSelected(String selected){
    quiz.question[questionIndex].selected = selected;
    if(selected == quiz.question[questionIndex].answer){
      quiz.question[questionIndex].correct = true;
      quiz.right +=1;
    }
    progressIndex +=1;
    if(questionIndex < (totalQuestions-1)){
      questionIndex +=1;
    }else{
      showDialog(
        barrierDismissible: false, // con este no se ira el alert al hacer clic en cualquier otra parte
        context: context, 
        builder: (BuildContext context) => _buildResultDialog(context)
      );
    }
    setState(() {
      
    });
  }
  //este metodo regresara un widget que nos servira para cuando tengamos que terminar el juego
  Widget _buildResultDialog(BuildContext context){
    return AlertDialog(
      title: Text(
        'Resultados',
        style: Theme.of(context).textTheme.displayLarge
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
      content: Column(
        mainAxisSize: MainAxisSize.min, //toma el menos espacio que pueda
        crossAxisAlignment: CrossAxisAlignment.start, //para que todo este alineado hacia la izquierda
        children: [
          Text(
            "Preguntas totales: $totalQuestions",
            style: Theme.of(context).textTheme.bodyLarge
          ),
          Text(
            "Preguntas corrrectas: ${quiz.right}",
            style: Theme.of(context).textTheme.bodyLarge
          ),
          Text(
            "Preguntas incorrectas: ${totalQuestions - quiz.right}",
            style: Theme.of(context).textTheme.bodyLarge
          ),
          Text(
            "Porcentaje: ${quiz.percent}%",
            style: Theme.of(context).textTheme.bodyLarge
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
              builder: (context) => ResultsPage(quiz: quiz)
              ) 
            );
          },
          child: Text(
            "Ver Respuestas",
            style: Theme.of(context).textTheme.bodyLarge
          ),
        ),  
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        title: Text(
          quiz.name,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 30,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic
          ),
        ),
        backgroundColor: Colors.indigo,
        elevation: 20,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(//utilizamos el contenedor para darle margen
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: ClipRRect(//para darle las orillas curveadas
              borderRadius: BorderRadius.circular(15),
              child: LinearProgressIndicator(
                color: Colors.amber.shade900,
                value: progressIndex/totalQuestions,
                minHeight: 20,
              )
            )
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 450),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
              child: quiz.question.isNotEmpty ? Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:[
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: Text(
                        quiz.question[questionIndex].question,
                        style: Theme.of(context).textTheme.displayLarge
                      ),
                    ),
                    Flexible(
                      child: ListView.builder(
                        itemCount: totalOptions,//esto definira cuantas preguntas podemos colocarle si no le colocamos la preguntas seran infinitas
                        itemBuilder: (_,index){
                          return Container(
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.indigo.shade100,
                                width: 3
                              ),
                              borderRadius: BorderRadius.circular(18)
                            ),
                            child: ListTile(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                              leading: Text(
                                '${index+1}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              title: Text(
                                quiz.question[questionIndex].options[index],
                                style: Theme.of(context).textTheme.bodyLarge
                              ),
                              onTap: (){
                                _optionSelected(quiz.question[questionIndex].options[index],);
                              },
                            ),
                          );
                        }
                      ),
                    ),
                  ]
                ),
              ): const CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            ),
          ),
          TextButton(
            onPressed: (){
              _optionSelected('Skipped');
            }, 
            child: Text(
              'Saltar',
              style: Theme.of(context).textTheme.bodyLarge
            )
          ),
        ],
      )
    );
  }
}