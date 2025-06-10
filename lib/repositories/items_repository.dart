import 'dart:convert';
import 'dart:developer';

import 'package:alpha_twelve_task/models/item.dart';
import 'package:flutter/services.dart';

Future<dynamic> __readJson() async {
    try {
        final String response = await rootBundle.loadString('assets/jsons/test.json');

        return jsonDecode(response);
    } catch (e) {
        log("Error reading JSON file:", error: e);
    }
}

class ItemRepository{
    const ItemRepository();

    Future<List<Item>> all() async{
        try{
            final results = await __readJson();

            return (results as List).map((init)=> Item.fromJson(init)).toList();
        }catch(error){
            return Future.error(Exception('Failed to load'));
        }
    }

    Future<Item> get(String id) async{
        final items = await all();
        for (var item in items) {
            if(item.id == id){
                return item;
            }
        }
        
        return Future.error(Exception("item with $id not found"));
    }
}