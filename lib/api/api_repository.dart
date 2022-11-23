import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:horecah/models/chats/chats.dart';
import 'package:horecah/models/chats/rooms_chats.dart';
import 'package:horecah/models/models.dart';
import 'package:horecah/models/multimedia.dart';
import 'package:horecah/models/prices/prices.dart';
import 'package:horecah/models/products/products.dart';
import 'package:horecah/models/response/users_response.dart';
import 'package:horecah/models/subcategory.dart';
import 'package:horecah/shared/constants/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});
  var storage = Get.find<SharedPreferences>();
  final ApiProvider apiProvider;

  Future<UserStrapi?> login(LoginRequest data) async {
    final res = await apiProvider.login('/auth/local', data);
    if (res.statusCode == 200) {
      return UserStrapi.fromJson(res.body);
    }
  }

  Future<UserStrapi?> register(RegisterRequest data) async {
    final res = await apiProvider.register('/auth/local/register', data);
    if (res.statusCode == 200) {
      return UserStrapi.fromJson(res.body);
    }
  }

  Future<UsersResponse?> getUsers() async {
    final res = await apiProvider.getUsers('/api/users?page=1&per_page=12');
    if (res.statusCode == 200) {
      return UsersResponse.fromJson(res.body);
    }
  }

  Future<UserStrapi?> getUser(String token) async {
    final res = await apiProvider.getWithAuth('/users/me', token);
    print("status Code!!!!!! ${res.statusCode}");
    if (res.statusCode == 200) {
      return UserStrapi.fromJsonUpdated(res.body);
    }
  }

  Future<UserStrapi?> getUserById(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.getWithAuth('/users/$id', token);
    if (res.statusCode == 200) {
      return UserStrapi.fromJsonUpdated(res.body);
    }
  }

  Future publishAd(Products products) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.post('/products', products.toJson(),
        headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      return res.body["id"];
    }
  }

  Future<Products?> updateProducthAd(Products products, int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.put('/products/$id', products.toJson(),
        headers: {"Authorization": "Bearer $token"});

    print("status code!! ${res.statusCode}");
    if (res.statusCode == 200) {
      print("UPDATE SUCCESFULL!!!");
     
      return Products.fromJson(res.body);
    }
  }

  Future<UserStrapi?> updateUserProfile(
      Map<String, dynamic> newUser, int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.put('/users/$id', jsonEncode(newUser),
        headers: {"Authorization": "Bearer $token"});

    print("status code!! ${res.statusCode}");
    if (res.statusCode == 200) {
      print("UPDATE PROFILE SUCCESFULL!!!");
       print("USER UPDATED!!!!!  ");
      print(res.body);
      return UserStrapi.fromJson2(res.body);
    }
  }

  Future changeProductStatus(Products products, int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.put('/products/$id', products.toJson(),
        headers: {"Authorization": "Bearer $token"});

    print("status code!! ${res.statusCode}");
    if (res.statusCode == 200) {
      return res.body["id"];
    }
  }

  Future updateProduct(Products products, int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.put('/products/$id', products.toJson(),
        headers: {"Authorization": "Bearer $token"});

    print("status code!! ${res.statusCode}");
    if (res.statusCode == 200) {
      print("UPDATE SUCCESFULL!!!");
      return res.body["id"];
    }
  }

  Future<Products> getProduct(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider
        .get('/products/$id', headers: {"Authorization": "Bearer $token"});

    print(res.body);
    final prod = Products.fromJsonForUpdate(res.body);
    return prod;
  }

  Future<Multimedia?> uploadImage(
      File image, String ref, String field, int id) async {
    final res = await apiProvider.uploadImage(image, ref, field, id);
    if (res.statusCode == 200) {
      return Multimedia.fromJson(res.body[0]);
    }
  }

  Future<List<Products>?> getPosts({String? category}) async {

    print("CATEGORY!!!! $category");
    String path = category == ""
        ? '/products?status=published'
        : '/products?status=published&sub_category.category.name_es=$category';
    print(path);
    final res = await apiProvider.get(path + '&_sort=created_at:DESC');

   

    if (res.statusCode == 200) {
      //print(res.statusCode);
     
      return Products.fromListJson(res.body);
    } else {
      print(res.statusCode);
    }
  }

  Future<List<Products>?> getRecentlyProducts(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    print("=======ID========= $id");

    final res = await apiProvider.get("/recently-seens?user=${id}",
        headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      return Products.fromListJson(res.body[0]["products"]);
    } else {
     return <Products>[];
    }
  }

  addToRecentlyProducts(int productId) async {

    String? token = storage.getString(StorageConstants.token);

    if(token == null)
      return false;

    final res = await apiProvider.get("/recently-seens/add/$productId",
        headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      print("============ADDED TO FAVORITES!!!!!");
      return true;
      
      //return Products.fromListJson(res.body[0]["products"]);
    } else {
      print("=======NOT ADDED TO FAVORITE====");
      return false;
    }
  }

  Future<List<Category>> getAllCategories() async {
    String path = "/categories";
    final res = await apiProvider.get(path + '?_sort=created_at:DESC');
    print("=============CATEGORIES   ${res.body}");
    return Category.fromListJson(res.body);
  }

  Future<List<SubCategory>> getSubCategoriesByCategory(String category) async {
    String path = "/sub-categories?category.name_es=$category";
    final res = await apiProvider.get(path + '&_sort=created_at:DESC');
    //print("SUBCATS: ${res.body}");
    return SubCategory.fromListJson(res.body);
  }

  Future<List<SubCategory>> getSubCategoriesForPost(
      String nameSubCat, String lang) async {
   /* print("name subcat   $nameSubCat");
    String field = lang == "en_US"
        ? "name_en"
        : lang == "it_IT"
            ? "name_it"
            : "name_es";*/
    String path = "/sub-categories?name_en=$nameSubCat";
    //print("Path!!!! $path");
    final res = await apiProvider.get(path + '&_sort=created_at:DESC');
    //print("SUBCATS: ${res.body}");
    return SubCategory.fromListJson(res.body);
  }

  Future<List<Products>?> getAllPosts({String? category}) async {
    String token = storage.getString(StorageConstants.token)!;
    String path = category == ''
        ? '/products?_sort=created_at:DESC'
        : '/products?category=$category&_sort=created_at:DESC';

    final res = await apiProvider
        .get(path, headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      print("======ALL PRODUCTS =======");
      print(res.statusCode);
      return Products.fromListJson(res.body);
      
    }
  }

  Future<List<Products>?> getAllPostsDraftPublished() async {
    String token = storage.getString(StorageConstants.token)!;
    String path = '/products?_sort=created_at:DESC&_publicationState=preview';

    final res = await apiProvider.get(
      path,
    );


    print("==========RES DRAFT & PUBLISHED PRODUCTS ============");
    print(res.statusCode);


    if (res.statusCode == 200) {
      print(res.body);
      return Products.fromListJson(res.body);
    }
  }

  Future<Products?> getPostsById(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider
        .get('/products/?id=$id', headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      return Products.fromJson(res.body[0]);
    }
  }

  Future<Likes?> addProductLike(Likes like) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.post('/likes', like.toJson(),
        headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      return Likes.fromJsonIds(res.body);
    }
  }

  Future<Likes?> removeProductLike(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider
        .delete('/likes/$id', headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      return Likes.fromJsonIds(res.body);
    }
  }

  Future<List<Products>?> getProductsLiked(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider
        .get('/likes?user.id=$id', headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      List<Products> posts = [];
      //print(res.body);
      for (var likeItem in res.body) {
        likeItem['product']['user'] = null;
        print("Lieks in product: ${likeItem['product']['likes']}");
        likeItem['product']['likes'] = [
          {
            'id': likeItem['id'],
            'product': likeItem['product']['id'],
            'user': likeItem['user']['id'],
            'created_at': likeItem['created_at'],
            'updated_at': likeItem['updated_at'],
          }
        ];
        posts.add(Products.fromJson(likeItem['product']));
      }
      // for (int i = 0; i < res.body.length; i++){
      //   res.body[i]['product']['user'] = getUserById(res.body[i]['product']['user']);
      // }
      // return Likes.fromListJsonGetProducts(res.body);

      return posts;
    }
  }

  Future<List<RoomsChats>?> getRooms(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.get(
        '/rooms-chats?_sort=created_at:DESC&_where[0][users_room.id]=$id',
        headers: {"Authorization": "Bearer $token"});

    //print(res.body);
    if (res.statusCode == 200) {
      //print("rooms:  ${res.body}");
      return RoomsChats.fromListJson(res.body);
    }
  }

  Future<List<Chats>?> getChat(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider
        .get('/chats?room.id=$id', headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      return Chats.fromListJson(res.body);
    }
  }

  Future<Chats?> sendMessage(Chats message) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.post('/chats', message.toJson(),
        headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      return Chats.fromJson(res.body);
    }
  }

  Future<RoomsChats?> createRoom(RoomsChats roomsChats) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.post('/rooms-chats', roomsChats.toJson(),
        headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      res.body['product']['user'] = null;
      return RoomsChats.fromJson(res.body);
    }
  }

  Future<List<Products>?> getPostsByFilter(String filter) async {
    print("FILTER!!! /products?status=published$filter");
    final res = await apiProvider.get('/products?status=published$filter');
    if (res.statusCode == 200) {
      print(res.body);
      return Products.fromListJson(res.body);
    } else {
      print(res.statusCode);
    }
  }

  Future<Multimedia?> removeImage(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.delete('/upload/files/$id',
        headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      return Multimedia.fromJson(res.body);
    }
  }

  Future<Products?> removeProduct(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider
        .delete('/products/$id', headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      //return Products.fromJson(res.body);
    }
  }

  Future<Prices> getPrices() async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider
        .get("/prices", headers: {"Authorization": "Bearer $token"});
    return Prices.fromJson(res.body[0]);
  }

  Future<String> getUrlCheckout(int option, int productId) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.post(
        "/purchases/payment", {"product": productId, "option": option},
        headers: {"Authorization": "Bearer $token"});
    return res.body['url'];
  }

  Future<bool> confirmCheckout(String endpoint) async {
    String token = storage.getString(StorageConstants.token)!;
    final response = await apiProvider
        .get(endpoint, headers: {"Authorization": "Bearer $token"});

    if (response.hasError) return false;

    return true;
  }

  Future<bool> forgotPassword(String userEmail) async {
    final map = {"email": userEmail};
    final res =
        await apiProvider.post("/auth/forgot-password", jsonEncode(map));
    if (res.statusCode == 200) {
      print(res.body);
      return true;
    } else {
      print(res.body);
      return false;
    }
  }

  Future<bool> resetPassword(
      String code, String password, String passwordConfirmation) async {
    final map = {
      "code": code,
      "password": password,
      "passwordConfirmation": passwordConfirmation
    };
    final res = await apiProvider.post("/auth/reset-password", jsonEncode(map));
    if (res.statusCode == 200) {
      print(res.body);
      return true;
    } else {
      print(res.body);
      return false;
    }
  }
}
