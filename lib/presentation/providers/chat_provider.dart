import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messages = [];

  Future<void> makeBotReply() async{
    final botMessage = await getYesNoAnswer.getAnswer();
    messages.add(botMessage);
    notifyListeners();
    await moveScrollToBottom();
  }

  Future<void> sendMessage(String text) async{
    //Future<void> y async{} dentro de poco
    if (text.isEmpty) return;
    final newMessage = Message(text: text, isMine: true);
    messages.add(newMessage);

    

    notifyListeners();

    await moveScrollToBottom();
    if(text.endsWith("?")){
      await makeBotReply();
    }
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
