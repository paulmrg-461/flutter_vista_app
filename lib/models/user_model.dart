import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? clientEmail;
  final String? clientName;
  final bool? clientEnable;
  final String? clientPhotoURL;
  final DateTime? clientRegisterDate;
  final String? deviceId;
  final List<dynamic>? deviceTokens;

  UserModel({
    this.clientEmail,
    this.clientName,
    this.clientEnable,
    this.clientPhotoURL,
    this.clientRegisterDate,
    this.deviceId,
    this.deviceTokens,
  });

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          clientEmail: (json['clientEmail'] != null)
              ? json['clientEmail']! as String
              : '',
          clientName:
              (json['clientName'] != null) ? json['clientName']! as String : '',
          clientEnable: json['clientEnable']! as bool,
          clientPhotoURL: (json['clientPhotoURL'] != null)
              ? json['clientPhotoURL']! as String
              : '',
          clientRegisterDate:
              (json['clientRegisterDate']! as Timestamp).toDate(),
          deviceId:
              (json['deviceId'] != null) ? json['deviceId']! as String : '',
          deviceTokens: (json['deviceTokens'] != null)
              ? json['deviceTokens']! as List<dynamic>
              : [],
        );
  Map<String, Object?> toJson() {
    return {
      'clientEmail': clientEmail,
      'clientName': clientName,
      'clientEnable': clientEnable,
      'clientPhotoURL': clientPhotoURL,
      'clientRegisterDate': clientRegisterDate,
      'deviceId': deviceId,
      'deviceTokens': deviceTokens,
    };
  }
}
