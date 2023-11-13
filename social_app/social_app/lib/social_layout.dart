import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/new_post/neww_post_screen.dart';
import 'package:social_app/social_cubit/cubit.dart';
import 'package:social_app/social_cubit/states.dart';
import 'package:social_app/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostStates)
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => NewPostScreen(),),
          );
      },
      builder: (context, state) {
        
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(icon: Icon(
                  IconBroken.Setting
              ),
                onPressed: (){},
                color: Colors.black,
              ),
              IconButton(
                icon: Icon(IconBroken.Notification
                ),
                onPressed: (){},
                color: Colors.black,
              ),

            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                    color: Colors.black,
                  ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Chat,
                    color: Colors.black,
                  ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Paper_Upload,
                  color: Colors.black,
                ),
                label: 'Posts',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Location,
                    color: Colors.black,
                  ),
                label: 'User',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Setting,
                    color: Colors.black,
                  ),
                label: 'Settings',
              ),
            ],
          ),

          /*ConditionalBuilder(
            condition: SocialCubit.get(context).model != null,
            builder: (context) {
              var model = SocialCubit.get(context).model;
              return Column(
                children: [
                  /*if(!FirebaseAuth.instance.currentUser.emailVerified)
                    Container(
                    color: Colors.amber.withOpacity(.6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: Text(
                                'please verify your email'
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.currentUser.sendEmailVerification().then((value) {
                                showToast(text: 'check you email', color: ToastColors.SUCCESS);
                              }).catchError((error){});
                            },
                            child: Text(
                                'send'
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/

                ],
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),*/
        );
      },

    );
  }
}
