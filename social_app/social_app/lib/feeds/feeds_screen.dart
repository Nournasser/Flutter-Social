import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/conistants/conistants.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/social_cubit/cubit.dart';
import 'package:social_app/social_cubit/states.dart';
import 'package:social_app/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {

      },
      builder:(context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: EdgeInsets.all(8.0),

                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/medium-shot-young-girl-posing_23-2150903429.jpg?t=st=1697901509~exp=1697905109~hmac=1bd6b5b14a0f38c9bffe76d4fe6de2fdb35a192c1ceada890c8b9340e1c11d99&w=1060'
                          ),
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate with friends',
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 15.0,

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context, index),
                    itemCount: SocialCubit.get(context).posts.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8.0,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ]
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
var commentController = TextEditingController();

Widget buildPostItem(PostModel model , context, index) => Card(
  clipBehavior: Clip.antiAliasWithSaveLayer,
  elevation: 5.0,
  margin: EdgeInsets.symmetric(
    horizontal: 8.0,
  ),
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                '${model.image}',
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start  ,
              children: [
                Row(
                  children: [
                    Text(
                      '${model.name}',
                      style: TextStyle(
                        height: 1.4,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                      size: 16.0,
                    ),
                  ],
                ),
                Text(
                  '${model.dateTime}',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
            )),
            SizedBox(
              width: 15.0,
            ),
            IconButton(
              icon: Icon(
                Icons.more_horiz,
                size: 16.0,
              ),
              onPressed: () {

              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        Text(
            '${model.text}'
        ),
        Container(
          width: double.infinity,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  end: 6.0,
                ),
                child: Container(
                  child: MaterialButton(
                    onPressed: () {

                    },
                    minWidth: 1.0,
                    padding: EdgeInsets.zero,
                    height: 25.0,
                    child: Text(
                      '#software',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  end: 6.0,
                ),
                child: Container(
                  child: MaterialButton(
                    onPressed: () {

                    },
                    minWidth: 1.0,
                    padding: EdgeInsets.zero,
                    height: 25.0,
                    child: Text(
                      '#flutter',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if(model.postImage != '')
          Container(
          height: 140.0,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    '${model.postImage}'
                ),
                fit: BoxFit.cover,

              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                            '${SocialCubit.get(context).likes[index]}'
                        ),
                      ],
                    ),
                  ),
                  onTap: () {

                  },
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          IconBroken.Chat,
                          size: 16.0,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                            '${SocialCubit.get(context).comments[index]} comment'
                        ),
                      ],
                    ),
                  ),
                  onTap: () {

                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 10.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        /*if(SocialCubit.get(context).comments[index] > 0)
          Row(
          children: [
            CircleAvatar(
              radius: 15.0,
              backgroundImage: NetworkImage(
                '${model.image}',
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start  ,
              children: [
                Row(
                  children: [
                    Text(
                      '${model.name}',
                      style: TextStyle(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${SocialCubit.get(context).commentText.toString()}',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
            )),
            SizedBox(
              width: 15.0,
            ),
            IconButton(
              icon: Icon(
                Icons.more_horiz,
                size: 16.0,
              ),
              onPressed: () {

              },
            ),
          ],
        ),
        if(SocialCubit.get(context).comments[index] > 0)
          Padding(
          padding: const EdgeInsets.only(
            bottom: 10.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),*/
        Row(
          children: [
            Expanded(
              child: InkWell(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18.0,
                      backgroundImage: NetworkImage(
                        '${SocialCubit.get(context).userModel.image}',
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: 'write your comment ...',
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
                onTap: () {},
              ),
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      size: 16.0,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                        'Like'
                    ),
                  ],
                ),
              ),
              onTap: () {
                SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
              },
            ),
            SizedBox(
              width: 8.0,
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Chat,
                      size: 16.0,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                        'Comment'
                    ),
                  ],
                ),
              ),
              onTap: () {
                SocialCubit.get(context).commentPost(SocialCubit.get(context).postsId[index], commentController.text);
              },
            ),

          ],
        ),

      ],
    ),
  ),
);
