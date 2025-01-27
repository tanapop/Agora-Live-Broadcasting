import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:streamer/models/users/provider.dart';

import '../../utils/utils.dart';

class NotificationModel extends Equatable {
  final String id;
  final String toId;
  final String fromId;
  final String fromName;
  final DateTime createdAt;
  final int type;

  //Post Comment or Reaction
  final String postID;
  //Comment Reply or Reaction
  final String commentID;

  const NotificationModel({
    @required this.id,
    @required this.toId,
    @required this.fromId,
    @required this.fromName,
    @required this.createdAt,
    @required this.type,
    this.postID,
    this.commentID,
  });

  bool get isFollow => type == NotificationType.Follow.index;
  bool get isPostReaction => type == NotificationType.PostReaction.index;
  bool get isComment => type == NotificationType.Comment.index;
  bool get isCommentReaction => type == NotificationType.CommentReaction.index;
  bool get isReply => type == NotificationType.Reply.index;

  String get text {
    if (isFollow) {
      return '$fromName เริ่มติดตามคุณ';
    } else if (isPostReaction) {
      return '$fromName ถูกใจโพสต์ของคุณ';
    } else if (isComment) {
      return '$fromName แสดงความคิดเห็นโพสต์ของคุณ';
    } else if (isCommentReaction) {
      return '$fromName ถูกใจความคิดเห็นของคุณ';
    } else if (isReply) {
      return '$fromName ตอบความคิดเห็นของคุณ';
    } else {
      return '';
    }
  }

  factory NotificationModel.create({
    String toId,
    NotificationType type,
    String postID,
    String commentID,
  }) {
    final user = authProvider.user;
    return NotificationModel(
      id: '${type.index}-${postID ?? ''}-${commentID ?? ''}${user.username}-$toId',
      toId: toId,
      fromId: user.id,
      fromName: user.username,
      createdAt: DateTime.now().toUtc(),
      type: type.index,
      postID: postID,
      commentID: commentID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'toId': toId,
      'fromId': fromId,
      'fromName': fromName,
      'createdAt': createdAt,
      'type': type,
      'postID': postID,
      'commentID': commentID,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NotificationModel(
      id: map['id'] as String ?? '',
      toId: map['toId'] as String ?? '',
      fromId: map['fromId'] as String ?? '',
      fromName: map['fromName'] as String ?? '',
      createdAt: timeFromJson(map['createdAt']),
      type: map['type'] as int ?? 0,
      postID: map['postID'] as String ?? '',
      commentID: map['commentID'] as String ?? '',
    );
  }

  NotificationModel copyWith({
    String id,
    String toId,
    String fromId,
    String fromName,
    DateTime createdAt,
    int type,
    String postID,
    String commentID,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      toId: toId ?? this.toId,
      fromId: fromId ?? this.fromId,
      fromName: fromName ?? this.fromName,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      postID: postID ?? this.postID,
      commentID: commentID ?? this.commentID,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      toId,
      fromId,
      fromName,
      createdAt,
      type,
      postID,
      commentID,
    ];
  }
}

enum NotificationType { Follow, PostReaction, Comment, CommentReaction, Reply }
