// To parse this JSON data, do
//
//     final roomsChats = roomsChatsFromJson(jsonString);

import 'package:horecah/models/chats/chats.dart';
import 'package:horecah/models/models.dart';
import 'package:horecah/models/products/products.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<RoomsChats> roomsChatsFromJson(String str) => List<RoomsChats>.from(json.decode(str).map((x) => RoomsChats.fromJson(x)));

String roomsChatsToJson(List<RoomsChats> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomsChats {
    RoomsChats({
        this.id,
        this.createdAt,
        this.updatedAt,
        required this.product,
        this.usersRoom,
    });

    int? id;
    DateTime? createdAt;
    DateTime? updatedAt;
    Products? product;
    List<UserStrapi>? usersRoom;
    List<Chats>? chats;

    factory RoomsChats.fromJson(Map<String, dynamic> json) => RoomsChats(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: json["product"].length > 1 ? Products.fromJsonForChat(json["product"]) : null,
        usersRoom: List<UserStrapi>.from(json["users_room"].map((x) => UserStrapi.fromJsonUpdated(x))),
    );
    Map<String, dynamic> toJson() => {
        // "id": id,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        "product": product!.id,
        "users_room": List<dynamic>.from(usersRoom!.map((x) => x.id)),
    };
    static List<RoomsChats> fromListJson(List<dynamic> listRoomChats) {
      List<RoomsChats> roomsChats = [];
      for (var item in listRoomChats) {
        item['product']['user'] = null;
        roomsChats.add(RoomsChats.fromJson(item));
      }
      return roomsChats;
    }
}
