import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minute_minder/shared/social_cubit/cubit.dart';
import 'package:minute_minder/shared/social_cubit/states.dart';
import 'package:minute_minder/shared/styles/color.dart';
import 'package:minute_minder/shared/styles/iconBroken.dart';


class ChatsScreenn extends StatelessWidget {
  ChatsScreenn({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_)
        {
          if (!SocialCubit.get(context).isWelcomeMessageSent)
          {
            SocialCubit.get(context).sendWelcomeMessage(context);
          }
          if (SocialCubit.get(context).scrollController.hasClients)
          {
            SocialCubit.get(context).scrollController.jumpTo(SocialCubit.get(context).scrollController.position.maxScrollExtent);
          }
        });
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: const [
                Text(
                  'Chatbot Conversation',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 15.0,
                ),
                CircleAvatar(
                  radius: 22.0,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: AssetImage('assets/images/b6.png'),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: AnimatedList(
                    key: SocialCubit.get(context).listKey,
                    controller: SocialCubit.get(context).scrollController,
                    initialItemCount: SocialCubit.get(context).messages.length,
                    itemBuilder: (context, index, animation) {
                      var message = SocialCubit.get(context).messages[index];
                      return SizeTransition(
                        sizeFactor: animation,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              mainAxisAlignment: message.isUserMessage
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              children: [

                                Expanded(
                                  child: Align(
                                    alignment: message.isUserMessage
                                        ? AlignmentDirectional.centerStart
                                        : AlignmentDirectional.centerEnd,
                                    child: Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: message.isUserMessage
                                              ? defaultColor
                                              : Colors.grey[800],
                                          borderRadius: message.isUserMessage
                                              ? const BorderRadiusDirectional.only(
                                            topEnd: Radius.circular(12.0),
                                            topStart: Radius.circular(12.0),
                                            bottomEnd:  Radius.circular(12.0),
                                          )
                                              : const BorderRadiusDirectional.only(
                                            // topEnd: Radius.circular(12.0),
                                            topStart: Radius.circular(12.0),
                                            bottomStart: Radius.circular(12.0),
                                            bottomEnd:  Radius.circular(12.0),
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 6.0),
                                        child: Expanded(
                                          child: Text(
                                            message.text,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (!message.isUserMessage)
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.end,

                                    children: const [
                                      SizedBox(width: 8.0,),
                                      CircleAvatar(
                                        radius: 22.0,
                                        backgroundColor: Colors.black,
                                        child: CircleAvatar(
                                          radius: 20.0,
                                          backgroundImage: AssetImage('assets/images/b6.png'),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[500]!,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsetsDirectional.only(start: 15.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: SocialCubit.get(context).chatController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "can't put empty message!";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'write your message here ...',
                          ),
                        ),
                      ),
                      Container(
                        height: 49.0,
                        width: 50.0,
                        color: defaultColor,
                        child: MaterialButton(
                          onPressed: () {
                            SocialCubit.get(context).sendMessageAndReceiveResponse(context);
                          },
                          minWidth: 1.0,
                          child: const Icon(
                            IconBroken.Send,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}



