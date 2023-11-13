import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Register/register_screen.dart';
import 'package:social_app/conistants/conistants.dart';
import 'package:social_app/social_layout.dart';
import 'package:social_app/social_login/cubit/cubit.dart';
import 'package:social_app/social_login/cubit/states.dart';
import 'package:social_app/network/shared_prefrunce.dart';


class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if(state is SocialLoginErrorState)
            showToast(
                text: state.error,
                color: ToastColors.ERROR
            );

          if(state is SocialLoginSuccessState)
            {
              CashHelper.saveDate(
                key: 'uId',
                value: state.uId,
              ).then((value){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SocialLayout(),));
              });
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.black,
                          ),
                        ),

                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),

                        SizedBox(
                          height: 30.0,
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if(value.isEmpty)
                                {
                                  return 'please enter your email adderess';
                                }
                                return null;
                              },
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                prefix: Icon(
                                    Icons.email_outlined
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20.0,
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if(value.isEmpty)
                                {
                                  return 'password is too short';
                                }
                                return null;
                              },
                              obscureText: SocialLoginCubit.get(context).isPassword,
                              onEditingComplete: () {
                                if(formKey.currentState.validate())
                                {
                                  /*SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);*/
                                }
                              },
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefix: Icon(
                                    Icons.lock_outline
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(

                                    SocialLoginCubit.get(context).suffix,
                                  ),
                                  onPressed: () {
                                    SocialLoginCubit.get(context).changePasswordVisibiliy();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 50.0,
                        ),

                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => ElevatedButton(
                            onPressed: () {
                              if(formKey.currentState.validate())
                              {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SocialLayout(),));
                              }
                            },
                            child: Text('login'),
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator(),),
                        ),

                        Row(
                          children: [
                            Text('Don\'t have an account ?'),
                            SizedBox(
                              width: 15.0,
                            ),
                            TextButton(onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
                            }, child: Text('Register'),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
