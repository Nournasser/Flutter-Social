import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Register/cubit/cubit.dart';
import 'package:social_app/Register/cubit/states.dart';
import 'package:social_app/social_layout.dart';
import 'package:social_app/social_login/cubit/cubit.dart';

class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if(state is SocialRegisterSuccessState)
          {
            if(state is SocialCreateUserSuccessState)
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SocialLayout(),));
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
                          'Register',
                          style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.black,
                          ),
                        ),

                        Text(
                          'Register now to communicate with friends',
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
                                  return 'please enter your name';
                                }
                              },
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: 'User Name',
                                prefix: Icon(
                                    Icons.person
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
                                  return 'please enter your email adderess';
                                }
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
                              },
                              obscureText: SocialLoginCubit.get(context).isPassword,
                              onEditingComplete: () {
                                if(formKey.currentState.validate())
                                {
                                  SocialRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text);
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

                                    SocialRegisterCubit.get(context).suffix,
                                  ),
                                  onPressed: () {
                                  },
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
                                  return 'please enter your phone';
                                }
                              },
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Phone',
                                prefix: Icon(
                                    Icons.phone
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 50.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => ElevatedButton(
                            onPressed: () {
                              if(formKey.currentState.validate())
                              {
                                SocialRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShopLayout(),));
                              }
                            },
                            child: Text('Register'),
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
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
