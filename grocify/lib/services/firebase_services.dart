import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocify/model/product_model.dart';

import 'package:grocify/model/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<DocumentSnapshot> getDocumentDetails(
    String collection,
    String document,
  ) async {
    try {
      return await _db.collection(collection).doc(document).get();
    } catch (e) {
      throw Exception('Failed to fetch document: $e');
    }
  }

  Future<QuerySnapshot> getDocuments(String collection) async {
    try {
      return await _db.collection(collection).get();
    } catch (e) {
      throw Exception('Failed to fetch documents: $e');
    }
  }

  Future<QuerySnapshot> getDocumentsWithField({
    required String collection,
    required String fieldName,
    required dynamic fieldValue,
  }) async {
    try {
      return await _db
          .collection(collection)
          .where(fieldName, isEqualTo: fieldValue)
          .get();
    } catch (e) {
      throw Exception('Failed to fetch documents with field $fieldName: $e');
    }
  }

  Future<String> uploadImage(
    File file,
    String basePath,
    String folderId,
  ) async {
    try {
      final storagePath = '$basePath/$folderId/images';

      final fileExtension = file.path.split('.').last;
      final fileName =
          '$folderId-${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

      final ref = _storage.ref().child('$storagePath/$fileName');
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        cacheControl: 'max-age=3600',
      );

      final uploadTask = ref.putFile(file, metadata);
      final snapshot = await uploadTask.whenComplete(() {});

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }

  Future<String> uploadAudioFile(
    String audioPath,
    String basePath,
    String patientFolderId,
  ) async {
    try {
      final audioFile = File(audioPath);
      final fileName = audioPath.split('/').last;
      final storagePath = '$basePath/$patientFolderId/audio/$fileName';
      final ref = _storage.ref().child(storagePath);

      final metadata = SettableMetadata(
        contentType: 'audio/mpeg',
        cacheControl: 'max-age=3600',
      );

      final uploadTask = ref.putFile(audioFile, metadata);
      final snapshot = await uploadTask.whenComplete(() {});

      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload audio file: $e');
    }
  }

  Future<DocumentReference> uploadDocument(
    String collection,
    UserModel userData,
    String documentId,
  ) async {
    try {
      final docRef = _db.collection(collection).doc(documentId);
      await docRef.set(userData.toMap());
      return docRef;
    } catch (e) {
      throw Exception('Failed to upload document: $e');
    }
  }

  Future<DocumentReference> uploadDocumentProduct(
    String collection,
    ProductModel productData,
    String documentId,
  ) async {
    try {
      final docRef = _db.collection(collection).doc(documentId);
      await docRef.set(productData.toMap());
      return docRef;
    } catch (e) {
      throw Exception('Failed to upload document: $e');
    }
  }

  Future<void> deleteProduct(String productId, String imageUrl) async {
    try {
      // Delete document from Firestore
      await _db.collection('Products').doc(productId).delete();

      // Delete image from Storage if URL exists
      if (imageUrl.isNotEmpty) {
        // Get reference from the full URL
        final ref = _storage.refFromURL(imageUrl);
        await ref.delete();
      }
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

  Future<DocumentReference> updateField(
    String collection,
    UserModel userData,
    String documentId,
  ) async {
    try {
      final docRef = _db.collection(collection).doc(documentId);
      await docRef.update(userData.toMap());
      return docRef;
    } catch (e) {
      throw Exception('Failed to upload document: $e');
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('No user is currently signed in');
      }
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'requires-recent-login':
          throw Exception('Please sign in again before updating your password');
        case 'weak-password':
          throw Exception('The password provided is too weak');
        default:
          throw Exception('Failed to update password: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to update password: $e');
    }
  }
}
