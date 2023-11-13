import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/chats/chats_screen.dart';
import 'package:social_app/conistants/conistants.dart';
import 'package:social_app/feeds/feeds_screen.dart';
import 'package:social_app/model/message_model.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/model/social_user_model.dart';
import 'package:social_app/new_post/neww_post_screen.dart';
import 'package:social_app/settings/settings_screen.dart';
import 'package:social_app/social_cubit/states.dart';
import 'package:social_app/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() :super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel userModel;

  void getUserDate()
  {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('user').doc(uId).get().then((value) {
      //print(value.data());
       userModel = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error){
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Posts',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index)
  {
    if(index == 1)
      getUsers();
    if(index == 2)
      {
        emit(SocialNewPostStates());
      }
    else
      {
        currentIndex = index;
        emit(SocialChangeBottomNavStates());
      }

  }

  File profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null){
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }
    else{
      print('Mo Image Selected');
      emit(SocialProfileImagePickedErrorState());
    }

  }

  File coverImage;

  Future<void> getCoverImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null){
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }
    else{
      print('Mo Image Selected');
      emit(SocialCoverImagePickedErrorState());
    }

  }


  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
})
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(profileImage.path).pathSegments.last}').putFile(profileImage)
        .then((value) => {
          value.ref.getDownloadURL().then((value) {
            //emit(SocialUpdateProfileImageSuccessState());
            print(value);
            updateUser(
                name: name,
                phone: phone,
                bio: bio,
              image: value,
            );
          }).catchError((error){
            emit(SocialUpdateProfileImageErrorState());
          })
    }).catchError((error){
      emit(SocialUpdateProfileImageErrorState());
    });
  }


  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
})
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) => {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUpdateCoverImageSuccessState());
        print(value);
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            cover: value
        );
      }).catchError((error){
        emit(SocialUpdateCoverImageErrorState());
      })
    }).catchError((error){
      emit(SocialUpdateCoverImageErrorState());
    });
  }

/*  void updateUserImage({
  @required String name,
    @required String phone,
    @required String bio,
  })
  {
    emit(SocialUserUpdateLoadingState());

    if(coverImage != null)
      {
        uploadCoverImage();
      }
    else if(profileImage != null)
      {
        uploadProfileImage();
      }
    else if(coverImage != null && profileImage != null)
      {

      }
    else
      {
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
        );
      }
  }*/

  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
    String cover,
    String image,
  })
    {
    SocialUserModel model = SocialUserModel(
        phone: phone,
        name: name,
        bio: bio,
        cover: cover ?? userModel.cover,
        image: image ?? userModel.image,
        uId: userModel.uId,
        email: userModel.email,
        isEmailVerified: false
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) {
      getUserDate();
    })
        .catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File postImage;

  Future<void> getPostImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null){
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    }
    else{
      print('Mo Image Selected');
      emit(SocialPostImagePickedErrorState());
    }

  }

  void uploadPostImage({
    @required String dateTime,
    @required String text,
  })
  {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) => {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error){
        emit(SocialCreatePostErrorState());
      })
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }


  void removePostImage()
  {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void createPost({
    @required String dateTime,
    @required String text,
    String postImage
  })
  {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel.name,
      uId: userModel.uId,
      image: userModel.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
          emit(SocialCreatePostSuccessState());
    })
        .catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];
  List<String> commentText = [];

  void getsPosts()
  {
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference
            .collection('likes')
            .get()
            .then((value) {
              likes.add(value.docs.length);
              postsId.add(element.id);
              posts.add(PostModel.fromJson(element.data()));
            })
            .catchError((error){});
            
            element.reference
            .collection('comments')
            .get()
            .then((value) {
              comments.add(value.docs.length);
            })
            .catchError((error){});

            /*element.reference
            .collection('comments').doc(userModel.uId)
            .get()
            .then((value) {
              commentText.add(value.toString());
            })
            .catchError((error){});*/
          });

          
          emit(SocialGetPostsSuccessState());
    })
        .catchError((error){
          emit(SocialGetPostsErrorState(error.toString()));
    });
    
    
  }

  void likePost(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({
      "like" : true,
    })
        .then((value) {
          emit(SocialLikePostSuccessState());
    })
        .catchError((error){
          emit(SocialLikePostErrorState(error.toString()));
    });
  }


  void commentPost(String postId, String comment)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel.uId)
        .set({
      "comment" : comment,
    })
        .then((value) {
      emit(SocialCommentPostSuccessState());
    })
        .catchError((error){
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers()
  {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId'] != userModel.uId)
          users.add(SocialUserModel.fromJson(element.data()));
        });
      emit(SocialGetAllUsersSuccessState());
    })
        .catchError((error){
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }

  void sendMessage({
  @required String receiverId,
    @required String text,
    @required String dateTime,
})
  {
    MessageModel model = MessageModel(
      dateTime: dateTime,
       text: text,
      receiverId: receiverId,
      senderId: userModel.uId,
    );
    
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(model.toMap())
    .then((value) {
      emit(SocialSendMessageSuccessState());
    })
    .catchError((error){
      emit(SocialSendMessageErrorState());
    });


    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    @required String receiverId,
  })
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });

          emit(SocialGetMessageSuccessState());
    });
  }
}