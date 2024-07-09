import 'package:minute_minder/modules/login/new_login_screen.dart';
import 'package:minute_minder/shared/components/components.dart';
import 'package:minute_minder/shared/network/local/cache_helper.dart';

String ?token ;


String ?uId ;

String ?currentUserName;


bool? darkCopy ;



void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value)
  {
    if(value == true)
    {
      navigateAndFinish(context, SocialLoginNewScreen(),);
    }
  });
}







void printFullText(String text)
{
  final pattern = RegExp('.{1,8000}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));

}