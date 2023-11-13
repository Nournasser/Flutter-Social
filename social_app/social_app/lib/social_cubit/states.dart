abstract class SocialStates {}

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;

  SocialGetUserErrorState(this.error);
}


class SocialChangeBottomNavStates extends SocialStates{}

class SocialNewPostStates extends SocialStates{}


class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}


class SocialCoverImagePickedSuccessState extends SocialStates{}

class SocialCoverImagePickedErrorState extends SocialStates{}


class SocialUpdateProfileImageSuccessState extends SocialStates{}

class SocialUpdateProfileImageErrorState extends SocialStates{}


class SocialUpdateCoverImageSuccessState extends SocialStates{}

class SocialUpdateCoverImageErrorState extends SocialStates{}


class SocialUserUpdateLoadingState extends SocialStates{}

class SocialUserUpdateErrorState extends SocialStates{}


class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}


class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}


class SocialRemovePostImageState extends SocialStates{}


class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates{
  final String error;

  SocialGetPostsErrorState(this.error);
}



class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates{
  final String error;

  SocialLikePostErrorState(this.error);
}



class SocialCommentPostSuccessState extends SocialStates{}

class SocialCommentPostErrorState extends SocialStates{
  final String error;

  SocialCommentPostErrorState(this.error);
}


class SocialGetAllUsersLoadingState extends SocialStates{}

class SocialGetAllUsersSuccessState extends SocialStates{}

class SocialGetAllUsersErrorState extends SocialStates{
  final String error;

  SocialGetAllUsersErrorState(this.error);
}


class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates{}

class SocialGetMessageSuccessState extends SocialStates{}