import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minute_minder/modules/Social_layout/social_layout_screen.dart';
import 'package:minute_minder/shared/components/components.dart';
import 'package:minute_minder/shared/components/constant.dart';
import 'package:minute_minder/shared/social_cubit/cubit.dart';
import 'package:minute_minder/shared/social_cubit/states.dart';
import 'package:minute_minder/shared/styles/color.dart';
import 'package:minute_minder/shared/styles/iconBroken.dart';
import 'package:video_player/video_player.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialAppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[200],

          appBar: AppBar(
            backgroundColor: Colors.grey[100],
            title: Row(
              children: const [
                 Text(
                  'Settings   ',
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Icon(IconBroken.Setting)
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          Icon(Icons.perm_identity,color: defaultColor,),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Show User Data',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    onTap: () {
                      // ShopCubit.get(context).getUserData();
                      // navigateTo(context, UserData());
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          Icon(Icons.published_with_changes_sharp,color: defaultColor,),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Update User Data',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    onTap: () {
                      // ShopCubit.get(context).getUserData();
                      // navigateTo(context, UpdateUserData());
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  myDivider(),


                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          Icon(Icons.info_outline_rounded,color: defaultColor,),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'FAQs',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    onTap: ()
                    {
                      // ShopCubit.get(context).getQuestions();
                      // navigateTo(context, const FAQsScreen());
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          Icon(Icons.call,color: defaultColor,),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Contact Us',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    onTap: ()
                    {
                      // ShopCubit.get(context).contactUs();
                      // navigateTo(context,  ContactScreen());
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children:  [
                          const Icon(Icons.brightness_4_outlined,color: defaultColor,),
                          const SizedBox(
                            width: 20.0,
                          ),
                          const Text(
                            'Appearance Mode',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Switch(
                            value: false ,
                            onChanged: (newValue) {},
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      showToast(message: 'مش شغال يعم', state: ToastStates.SUCCESS);
                      // ShopMainCubit.get(context).changeAppMode();
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 60.0,
                  ),
                  InkWell(
                    onTap: ()
                    {
                      signOut(context);
                      SocialCubit.get(context).currentIndex = 0;
                    },
                    child: Container(
                      width: 250.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: defaultColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.power_settings_new,color: Colors.white,),
                          SizedBox(width: 10.0,),
                          Text('Log Out',style: TextStyle(fontSize: 18.0,color: Colors.white,fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
