import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:minute_minder/modules/login/new_login_screen.dart';
import 'package:minute_minder/shared/components/components.dart';
import 'package:minute_minder/shared/network/local/cache_helper.dart';
import 'dart:ui' as ui;


class BoardingModel
{
  final String image;
  final Color color;
  final String title;
  final String body;


  BoardingModel({
    required this.image,
    required this.color,
    required this.title,
    required this.body,
  });
}

class LiquidOnBoarding extends StatefulWidget {
  const LiquidOnBoarding({Key? key}) : super(key: key);

  @override
  State<LiquidOnBoarding> createState() => _LiquidOnBoardingState();
}

class _LiquidOnBoardingState extends State<LiquidOnBoarding>
{
  LiquidController liquidController = LiquidController();

  @override
  Widget build(BuildContext context) {

    List<BoardingModel>boarding=
    [
      BoardingModel(
        color: Colors.black,
        image: 'assets/images/b1.png',
        title: "Minute Minder is a simple application that reminds you with the exact minute you require in your video.",
        body: "Welcome to Minute Minder",
      ),
      BoardingModel(
        color: const Color(0xff0b554c),
        image: 'assets/images/b7.png',
        title: "Just write a query that describes your desired moment...\n\nand the application will do the rest",
        body:  "With AI, the world will be better ",
      ),
      BoardingModel(
        color: const Color(0xff0b3855),
        image: 'assets/images/b9.png',
        title: "In Minute Minder you can chat with your video... \n\nfeel free to try it now.",
        body:  "More info about your video",
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          LiquidSwipe.builder(
            liquidController: liquidController,
            enableSideReveal: true,
            positionSlideIcon: 0.7,
            enableLoop: false,
            slideIconWidget: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPageChangeCallback: (index)
            {
              setState(() {});
            },
            itemBuilder: (BuildContext context, int index)
            {
              // print(SocialCubit.get(context).textDirection.toString());
              return buildItem(boarding[index]);
            },
            itemCount: 3,

          ),
          Positioned(
            bottom: 20,
            left: 40,
            right: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      submit();
                    },
                    child: const Text(
                      "Skip",
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.white),
                    )),
                AnimatedSmoothIndicator(
                  activeIndex: liquidController.currentPage,
                  count: boarding.length,

                  effect: const ExpandingDotsEffect(
                    activeDotColor: Color(0xff63aaf1),
                    dotColor: Color(0xffc4dffa),
                    dotHeight: 10,
                    dotWidth: 13,
                    expansionFactor: 3.5,
                    spacing: 7,
                  ),
                  onDotClicked: (index) {
                    liquidController.animateToPage(page: index);
                  },
                ),
                TextButton(
                  onPressed: ()
                  {
                    final page = liquidController.currentPage + 1;
                    if (page == 3)
                    {
                      submit();
                    }
                    else
                    {
                      liquidController.animateToPage(page: page > 3 ? 0 : page);
                    }
                  },
                  child: const Text(
                    "Next",
                    style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(BoardingModel model) {
    return Container(
      color: model.color,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 370,//450
            child: Image(
              image: AssetImage(
                model.image,
              ),
              height: 400,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,  //عشان اتحكم ف مكان ال body
              children: [
                Text(
                  model.body,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffc4dffa),
                  ),
                ),
                const SizedBox(height: 15,),
                Text(
                  model.title,
                  textAlign: TextAlign.start, //عشان اتحكم ف مكان السطريت الاخار
                  style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xffc4dffa),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }




  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true,).then((value)
    {
      if(value)
      {
        navigateAndFinish(context, SocialLoginNewScreen());
      }
    });
  }

}
