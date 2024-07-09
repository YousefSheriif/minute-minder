import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minute_minder/shared/social_cubit/cubit.dart';
import 'package:minute_minder/shared/social_cubit/states.dart';
import 'package:minute_minder/shared/styles/color.dart';


class SocialLayoutScreen extends StatelessWidget {
  const SocialLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    var cubit = SocialCubit.get(context) ;
    return BlocConsumer<SocialCubit,SocialAppStates>(
      listener: (context,state)
      {},
      builder: (context,state)
      {
        return Scaffold(

          // appBar: AppBar(
          //   title:  Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 20.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         const SizedBox(width: 15.0,),
          //         const CircleAvatar(
          //           radius: 30.0,
          //           backgroundImage: AssetImage('assets/images/pic1.jpg'),
          //         ),
          //         Spacer(),
          //         Column(
          //           children: [
          //             const Icon(Icons.shopping_cart_outlined,color: defaultColor,),
          //             const Text(
          //               'Minute Minder',//SHOPPING
          //               style:TextStyle(
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 24.0,
          //                 color: defaultColor,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey[300],
            currentIndex: cubit.currentIndex,
            selectedItemColor: defaultColor,
            onTap: (index)
            {
              cubit.changeIndex(index);
            },
            items: SocialCubit.get(context).bottomItems,
            unselectedItemColor: Colors.black87,
          ),
        ) ;
      },
    );
  }
}
