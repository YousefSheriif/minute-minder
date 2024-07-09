import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minute_minder/shared/components/components.dart';
import 'package:minute_minder/shared/components/constant.dart';
import 'package:minute_minder/shared/social_cubit/cubit.dart';
import 'package:minute_minder/shared/social_cubit/states.dart';
import 'package:minute_minder/shared/styles/color.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final queryController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getUserName();
    return BlocConsumer<SocialCubit,SocialAppStates>(
      listener: (BuildContext context, state) {
        if (state is MinuteSendQuerySuccessState)
        {
          // Update response message when message is sent successfully
          queryController.clear();
        }
      },
      builder: (BuildContext context, Object? state)
      {

        String responseMessage = '';
        if (state is MinuteSendQuerySuccessState)
        {
          responseMessage = state.messageModel;
        }
        else if (state is MinuteSendQueryErrorState)
        {
          responseMessage = state.error;
        }
        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 10.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 10.0,),
                    SizedBox(
                      height: 120.0,
                      child: Row(
                        children:  [
                          Column(
                            children: const [
                              CircleAvatar(
                                radius: 37.0,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  radius: 35.0,
                                  backgroundImage: AssetImage('assets/images/pic1.jpg'),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: const [
                          //     Icon(Icons.search_rounded,color: Colors.black,size: 30,),
                          //     Text(
                          //       'Minute Minder',//SHOPPING
                          //       style:TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 20.0,
                          //         color: defaultColor,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          const Image(
                            image: AssetImage('assets/images/mmLogo.png',),
                            height: 120.0,
                            width: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    Row(
                      children:
                      [
                        const Text('Welcome ',style: TextStyle(color: Colors.black,fontSize: 22.0,fontWeight: FontWeight.bold),),
                       currentUserName!=null?
                          Text('$currentUserName',style: const TextStyle(color: defaultColor,fontSize: 22.0,fontWeight: FontWeight.bold),):
                       const Text('User',style: TextStyle(color: defaultColor,fontSize: 22.0,fontWeight: FontWeight.bold),),
                        const SizedBox(width: 8.0,),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                          child: Image.asset(
                            'assets/images/hand.png',
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0,),
                    SocialCubit.get(context).videoPlayerController!=null?
                      Column(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Theme.of(context).textTheme.bodyText2!.color,
                          elevation: 8.0,
                          margin: const EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              [
                                if (SocialCubit.get(context).video!=null)
                                  SocialCubit.get(context).videoPlayerController!.value.isInitialized?
                                  Column(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: SocialCubit.get(context).videoPlayerController!.value.aspectRatio,
                                        child: VideoPlayer(SocialCubit.get(context).videoPlayerController!),
                                      ),
                                      const SizedBox(height: 7.0,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              SocialCubit.get(context).formatDuration(SocialCubit.get(context).videoPlayerController!.value.position),
                                              style: const TextStyle(color: Colors.black),
                                            ),
                                            Text(
                                              SocialCubit.get(context).formatDuration(SocialCubit.get(context).videoPlayerController!.value.duration),
                                              style: const TextStyle(color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 7.0,),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 12.0,
                                        child: VideoProgressIndicator(
                                          SocialCubit.get(context).videoPlayerController!,
                                          allowScrubbing: true,
                                          colors: const VideoProgressColors(
                                            backgroundColor: Colors.grey,
                                            bufferedColor: Colors.grey,
                                            playedColor: defaultColor,
                                          ),

                                        ),
                                      ),
                                      const SizedBox(height: 10.0,),
                                    ],
                                  ):Container()
                                else
                                  const Text('select video first please',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,color: Colors.black),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children:
                                  [
                                    ElevatedButton(
                                      onPressed: ()async
                                      {
                                        Duration? d = await SocialCubit.get(context).videoPlayerController!.position;
                                        // print(d);
                                        var val = d! - const Duration(seconds: 5);
                                        SocialCubit.get(context).videoPlayerController!.seekTo(val);
                                      },
                                      child: const Text("<<"),
                                    ),

                                    ElevatedButton(
                                      onPressed: ()
                                      {
                                        if (SocialCubit.get(context).isStop)
                                        {
                                          SocialCubit.get(context).changePlayingModeIcon(mode: false, icon: Icons.pause);
                                          SocialCubit.get(context).videoPlayerController!.play();
                                        }
                                        else{
                                          SocialCubit.get(context).changePlayingModeIcon(mode: true, icon: Icons.play_arrow_rounded);
                                          SocialCubit.get(context).videoPlayerController!.pause();
                                        }

                                      },
                                      child: Icon(SocialCubit.get(context).stopAndPauseIcon),
                                    ),

                                    // ElevatedButton(
                                    //   onPressed: ()
                                    //   {
                                    //     SocialCubit.get(context).videoPlayerController!.pause();
                                    //
                                    //   },
                                    //   child: const Icon(Icons.pause),
                                    // ),

                                    ElevatedButton(
                                      onPressed: ()async
                                      {
                                        Duration? d = await SocialCubit.get(context).videoPlayerController!.position;
                                        // print(d);
                                        var val = d! + const Duration(seconds: 5);
                                        print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
                                        print(val);//0:00:07.877000
                                        print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
                                        SocialCubit.get(context).videoPlayerController!.seekTo(val);
                                      },
                                      child: const Text(">>"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 35.0,),
                        defaultTextFormField(
                          labelColor: defaultColor,
                          controller: queryController,
                          keyboardType: TextInputType.text,
                          prefixIcon: Icons.message,
                          validatorString: 'Plz enter the query first',
                          labelText: 'what is your query ?',
                        ),
                        const SizedBox(height: 35.0,),
                        defaultButton(
                          color: defaultColor,
                          width: 200.0,
                          text: 'Play Moment',
                          textSize: 22.0,
                          Function: ()
                          {
                            if(formKey.currentState!.validate())
                            {
                              SocialCubit.get(context).sendMessage(message: queryController.text);
                              if (SocialCubit.get(context).isStop)
                              {
                                SocialCubit.get(context).changePlayingModeIcon(mode: false, icon: Icons.pause);
                              }
                              Future.delayed(const Duration(seconds: 10), ()
                              {
                                SocialCubit.get(context).changePlayingModeIcon(mode: true, icon: Icons.play_arrow_rounded);
                                SocialCubit.get(context).videoPlayerController!.pause();
                              });

                              // await Future.delayed(const Duration(seconds: 3)); // Adding a delay of 2 seconds
                              // Duration ?duration = SocialCubit.get(context).parseDuration(responseMessage); // i got error here
                              // print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
                              // print(responseMessage);//0:12:22.470000
                              // print(duration); // i got error here
                              // print("hhhhhhhhhhhhhhhhhhhhhhhhhh");





                              // SocialCubit.get(context).videoPlayerController!.seekTo(responseMessage);
                              // SocialCubit.get(context).videoPlayerController!.play();

                              // SocialLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                            }
                          },
                        ),
                        const SizedBox(height: 30.0),
                        // if(SocialCubit.get(context).duration!=null)
                        //   Text(
                        //     'predicted Time is: $responseMessage',
                        //     textAlign: TextAlign.center,
                        //     style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: defaultColor),
                        //   ),
                        // const SizedBox(height: 30.0),
                        // const SizedBox(height: 35.0,),
                        // defaultButton(
                        //   color: defaultColor,
                        //   width: 200.0,
                        //   text: 'Play Moment',
                        //   textSize: 22.0,
                        //   Function: ()
                        //   {
                        //
                        //     print(responseMessage);//0:12:22.470000
                        //     Duration ?duration = SocialCubit.get(context).parseDuration(responseMessage); // i got error here
                        //     print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
                        //     print(duration); // i got error here
                        //     print("hhhhhhhhhhhhhhhhhhhhhhhhhh");
                        //
                        //     SocialCubit.get(context).videoPlayerController!.seekTo(duration);
                        //     SocialCubit.get(context).videoPlayerController!.play();
                        //
                        //   },
                        // ),
                      ],
                    )
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:const[
                        SizedBox(height: 100.0,),
                        Icon(Icons.menu,size: 100.0,color: Colors.grey,),
                        SizedBox(height: 20.0,),
                        Text('Oops, you haven\'t uploaded any video yet.',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.black),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton:FloatingActionButton(
              onPressed: ()
              {
                SocialCubit.get(context).getVideo();
              },
              child: const Icon(Icons.add,size: 25.0,)),
        );
      },
    );
  }

}
