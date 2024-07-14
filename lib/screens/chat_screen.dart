import 'package:chat_app/cubits/chat/chat_cubit.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:chat_app/widgets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key,});

  CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessages);
  final scrollController = ScrollController();
  TextEditingController controller = TextEditingController();
  static String id = 'ChatScreen';

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    return Scaffold(
//backgroundColor: kPrimaryColor.withOpacity(0.5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 60,
            ),
            const Text(
              'Chat',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {},
              builder: (context, state) {
                var message = BlocProvider
                    .of<ChatCubit>(context)
                    .messageList;
                return ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  itemCount: message.length,
                  itemBuilder: (context, index) {
                    return message[index].id == email
                        ? BubleChatFried(messageModel: message[index])
                        : BubleChat(
                      messageModel: message[index],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
              SizedBox(
              width: 350,
              child: TextField(
                controller: controller,
                onSubmitted: (data) {
                  BlocProvider.of<ChatCubit>(context).sendMessage(
                      message: data, email: email);
                  scrollController.animateTo(0,
                      duration: const Duration(microseconds: 1),
                      curve: Curves.fastOutSlowIn);
                  controller.clear();
                  // scrollController.jumpTo(scrollController.position.maxScrollExtent,
                  // );
                },
                decoration: const InputDecoration(

                  hintText: 'Message',
                  hintStyle: TextStyle(color: kPrimaryColor),
                  //suffixIcon: Icon(Icons.send),
                  //suffixIconColor: kPrimaryColor,
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(16))),
                ),
              ),
            ),
            const SizedBox(width: 10,),
             CircleAvatar(
              radius: 25,
              backgroundColor: kPrimaryColor,
              child: IconButton(icon: Icon(Icons.send), color: Colors.white,onPressed: (){
                BlocProvider.of<ChatCubit>(context).sendMessage(message: controller.text, email: email);
                controller.clear();
              },),
            ),
        ],
      ),
    ),]
    ,
    )
    ,
    );
  }
}
// else {
// return const Scaffold(
// body: Center(
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Text('Loading...'),
// SizedBox(
// height: 10,
// ),
// CircularProgressIndicator(),
// ],
// ),
// ),
// );
// }