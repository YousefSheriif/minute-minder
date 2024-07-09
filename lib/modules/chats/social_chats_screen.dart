import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minute_minder/shared/social_cubit/cubit.dart';
import 'package:minute_minder/shared/social_cubit/states.dart';
import 'package:minute_minder/shared/styles/color.dart';
import 'package:minute_minder/shared/styles/iconBroken.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({Key? key}) : super(key: key);
  var chatController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialAppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children:const [
                Text('Chatbot Conversation',style: TextStyle(color: Colors.black),),
                SizedBox(width: 15.0,),
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
          body:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
              [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(12.0),
                        topEnd: Radius.circular(12.0),
                        topStart: Radius.circular(12.0),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
                    child: const Text(
                      'Hello minute minder',
                      style: TextStyle(color: Colors.white,fontSize: 17.0,),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      borderRadius:const BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(12.0),
                        topEnd: Radius.circular(12.0),
                        topStart: Radius.circular(12.0),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
                    child: const Text(
                      'Hello minute minder',
                      style: TextStyle(color: Colors.white,fontSize: 17.0,),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color:Colors.grey[500]!,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                  padding: const EdgeInsetsDirectional.only(start: 15.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children:
                    [
                      Expanded(
                        child: TextFormField(
                          controller: chatController,
                          validator: (val)
                          {
                            if (val!.isEmpty) {
                              return "can't put empty comment!";
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
                          onPressed: (){},
                          minWidth:1.0,
                          child: const Icon(IconBroken.Send,size: 18,color: Colors.white,),
                        ),
                      )
                      // TextFormField(
                      //   controller: chatController,
                      //   validator: (val)
                      //   {
                      //     if (val!.isEmpty) {
                      //       return "can't put empty comment!";
                      //     }
                      //     return null;
                      //   },
                      //   decoration: InputDecoration(
                      //     prefixIcon: IconButton(
                      //       onPressed: ()
                      //       {
                      //         // SocialCubit.get(context).commentPosts(SocialCubit.get(context).postsIds[index], commentController.text);
                      //       },
                      //       icon: const Icon(
                      //         Icons.arrow_circle_left_rounded,
                      //         size: 35.0,
                      //         color: defaultColor,
                      //       ),
                      //     ),
                      //     hintText: 'Start a Conversation',
                      //     hintStyle: Theme.of(context)
                      //         .textTheme
                      //         .bodyText1!
                      //         .copyWith(
                      //       fontSize: 16.0,
                      //       fontWeight: FontWeight.w400,
                      //     ),
                      //     border: OutlineInputBorder(
                      //       borderRadius:
                      //       BorderRadius.circular(30.0),
                      //     ),
                      //   ),
                      // )
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
