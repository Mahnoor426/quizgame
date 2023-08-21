import 'package:flutter/material.dart';
import 'package:quizproject/database.dart';
import 'package:quizproject/signin.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion(this.quizId);
  // const AddQuestion({Key? key}) : super(key: key);
  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

//////////
TextEditingController questionController = TextEditingController();
TextEditingController option1Controller = TextEditingController();
TextEditingController option2Controller = TextEditingController();
TextEditingController option3Controller = TextEditingController();
TextEditingController option4Controller = TextEditingController();

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  late String question, option1, option2, option3, option4;
  DatabaseService databaseService = new DatabaseService();

  void clearTextFields() {
    questionController.clear();
    option1Controller.clear();
    option2Controller.clear();
    option3Controller.clear();
    option4Controller.clear();
  }

  uploadQuestionData() async {
    Map<String, String> questionMap = {
      "question": question,
      "option1": option1,
      "option2": option2,
      "option3": option3,
      "option4": option4
    };
    await databaseService
        .addQuestionData(questionMap, widget.quizId)
        .then((value) {
      clearTextFields();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: appBar(context),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true, // by this u set the appbar center
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: "Question",
                ),
                onChanged: (val) {
                  question = val;
                },
                //to empty the field
                controller: questionController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Option1",
                ),
                onChanged: (val) {
                  option1 = val;
                },
                //empty the field
                controller: option1Controller,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Option2",
                ),
                onChanged: (val) {
                  option2 = val;
                },
                //empty the field
                controller: option2Controller,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Option3",
                ),
                onChanged: (val) {
                  option3 = val;
                },
                //empty the field
                controller: option3Controller,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Option4",
                ),
                onChanged: (val) {
                  option4 = val;
                },
                //empty the field
                controller: option4Controller,
              ),
              const SizedBox(
                height: 20,
              ),
              Spacer(),
              Row(
                children: [
                  Container(
                    width: 170,
                    child: RawMaterialButton(
                      fillColor: Colors.deepPurple,
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      uploadQuestionData();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      padding:
                      EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Add Question",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
