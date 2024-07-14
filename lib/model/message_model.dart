import '../widgets/constants.dart';

class MessageModel{
   final String? message;
   final String id;

  MessageModel(this.message, this.id);
  factory MessageModel.fromJson(data){
    return MessageModel(data[kShow],data['id']);
  }
}