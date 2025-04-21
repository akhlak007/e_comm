import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String _currentLocation = 'New York, USA';
  String get currentLocation => _currentLocation;

  void updateLocation(String location) {
    _currentLocation = location;
    notifyListeners();
  }

  // Timer for flash sale
  int _hours = 2;
  int _minutes = 12;
  int _seconds = 56;

  int get hours => _hours;
  int get minutes => _minutes;
  int get seconds => _seconds;

  bool _isTimerActive = true;
  bool get isTimerActive => _isTimerActive;

  void startTimer() {
    if (_isTimerActive) {
      Future.delayed(const Duration(seconds: 1), () {
        if (_seconds > 0) {
          _seconds--;
        } else {
          if (_minutes > 0) {
            _minutes--;
            _seconds = 59;
          } else {
            if (_hours > 0) {
              _hours--;
              _minutes = 59;
              _seconds = 59;
            } else {
              _isTimerActive = false;
            }
          }
        }
        notifyListeners();
        if (_isTimerActive) startTimer();
      });
    }
  }

  // Selected category index
  int _selectedCategoryIndex = -1;
  int get selectedCategoryIndex => _selectedCategoryIndex;

  void selectCategory(int index) {
    if (_selectedCategoryIndex == index) {
      _selectedCategoryIndex = -1;
    } else {
      _selectedCategoryIndex = index;
    }
    notifyListeners();
  }

  // Selected flash sale filter
  int _selectedFlashSaleFilter = 0;
  int get selectedFlashSaleFilter => _selectedFlashSaleFilter;

  void selectFlashSaleFilter(int index) {
    _selectedFlashSaleFilter = index;
    notifyListeners();
  }

  // Current bottom navigation tab
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  void setTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }
}