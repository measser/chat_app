import 'package:chat_app/model/message_model.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class BubleChat extends StatelessWidget {
  const BubleChat({
    super.key, required this.messageModel,
  });

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Text(messageModel.id,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
            const SizedBox(height: 5,),
            Text(
              messageModel.message!,
              style:const TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w500),
            ) ,
          ],
        ),
      ),
    );
  }
}



class BubleChatFried extends StatelessWidget {
  const BubleChatFried({
    super.key, required this.messageModel,
  });

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            )),
        child: Text(
          messageModel.message!,
          style:const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

