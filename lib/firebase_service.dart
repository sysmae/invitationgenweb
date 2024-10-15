import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 특정 초대장 가져오기
  Future<DocumentSnapshot?> getInvitation(String invitationId) async {
    try {
      String? userId = 'gdResudXNOXAGnWzzMyQ8tAfUf62';
      if (userId == null) return null;

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