class Question{
  late String country;
  //ojo que sea generico id nombre descripcion
  String question = "Capital de ";
  late String answer;
  List<String> options = [];
  String selected = 'Saltada';//Skipped
  bool correct = false;
  //constructor donde conseguiremos la pregunta a travez de un objeto Json
  Question.fromJson(Map<String,dynamic> json)
    :country = json['country'],
    answer = json['capital'];

  //aca completaremos las opciones
  void adicionarOpciones(List<String> nuevasOpciones){
    question += country;
    options.add(answer);
    options.addAll(nuevasOpciones);
    //con shuffle mezclamos la lsita de opciones para que salgan el orden al azar
    options.shuffle();
  }
}