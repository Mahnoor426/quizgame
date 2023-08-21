import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quizproject/addquestion.dart';
import 'package:quizproject/database.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  late String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  String generateRandomAlphaNumeric(int length) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) {
      final codeUnit = random.nextInt(36) + 55;
      return codeUnit < 91 ? codeUnit : codeUnit + 39;
    });
    final randomString = base64Url.encode(values);
    return randomString.substring(0, length);
  }

  createQuizOnline() async {
    String quizId = generateRandomAlphaNumeric(16);
    Map<String, String> quizMap = {
      "quizId": quizId,
      "quizImageUrl": quizImageUrl,
      "quizTitle": quizTitle,
      "quizDesc": quizDescription
      };
    await databaseService.addQuizData(quizMap, quizId).then((value) {
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AddQuestion(quizId)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      //by this we added animation
      child: TweenAnimationBuilder(
        tween: Tween(begin: 0.0,end: 1.0),
        duration: Duration(milliseconds: 1500),
        builder: (context,value,child){
          return ShaderMask(
            blendMode: BlendMode.modulate,
            shaderCallback: (rect){
            return RadialGradient(
              radius: value * 5,
              colors: [Colors.white,Colors.white,Colors.transparent,Colors.transparent],
              stops: [0.0,0.55,0.6,1.0],
              center: FractionalOffset(0.95,0.90),
            ).createShader(rect);

          },child: child,);
        },
        //till here animation ended
        child: Scaffold(
          appBar: AppBar(
            title: appBar(context),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true, // by this u set the appbar center
          ),
          body: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "Quiz Image Url",
                    ),
                    onChanged: (val) {
                      quizImageUrl = val;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "Quiz Title",
                    ),
                    onChanged: (val) {
                      quizTitle = val;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "Quiz Description",
                    ),
                    onChanged: (val) {
                      quizDescription = val;
                    },
                  ),
                  Spacer(),
                  Container(
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: Colors.deepPurple,
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      onPressed: () {
                        createQuizOnline();
                      },
                      child: Text(
                        "Create Quiz",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: const <TextSpan>[
        TextSpan(
            text: 'Ace',
            style:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.purple)),
        TextSpan(
            text: 'Recruit',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        // TextSpan(
        //     text: 'Application',
        //     style:
        //         TextStyle(fontWeight: FontWeight.w500, color: Colors.purple)),
      ],
    ),
  );
}
