import 'package:intl/intl.dart';

class StringHelper {
  static String currency(int amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(amount);
  }
}
