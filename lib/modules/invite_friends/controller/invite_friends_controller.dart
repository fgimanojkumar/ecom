import 'package:get/get.dart';

class InviteFriendsController extends GetxController {
  final RxSet<int> invitedIndexes = <int>{}.obs;

  final List<Map<String, String>> friends = const [
    {
      'name': 'Isabella Davis',
      'phone': '(212) 555-0147',
      'avatar': 'https://i.pravatar.cc/160?img=47',
    },
    {
      'name': 'Olivia Williams',
      'phone': '(310) 555-0265',
      'avatar': 'https://i.pravatar.cc/160?img=32',
    },
    {
      'name': 'Harper Jackson',
      'phone': '(202) 555-0129',
      'avatar': 'https://i.pravatar.cc/160?img=5',
    },
    {
      'name': 'Evelyn White',
      'phone': '(718) 555-0246',
      'avatar': 'https://i.pravatar.cc/160?img=12',
    },
    {
      'name': 'Mia Anderson',
      'phone': '(617) 555-0152',
      'avatar': 'https://i.pravatar.cc/160?img=49',
    },
    {
      'name': 'Charlotte Taylor',
      'phone': '629.555.0129',
      'avatar': 'https://i.pravatar.cc/160?img=20',
    },
    {
      'name': 'Isabella Davis',
      'phone': '(646) 555-0234',
      'avatar': 'https://i.pravatar.cc/160?img=9',
    },
    {
      'name': 'Scarlett Moore',
      'phone': '(305) 555-0176',
      'avatar': 'https://i.pravatar.cc/160?img=41',
    },
  ];

  void inviteFriend(int index) {
    invitedIndexes.add(index);
    Get.snackbar(
      'Invitation Sent',
      'Invite sent to ${friends[index]['name']}',
      duration: const Duration(milliseconds: 1400),
    );
  }
}
