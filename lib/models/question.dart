class Question{
  String question;
  String result;
  Question({
    this.question="",
    this.result=""
  });

  factory Question.fromJSON(Map<String,dynamic> response)=>Question(
    question: response["question"],
    result: response["result"]
  );
}