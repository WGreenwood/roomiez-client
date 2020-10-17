import 'package:roomiez/models/bills/bill.dart';

class BillsPageViewModel {
  final bool isLoading;
  final Map<int, Bill> bills;

  BillsPageViewModel({this.isLoading, this.bills});
}