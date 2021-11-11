// ignore_for_file: deprecated_member_use

import 'package:flutternews/model/categorymodel.dart';

List<CategoryModel> getCategories() {
  // new list
  List<CategoryModel> categories = List<CategoryModel>();
  CategoryModel category = CategoryModel();

  category = new CategoryModel();
  category.categoryName = "General";
  category.imageUrl =
      'https://images.unsplash.com/photo-1495020689067-958852a7765e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60';
  categories.add(category);

  category = new CategoryModel();
  category.categoryName = "Health";
  category.imageUrl =
      "https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80";
  categories.add(category);

  category = new CategoryModel();
  category.categoryName = "Science";
  category.imageUrl =
      "https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80";
  categories.add(category);

  return categories;
}
