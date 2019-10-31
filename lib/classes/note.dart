// This is created seprately so that users can reuse the class
// It is a good practice to store widgets and classes in seprate pages
class Note{
  String title;
  String text;

  Note(this.title,this.text);

  Note.fromJson(Map<String, dynamic>json){
    title=json['title'];
    text = json['text'];
  }

}