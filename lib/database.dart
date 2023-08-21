import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map quizData, String quizId) async {
    Map<String, dynamic> convertedData = quizData.cast<String, dynamic>();
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .set(convertedData)
        .catchError((e) {
      e.toString();
    });
  }

  Future<void> addQuestionData(Map questionData, String quizId) async {
    Map<String, dynamic> convertedData = questionData.cast<String, dynamic>();
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .add(convertedData)
        .catchError((e) {
      print(e);
    });
  }

  //get quiz bixes
  getQuizData() async
  {
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  // Getting Q/A //
  getQuizzData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .get();
  }
}
