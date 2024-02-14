import 'package:flutter/material.dart';
import 'package:quiz_aplicacion/pages/home_page.dart';
import 'package:quiz_aplicacion/pages/quiz_page.dart';
import 'package:quiz_aplicacion/pages/review_quiz_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.indigo,
          seedColor: Colors.indigoAccent,
          secondary:Colors.indigoAccent,
          
        ),
        primaryColor: Colors.indigo,
        secondaryHeaderColor: Colors.indigoAccent,
        textTheme: TextTheme(
          displayLarge: TextStyle(//este es el headline1
            color: Colors.indigo.shade900,
            fontSize: 30,
            fontWeight: FontWeight.w500,
            shadows: [
              Shadow(//este le dara sombra a los textos que esten con displayLarge
                color: Colors.purple.shade900.withOpacity(.3),
                offset: const Offset(3, 3),//este es para mover la sombra abajo y a un costadp
                blurRadius: 5
              )
            ],
          ),
          displayMedium: TextStyle(//este es el headline 2
            color: Colors.purple.shade50,
            fontSize: 20
          ),
          bodyLarge: TextStyle(//este es el bodyText1
            color: Colors.purple.shade50,
            fontSize: 18
          ),
        ),
        cardTheme: CardTheme(
          elevation: 10,
          color: Colors.white38,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18)
          )
        ),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        '/': (BuildContext context) => const HomePage(),
        '/quiz-page':(context) => const QuizPage(),
        '/review-page':(context) => const ReviewQuizPage()
      },
    );
  }
}

