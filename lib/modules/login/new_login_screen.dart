import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minute_minder/modules/Social_layout/social_layout_screen.dart';
import 'package:minute_minder/modules/login/login_cubit/cubit.dart';
import 'package:minute_minder/modules/login/login_cubit/states.dart';
import 'package:minute_minder/modules/register/new_register_screen.dart';
import 'package:minute_minder/shared/app_mode_cubit/mode_cubit.dart';
import 'package:minute_minder/shared/components/components.dart';
import 'package:minute_minder/shared/network/local/cache_helper.dart';
import 'package:minute_minder/shared/social_cubit/cubit.dart';
import 'package:minute_minder/shared/styles/color.dart';
import 'package:minute_minder/translations/locale_keys.g.dart';

class SocialLoginNewScreen extends StatelessWidget {
  SocialLoginNewScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return SocialLoginCubit();
      },
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state)
        {
          if(state is SocialLoginSuccessState )
          {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value)
            {
              navigateAndFinish(context, const SocialLayoutScreen());
              showToast(message: 'Login Done Successfully', state: ToastStates.SUCCESS);

            });
            // navigateAndFinish(context, const SocialLayoutScreen(),);
          }
          else if(state is SocialLoginErrorState)
          {
            showToast(message: 'PLz check your Data', state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
              actions: [
                IconButton(onPressed: ()
                {
                  ModeCubit.get(context).changeAppMode();
                },
                  icon: Icon(Icons.brightness_4_outlined,color: Theme.of(context).textTheme.bodyText2!.color,),
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/newbac2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Sign in now",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!.copyWith(
                                  fontSize: 35.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                "Save your time with Minute Minder",
                                style: TextStyle(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 100.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          height: 505,
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            color: Theme.of(context).textTheme.bodyText2!.color,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0),
                            ),
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultTextFormField(
                                  errorColor: Colors.red,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  labelText: "Email Address",
                                  prefixIcon: Icons.email_rounded,
                                  validatorString: "email address must not be empty",
                                  borderColor: defaultColor,
                                  labelColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  prefixColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultTextFormField(
                                  borderColor: defaultColor,
                                  labelColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  prefixColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  errorColor: Colors.blue[700],
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
                                  labelText: "Password",
                                  prefixIcon: Icons.lock_outline_rounded,
                                  suffixOnPressed: () {
                                    SocialLoginCubit.get(context)
                                        .changeEyeIcon();
                                  },
                                  isPassword:
                                      SocialLoginCubit.get(context).isPassword,
                                  validatorString: "password must not be empty",
                                  suffixIcon: SocialLoginCubit.get(context).suffix,
                                  suffixColor: !SocialLoginCubit.get(context).isPassword ? defaultColor : Theme.of(context).textTheme.bodyText1!.color,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                defaultTextButton(
                                  Function: () {},
                                  text: "Forget your password?",
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                ConditionalBuilder(
                                  condition: state is! SocialLoginLoadingState,
                                  builder: (BuildContext context) {
                                    return defaultButton(
                                      color: defaultColor,
                                      width: double.infinity,
                                      text: "Sign In",
                                      textSize: 25.0,
                                      Function: () {
                                        if(formKey.currentState!.validate())
                                        {
                                          SocialLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                                        }
                                      },
                                    );
                                  },
                                  fallback: (BuildContext context) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                ),
                                const SizedBox(
                                  height: 25.0,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(
                                        "Or Sign in with",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w900,
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        child: CircleAvatar(
                                          radius: 20.0,
                                          backgroundColor: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .color,
                                          child: const Image(
                                              image: AssetImage(
                                                  'assets/images/facebook_logo.png')),
                                        ),
                                        onTap: () {
                                          print('facebook');
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: CircleAvatar(
                                          radius: 18.0,
                                          backgroundColor: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .color,
                                          child: const Image(
                                              image: AssetImage(
                                                  'assets/images/Google_Logo.png')),
                                        ),
                                        onTap: () {
                                          print('google');
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: CircleAvatar(
                                          radius: 18.0,
                                          backgroundColor: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .color,
                                          child: const Image(
                                              image: AssetImage(
                                                  'assets/images/Twitter-Logo.png')),
                                        ),
                                        onTap: ()
                                        {
                                          print('twitter');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account ?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    defaultTextButton(
                                      Function: () {
                                        navigateAndFinish(context, SocialRegisterNewScreen());
                                      },
                                      text: "SignUp Now",
                                      fontWeight: FontWeight.bold,
                                      color: defaultColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
