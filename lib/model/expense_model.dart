class ExpenseModel{
  String title;
  String description;
  String date;
  String time;
  String expenseField;
  String amount;

  ExpenseModel({required this.title,required this.description,required this.date,required this.time,required this.expenseField,required this.amount});

  factory ExpenseModel.fromMap(Map<String,dynamic>res){
    return ExpenseModel(
        title: res["title"],
        description: res["description"],
        date: res["date"],
        time: res["time"],
        expenseField:res["expenseField"],
        amount: res["amount"]
    );
  }

  Map<String,dynamic>toMap(){
    return {
      "title":title,
      "description":description,
      "date":date,
      "time":time,
      "expenseField":expenseField,
      "amount":amount
    };
  }
}