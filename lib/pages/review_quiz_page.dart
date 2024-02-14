import 'package:flutter/material.dart';
//cargamos el archivo JSON
// nos sirve para poder convertir al archivo JSON
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quiz_aplicacion/clases/question.dart';
import 'package:quiz_aplicacion/clases/quiz.dart';

class ReviewQuizPage extends StatefulWidget {
  const ReviewQuizPage({super.key});

  @override
  State<ReviewQuizPage> createState() => _ReviewQuizPageState();
}

class _ReviewQuizPageState extends State<ReviewQuizPage> {

  Quiz quiz = Quiz(name:'Quiz de capitales',question: []);
  Future<void> readJson() async{
    final String response = await rootBundle.loadString('assets/paises.json');
    final List<dynamic> data = await json.decode(response);
    for(var item in data){
      Question pregunta = Question.fromJson(item);
      pregunta.question += pregunta.country;
      quiz.question.add(pregunta);
    }
    setState(() {
      
    });
  }
  @override
  void initState(){
    super.initState();
    readJson();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 30,
      ),
      body: quiz.question.isNotEmpty ? Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.indigo.shade50,
                width: 2
              )
            ),
            child: Center(
              child: Text(
                'Preguntas ${quiz.question.length}',
                style: Theme.of(context).textTheme.displayLarge
              ),
            )
          ),
          Expanded(
            child: ListView.builder(
              itemCount: quiz.question.length,
              itemBuilder: (_, index){
                return Card(
                  color: Theme.of(context).primaryColorLight,
                  child: ListTile(
                    leading: Text('${index+1}'),
                    title: Text(quiz.question[index].question),
                    trailing: Text(quiz.question[index].answer),
                  )
                );
              }
            )
          ),
        ]
      ): const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      )
    );
  }
}