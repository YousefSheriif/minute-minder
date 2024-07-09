import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minute_minder/modules/Social_layout/social_layout_screen.dart';
import 'package:minute_minder/modules/login/new_login_screen.dart';
import 'package:minute_minder/modules/register/register_cubit/cubit.dart';
import 'package:minute_minder/modules/register/register_cubit/states.dart';
import 'package:minute_minder/shared/app_mode_cubit/mode_cubit.dart';
import 'package:minute_minder/shared/components/components.dart';
import 'package:minute_minder/shared/network/local/cache_helper.dart';
import 'package:minute_minder/shared/styles/color.dart';

class SocialRegisterNewScreen extends StatelessWidget {
  SocialRegisterNewScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return SocialRegisterCubit();
      },
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state)
        {
          if(state is SocialCreateUserSuccessState)
          {

            CacheHelper.saveData(key: 'uId', value: state.uId).then((value)
            {
              print('new aaaaaaaaaaaaaaaaaaaac');
              print(state.uId.toString());
              showToast(message: 'Account created Successfully', state: ToastStates.SUCCESS);
              navigateAndFinish(context, const SocialLayoutScreen(),);

            });
          }
          else if (state is SocialRegisterErrorState)
          {
            showToast(message:state.error.toString() , state: ToastStates.ERROR);
            // print(state.error.toString());
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
                  icon: const Icon(Icons.brightness_4_outlined,color: Colors.white,),
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
                                height: 60.0,
                              ),
                              Text(
                                "Register now",
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold,),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                "Create a new account to use Minute Minder",
                                style: TextStyle(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 60.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          height: 580,
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
                                  height: 10.0,
                                ),
                                defaultTextFormField(
                                  errorColor: Colors.red,
                                  controller: nameController,
                                  keyboardType: TextInputType.text,
                                  labelText: "User name",
                                  prefixIcon: Icons.perm_identity,
                                  validatorString:"User name must not be empty",
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
                                  errorColor: Colors.red,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  labelText: "Email Address",
                                  prefixIcon: Icons.email_rounded,
                                  validatorString:"email address must not be empty",
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
                                  errorColor: Colors.red,
                                  controller: phoneController,
                                  keyboardType: TextInputType.text,
                                  labelText: "Phone",
                                  prefixIcon: Icons.phone,
                                  validatorString:"Phone must not be empty",
                                  borderColor: defaultColor,
                                  labelColor: Theme.of(context).textTheme.bodyText1!.color,
                                  textColor: Theme.of(context).textTheme.bodyText1!.color,
                                  prefixColor: Theme.of(context).textTheme.bodyText1!.color,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultTextFormField(
                                  borderColor: defaultColor,
                                  labelColor: Theme.of(context).textTheme.bodyText1!.color,
                                  textColor: Theme.of(context).textTheme.bodyText1!.color,
                                  prefixColor: Theme.of(context).textTheme.bodyText1!.color,
                                  errorColor: Colors.blue[700],
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
                                  labelText: "Password",
                                  prefixIcon: Icons.lock_outline_rounded,
                                  suffixOnPressed: ()
                                  {
                                    SocialRegisterCubit.get(context).changeEyeIcon();
                                  },
                                  isPassword: SocialRegisterCubit.get(context).isPassword,
                                  validatorString:"password must not be empty",
                                  suffixIcon: SocialRegisterCubit.get(context).suffix,
                                  suffixColor: !SocialRegisterCubit.get(context).isPassword ? defaultColor : Theme.of(context).textTheme.bodyText1!.color,),
                                const SizedBox(
                                  height: 15.0,
                                ),

                                ConditionalBuilder(
                                  condition: state is! SocialRegisterLoadingState,
                                  builder: (BuildContext context) {
                                    return defaultButton(
                                      color: defaultColor,
                                      width: double.infinity,
                                      text: "Sign Up",
                                      textSize: 25.0,
                                      Function: () {
                                        if(formKey.currentState!.validate())
                                        {
                                          SocialRegisterCubit.get(context).userRegister
                                            (
                                            name: nameController.text,
                                            email: emailController.text,
                                            phone: phoneController.text,
                                            password: passwordController.text,
                                          );
                                        }
                                      },
                                    );
                                  },
                                  fallback: (BuildContext context)
                                  {
                                    return const Center(child: CircularProgressIndicator());
                                  },
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account ??",
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    defaultTextButton(
                                      Function: ()
                                      {
                                        navigateAndFinish(context, SocialLoginNewScreen());
                                      },
                                      text: "Sign In",
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



//   rules_version = '2';
//
//   service cloud.firestore {
//   match /databases/{database}/documents {
//   match /{document=**} {
//   allow read, write: if false;
//   }
// }
// }
