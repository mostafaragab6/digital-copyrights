abstract class AppStates{}

class AppInitialState extends AppStates {}

class ChangeNavBar extends AppStates {}
class ChangeMood extends AppStates {}
class ChangeReactState extends AppStates {}

class ChangeCounterState extends AppStates{}
class DeletedState extends AppStates{}


class GetPostsAllDataLoading extends AppStates{}
class GetPostsAllDataSuccess extends AppStates{}
class GetPostsAllDataError extends AppStates{}

class GetUserPostsAllDataLoading extends AppStates{}
class GetUserPostsAllDataSuccess extends AppStates{}
class GetUserPostsAllDataError extends AppStates{}

class SetPostLoading extends AppStates{}
class SetPostSuccess extends AppStates{}
class SetPostError extends AppStates{}

class FollowUserLoading extends AppStates{}
class FollowUserSuccess extends AppStates{}
class FollowUserError extends AppStates{}

class GetProfileDataLoading extends AppStates{}
class GetProfileDataSuccess extends AppStates{}
class GetProfileDataError extends AppStates{}

class GetNotificationLoading extends AppStates{}
class GetNotificationSuccess extends AppStates{}
class GetNotificationError extends AppStates{}

class GetNotifiedPostDataLoading extends AppStates{}
class GetNotifiedPostDataSuccess extends AppStates{}
class GetNotifiedPostDataError extends AppStates{}


class UpdatePostLoading extends AppStates{}
class UpdatePostSuccess extends AppStates{}
class UpdatePostError extends AppStates{}

class UploadedImageState extends AppStates{}