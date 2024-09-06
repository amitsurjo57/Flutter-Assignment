import 'package:flutter/cupertino.dart';
import 'total_amount.dart';
import 'total_amount_list.dart';

class TotalAmountCount extends ChangeNotifier{
  int totalAmountCount(){
    int count = 0;
    for(TotalAmount t in TotalAmountList().totalAmountList){
      count += t.totalAmount;
    }
    notifyListeners();
    return count;
  }
}