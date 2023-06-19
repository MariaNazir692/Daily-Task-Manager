class TaskModel{

  String? title;
  String? note;
  String? repeat;
  String? date;
  String? startTime;
  String? endTime;
  int? id;
  int? isCompleted;
  int? color;
  int? remind;
   TaskModel({
    this.title,
     this.repeat,
     this.id,
     this.color,
     this.date,
     this.endTime,
     this.isCompleted,
     this.note,
     this.remind,
     this.startTime
});

   //to retrieve data from database
   TaskModel.fromJson(Map<String,dynamic> json){
     id=json['id'];
     title=json['title'];
     note=json['note'];
     isCompleted=json['isCompleted'];
     date=json['date'];
     startTime=json['startTime'];
     endTime=json['endTime'];
     color=json['color'];
     remind=json['remind'];
     repeat=json['repeat'].toString();
   }

   //to store data in database this will convert our data in JSON format
   Map<String, dynamic> toJson(){
     final Map<String, dynamic> data=new Map<String,dynamic>();
    data['id']=this.id;
    data['title']=this.title;
    data['note']=this.note;
    data['isCompleted']=this.isCompleted;
    data['date']=this.date;
    data['startTime']=this.startTime;
    data['endTime']=this.endTime;
    data['color']=this.color;
    data['remind']=this.remind;
    data['repeat']=this.repeat;
    return data;
   }
}