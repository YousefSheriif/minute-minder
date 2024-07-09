

import 'package:minute_minder/models/send_query/send_query_model.dart';

abstract class SocialAppStates{}

class AppInitialState extends SocialAppStates{}

class AppChangeTabBarItemsState extends SocialAppStates{}

class AppChangePlayingModeState extends SocialAppStates{}

class SocialGetUserNameLoadingState extends SocialAppStates{}

class SocialGetUserNameSuccessState extends SocialAppStates
{
  final String userName;

  SocialGetUserNameSuccessState(this.userName);

}

class SocialGetUserNameErrorState extends SocialAppStates
{
  final String error ;

  SocialGetUserNameErrorState(this.error);

}

class SocialProfileImagePickedSuccessState extends SocialAppStates{}

class SocialProfileImagePickedErrorState extends SocialAppStates{}

class MinuteSendQueryLoadingState extends SocialAppStates{}

class MinuteSendQuerySuccessState extends SocialAppStates
{
  final String messageModel;

  MinuteSendQuerySuccessState(this.messageModel);
}

class MinuteSendQueryErrorState extends SocialAppStates
{
  final String error;

  MinuteSendQueryErrorState(this.error);

}


class InitialSocialState extends SocialAppStates {}

class NewMessageState extends SocialAppStates {}

class SocialVideoPositionChangedState extends SocialAppStates {}
