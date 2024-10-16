import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 특정 초대장 가져오기
  Future<DocumentSnapshot?> getInvitation(String userId, String invitationId) async {
    try {
      if (userId.isEmpty) return null; // userId가 비어있다면 null 반환

      DocumentSnapshot invitationDoc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('invitations')
          .doc(invitationId)
          .get();

      return invitationDoc.exists ? invitationDoc : null;
    } catch (e) {
      print('Failed to get invitation: ${e.toString()}');
      return null;
    }
  }
}
