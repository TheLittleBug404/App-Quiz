import 'package:quiz_aplicacion/clases/question.dart';

class Quiz{
  String name;
  List<Question> question;
  int right = 0;

  Quiz({required this.name,required this.question});

  //metodo que regresa el porcentaje que tiene correctas
  double get percent =>(right / question.length)*100;
}