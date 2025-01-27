import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:streamer/screen/register_screen.dart';

part 'router.freezed.dart';

mixin AppNavigator {
  static var _page = AppPage.others();
  static AppPage get page => _page;

  //Auth Module
  //static Future<void> toPhoneLogin() => Get.to(() => PhoneLoginPage());
  //static Future<void> toEditProfile() => Get.to(() => EditProfilePage());
  //static Future<void> toProfile([String userID]) => Get.to(() => ProfilePage(userID: userID), preventDuplicates: false);
  static Future<void> toRegister() => Get.to(() => RegisterScreen());
  //static Future<void> toEmailLogin() => Get.to(() => EmailLoginPage());

  //Feed Module
  /*static Future<void> toSinglePost(String id) => Get.to(() => PostPage(id));
  static Future<void> toComments(Post post) async {
    _page = AppPage.commenting(post.id);
    await Get.to(() => CommentsPage(post));
    _page = AppPage.others();
  }

  static Future<void> toJoinLive(String channelName, int channelId,
      String username, String hostImage, String userImage) async {
    await Get.to(() => JoinPage(
        channelName: channelName,
        channelId: channelId,
        username: username,
        hostImage: hostImage,
        userImage: userImage));
  }

  static Future<void> toFeedAds() => Get.to(() => FeedAdsPage());
  static Future<void> toAddPostAds() => Get.to(() => PostAdsEditorPage());

  static Future<void> toAdsComments(PostAds post) async {
    _page = AppPage.commenting(post.id);
    await Get.to(() => AdsCommentsPage(post));
    _page = AppPage.others();
  }

  static Future<void> toPostEditor([Post toEdit]) =>
      Get.to(() => PostEditorPage(toEditPost: toEdit));

  static Future<void> toPostAdsEditor([PostAds toEdit]) =>
      Get.to(() => PostAdsEditorPage(toEditPostAds: toEdit));

  static Future<void> toReplies(Comment comment) =>
      Get.to(() => ReplyPage(comment));
  static Future<void> toAdsReplies(AdsComment comment) =>
      Get.to(() => AdsReplyPage(comment));
  static Future<void> toReactions(List<String> likeIDs) =>
      Get.to(() => ReactionsPage(likeIDs));
  static void toReport(Post post) => Get.to(() => ReportPage(post));
  static void toReportAds(PostAds post) => Get.to(() => ReportAdsPage(post));*/

  //Chat Module
  /*static Future<void> toChats() async {
    //Get.find<AdsHelper>().loadFullAds();
    await Get.to(() => ChatsPage());
    //Get.find<AdsHelper>().showFullAds();
  }*/

  //Chat Module
  /*static Future<void> toNotification() async {
    //Get.find<AdsHelper>().loadFullAds();
    await Get.to(() => NotificationScreen());
    //Get.find<AdsHelper>().showFullAds();
  }

  static Future<void> toPrivateChat(String userId) async {
    _page = AppPage.chatting(userId);
    await Get.to(() => PrivateChatPage(userId));
    _page = AppPage.others();
  }

  static void toUsersSearchPage() => Get.to(() => UsersSearchPage());*/

  //Groups Module
  /*static Future<void> toGroupChat(String id) async {
    Get.find<AdsHelper>().loadFullAds();
    _page = AppPage.groupChatting(id);
    await Get.to(() => GroupChatPage(id));
    _page = AppPage.others();
    Get.find<AdsHelper>().showFullAds();
  }

  static Future<void> toGroupEditor([Group toEdit]) =>
      Get.to(() => GroupEditor(toEditGroup: toEdit));
  static Future<void> toGroupInfo(Group group) =>
      Get.to(() => GroupInfoPage(group));
  static Future<void> toGroupMembers(Group group) =>
      Get.to(() => GroupMembersPage(group));
  static Future<void> toGroupsSearch() => Get.to(() => GroupsSearch());

  //
  static Future<void> toSettings() => Get.to(() => SettingsPage());
  static Future<void> toAbout() => Get.to(() => AboutPage());
  static Future<void> toAdmin() => Get.to(() => AdminPage());*/
}

@freezed
abstract class AppPage with _$AppPage {
  const factory AppPage.chatting(String userId) = _Chatting;
  const factory AppPage.groupChatting(String groupId) = _GroupChatting;
  const factory AppPage.commenting(String postID) = _Commenting;
  const factory AppPage.others() = _Others;
}
