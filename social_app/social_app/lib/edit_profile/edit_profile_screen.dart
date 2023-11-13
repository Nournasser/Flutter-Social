import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/conistants/conistants.dart';
import 'package:social_app/social_cubit/cubit.dart';
import 'package:social_app/social_cubit/states.dart';
import 'package:social_app/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var bioControler = TextEditingController();
  var phoneControler = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          var userModle = SocialCubit.get(context).userModel;
          var profileImage = SocialCubit.get(context).profileImage;
          var coverImage = SocialCubit.get(context).coverImage;

           nameController.text = userModle.name;
           bioControler.text = userModle.bio;
          phoneControler.text = userModle.phone;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scaffold(
              appBar: defaultAppBar(
                  context: context,
                  title: 'Edit Profile',
                  actions: [
                    TextButton(
                      onPressed: () {
                        SocialCubit.get(context).updateUser(name: nameController.text, phone: phoneControler.text, bio: bioControler.text);
                      },
                      child: Text(
                        'Update',
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                  ]
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if(state is SocialUserUpdateLoadingState)
                        LinearProgressIndicator(),
                      if(state is SocialUserUpdateLoadingState)
                        SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 190.0,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: 140.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                        image: DecorationImage(
                                          image: coverImage == null ? NetworkImage(
                                              '${userModle.cover}'
                                          ) : FileImage(coverImage),
                                          fit: BoxFit.cover,

                                        )
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 20.0,
                                    child: IconButton(
                                        icon: Icon(
                                          IconBroken.Camera,
                                        ),
                                        onPressed: () {
                                          SocialCubit.get(context).getCoverImage();
                                        },
                                    ),
                                  ),
                                ],
                              ),
                              alignment: AlignmentDirectional.topCenter,
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 65.0,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: profileImage == null ? NetworkImage(
                                      '${userModle.image}',
                                    ) : FileImage(profileImage),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 20.0,
                                  child: IconButton(
                                    icon: Icon(
                                      IconBroken.Camera,
                                    ),
                                    onPressed: () {
                                      SocialCubit.get(context).getProfileImage();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                        Row(
                        children: [
                          if(SocialCubit.get(context).profileImage != null)
                                Expanded(
                                  child: Column(
                                    children: [
                                      defaultButton(text: 'Update Profile', function: (){
                                        SocialCubit.get(context).uploadProfileImage(
                                            name: nameController.text,
                                            phone: phoneControler.text,
                                            bio: bioControler.text
                                        );
                                      }),
                                      if(state is SocialUserUpdateLoadingState)
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                      if(state is SocialUserUpdateLoadingState)
                                        LinearProgressIndicator(),
                                    ],
                                  ),
                                ),
                          SizedBox(
                            width: 5.0,
                          ),
                          if(SocialCubit.get(context).coverImage != null)
                                Expanded(
                                  child: Column(
                                    children: [
                                      defaultButton(text: 'Update Cover', function: (){
                                        SocialCubit.get(context).uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneControler.text,
                                          bio: bioControler.text
                                        );
                                      }),
                                      if(state is SocialUserUpdateLoadingState)
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                      if(state is SocialUserUpdateLoadingState)
                                        LinearProgressIndicator(),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                      if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                        SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                              return 'name must not be empty';
                            return null;
                          },
                          prefix: Icon(IconBroken.User),
                        hint: 'Name',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      defaultFormField(
                        controller: phoneControler,
                        type: TextInputType.phone,
                        validate: (String value)
                        {
                          if(value.isEmpty)
                            return 'phone must not be empty';
                          return null;
                        },
                        prefix: Icon(IconBroken.Call),
                        hint: 'Phone',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      defaultFormField(
                        controller: bioControler,
                        type: TextInputType.text,
                        validate: (String value)
                        {
                          if(value.isEmpty)
                            return 'bio must not be empty';
                          return null;
                        },
                        prefix: Icon(IconBroken.Info_Circle),
                        hint: 'Bio',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {

        },
    );
  }
}
