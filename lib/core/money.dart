import 'package:intl/intl.dart';

/// App-wide currency symbol. Defaults to the Zambian Kwacha ("K"). Change this
/// single line (or, later, make it a user setting) to use another currency.
const String kCurrencySymbol = 'K';

final NumberFormat _money =
    NumberFormat.currency(symbol: '$kCurrencySymbol ', decimalDigits: 2);

/// Formats an amount for display, e.g. 1500.0 -> "K 1,500.00".
String formatMoney(double amount) => _money.format(amount);
