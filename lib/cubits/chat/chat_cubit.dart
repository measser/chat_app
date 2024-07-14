import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../model/message_model.dart';
import '../../widgets/constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessages);


  void sendMessage({required String message, required String email}) {
    try {
      messages.add(
        {
          'message': message,
          'createAt': DateTime.now(),
          'id': email,
        },);
    } catch (e) {}
  }

  List<MessageModel> messageList=[];
  void getMessage(){
    messages.orderBy('createAt', descending: true).snapshots().listen((event){
      messageList.clear();
      for(var doc in event.docs){
        messageList.add(MessageModel.fromJson(doc));
      }
      emit(ChatSuccess(messages: messageList));
    });
  }


}