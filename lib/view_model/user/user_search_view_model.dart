import 'dart:developer';
import 'package:be_life_style/model/user_model/user_search_model.dart';
import 'package:be_life_style/repo/user/user_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:flutter/material.dart';

class UserSearchViewModel with ChangeNotifier {
  final UserRepo userRepo;
  
  UserSearchViewModel({required this.userRepo}) {
    searchController = TextEditingController();
  }

  final List<UserSearchModel> _searchResults = [];
  List<UserSearchModel> get searchResults => _searchResults;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  
  late final TextEditingController searchController;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> searchUsers(String query) async {
    if (query.trim().isEmpty) {
      _searchResults.clear();
      notifyListeners();
      return;
    }

    setLoading(true);
    try {
      final results = await userRepo.searchUsers(query, SessionController().token);
      _searchResults.clear();
      _searchResults.addAll(results);
      notifyListeners();
    } catch (e) {
      log('Error searching users: $e');
      _searchResults.clear();
      notifyListeners();
    } finally {
      setLoading(false);
    }
  }

  void clearSearch() {
    _searchQuery = '';
    _searchResults.clear();
    searchController.clear();
    notifyListeners();
  }
}
