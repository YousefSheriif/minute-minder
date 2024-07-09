import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minute_minder/models/chat_bot/chat_message_model.dart';
import 'package:minute_minder/models/send_query/send_query_model.dart';
import 'package:minute_minder/modules/chats/test_chat_screen.dart';
import 'package:minute_minder/modules/home/social_home_screen.dart';
import 'package:minute_minder/modules/settings/social_settings_screen.dart';
import 'package:minute_minder/shared/components/constant.dart';
import 'package:minute_minder/shared/network/remote/dio_helper.dart';
import 'package:minute_minder/shared/social_cubit/states.dart';
import 'dart:convert';
import 'package:minute_minder/shared/styles/iconBroken.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';




  class SocialCubit  extends Cubit<SocialAppStates>
{

  SocialCubit():super(AppInitialState());

  var commentController = TextEditingController();

  IconData commentIcon= IconBroken.Heart;
  bool isLike = false;


  int currentIndex = 0;

  List<BottomNavigationBarItem>bottomItems =
  [
    const BottomNavigationBarItem(
      icon: Icon(IconBroken.Home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconBroken.Chat),
      label: 'Chat',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconBroken.Setting),
      label: 'Settings',
    ),

  ];


  List<Widget>screens=
  [
    HomeScreen(),
    ChatsScreenn(),
    const SettingsScreen(),
];

  static SocialCubit get(context) => BlocProvider.of(context);


  void changeIndex(index)
  {
    currentIndex= index ;

    emit(AppChangeTabBarItemsState());
  }

  bool isStop = true;
  IconData stopAndPauseIcon = Icons.play_arrow_rounded;

  void changePlayingModeIcon({
    required bool mode,
    required IconData icon,
})
  {
    isStop = mode;
    stopAndPauseIcon = icon;
    emit(AppChangePlayingModeState());
  }



  Future<void> getUserName() async
  {
    emit(SocialGetUserNameLoadingState());
    String? uId = FirebaseAuth.instance.currentUser?.uid;

    if (uId != null)
    {
      FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
        if (value.exists)
        {
          currentUserName = value.data()!['name'];
          emit(SocialGetUserNameSuccessState(currentUserName!));
        } else
        {
          emit(SocialGetUserNameErrorState('User not found'));
        }
      }).catchError((error)
      {
        print(error.toString());
        emit(SocialGetUserNameErrorState(error.toString()));
      });
    } else
    {
      emit(SocialGetUserNameErrorState('User not logged in'));
    }
  }




  File ? video ;
  VideoPlayerController? videoPlayerController;
  ImagePicker? picker = ImagePicker();
  Future<void> getVideo() async
  {
    final pickedFile = await picker?.pickVideo(source: ImageSource.gallery,);

    if(pickedFile != null)
    {
      video = File(pickedFile.path);
      videoPlayerController = VideoPlayerController.file(video!)..initialize().then((value)
      {
        print(pickedFile.path);
        emit(SocialProfileImagePickedSuccessState());
        // addVideoListener();
        // videoPlayerController!.play();
      });
    }
    else
    {
      print('No video selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }



  // void addVideoListener() {
  //   videoPlayerController?.addListener(() {
  //     emit(SocialVideoPositionChangedState());
  //   });
  // }






  var duration;
  // Method to send a message and receive a response with the predicted moment
  Future<void> sendMessage({required String message}) async {
    emit(MinuteSendQueryLoadingState());

    try {
      final response = await DioHelper.postData(
        endPoint: 'message',
        data: {'message': message},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        final messageModel = MessageModel.fromJson(responseData);
        final prediction = messageModel.response!; // Assuming response contains the time as a string

        // Parse the prediction into a Duration
        duration = parseDuration(prediction);

        // Seek to the predicted moment and play the video
        if (videoPlayerController != null && videoPlayerController!.value.isInitialized) {
          videoPlayerController!.seekTo(duration);
          videoPlayerController!.play();
        }

        emit(MinuteSendQuerySuccessState(messageModel.response!));
      } else {
        emit(MinuteSendQueryErrorState('Failed to send message. Status code: ${response.statusCode}'));
      }
    } catch (error) {
      emit(MinuteSendQueryErrorState('Error: $error'));
    }
  }



  Duration parseDuration(String s) {
    try {
      List<String> parts = s.split(':');
      if (parts.length != 3) {
        throw const FormatException('Invalid duration format');
      }

      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);

      List<String> secParts = parts[2].split('.');
      int seconds = int.parse(secParts[0]);
      int milliseconds = 0;  // Always set milliseconds to zero

      return Duration(hours: hours, minutes: minutes, seconds: seconds, milliseconds: milliseconds);
    } catch (e) {
      print('Error parsing duration: $e');
      return Duration.zero;  // Return a default duration in case of error
    }
  }


  String formatDuration(Duration duration)
  {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }


  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final ScrollController scrollController = ScrollController();
  var chatController = TextEditingController();


  void addMessagee(BuildContext context, ChatMessageModel message) {
    SocialCubit.get(context).addMessage(message);
    listKey.currentState?.insertItem(SocialCubit.get(context).messages.length - 1);
  }

  List<ChatMessageModel> messages = [];

  void addMessage(ChatMessageModel message) {
    messages.add(message);
    emit(NewMessageState());
  }



  bool isWelcomeMessageSent = false;


  void sendWelcomeMessage(BuildContext context) {
    addMessagee(
      context,
      ChatMessageModel(
        text: "Welcome to Minute Minder's Chatbot, how can I help you today?",
        isUserMessage: false,
      ),
    );
    isWelcomeMessageSent = true;
  }

  Future<void> sendMessageAndReceiveResponse(BuildContext context)async
  {
    if (chatController.text.isEmpty) {
      return;
    }
    var userMessage = chatController.text;
    chatController.clear();

    addMessagee(
      context,
      ChatMessageModel(
        text: userMessage,
        isUserMessage: true,
      ),
    );


    DioHelper.postData(
        endPoint: 'chat_bot',
        data: {'message': userMessage},
      ).then((value)
      async {

        if (value.statusCode == 200)
        {
          final jsonResponse = jsonDecode(value.toString());
          final botMessage = jsonResponse['response'];

          await Future.delayed(const Duration(seconds: 2)); // Adding a delay of 2 seconds

          addMessagee(
            context,
            ChatMessageModel(
              text: botMessage,
              isUserMessage: false,
            ),
          );
        } else {
          addMessagee(
            context,
            ChatMessageModel(
              text: "Error: Unable to get response",
              isUserMessage: false,
            ),
          );
        }
      }).catchError((error)
      {
        addMessagee(
          context,
          ChatMessageModel(
            text: "Error: $error",
            isUserMessage: false,
          ),
        );
      });
  }




// QueryModel? queryModel;
  //
  // Future<void> sendMessage(String message) async {
  //   emit(MinuteSendQueryLoadingState());
  //
  //   try {
  //     final response = await DioHelper.postData(
  //       endPoint: 'message',  // Assuming '/message' endpoint is defined on your server
  //       data: {'message': message},
  //     );
  //
  //     if (response.statusCode == 200)
  //     {
  //       queryModel = QueryModel.fromJson(response.data);
  //       emit(MinuteSendQuerySuccessState(queryModel!));
  //     } else
  //     {
  //       queryModel = QueryModel(response: 'Failed to send message. Status code: ${response.statusCode}');
  //       emit(MinuteSendQueryErrorState());
  //     }
  //   } catch (e)
  //   {
  //     queryModel = QueryModel(response: 'Error: $e');
  //     emit(MinuteSendQueryErrorState());
  //   }
  // }


}




