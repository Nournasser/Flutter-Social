import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/conistants/conistants.dart';
import 'package:social_app/social_cubit/cubit.dart';
import 'package:social_app/social_cubit/states.dart';
import 'package:social_app/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {

  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'create New Posts',
            actions: [
              TextButton(
                onPressed: (){
                   var now = DateTime.now();
                  if(SocialCubit.get(context).postImage == null)
                    {
                      SocialCubit.get(context).createPost(
                          dateTime: now.toString(),
                          text: textController.text
                      );
                    }
                  else
                    {
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text
                      );
                    }
                },
                child: Text('Post',),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/view-3d-woman_23-2150709978.jpg?t=st=1697897822~exp=1697901422~hmac=5b7e3a5ae7c5fe4fe1ea1338fd3e2eb926ddddd0b253a36d1e8b4c4c58fd7cf7&w=740',
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        'Nour Nasser',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'what is in your mind',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            4.0,
                          ),
                          image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage),
                            fit: BoxFit.cover,

                          )
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row (
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Add Photo',
                              ),
                            ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: Text(
                          '# tags',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
