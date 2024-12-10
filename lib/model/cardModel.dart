
class Cards{
  int? id;
  late String question;
  late String answer;


  Cards({
   this.id,
    required this.question,
    required this.answer,

});

  Map<String,dynamic> toMap(){
    return{
      'id' : id,
      'question' : question,
      'answer' : answer,
    };
  }

  factory Cards.fromMap(Map<String,dynamic> map){
    return Cards(
      id : map['id'],
      question: map['question'],
      answer: map['answer'],

    );
  }
}