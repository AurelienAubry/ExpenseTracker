class Transaction {
  final int id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  // final TransactionCategory category;

  Transaction({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    // required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'date': date.microsecondsSinceEpoch,
      // 'category': category.toString()
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      amount: double.tryParse(map['amount']) ?? 0.0,
      date: DateTime.fromMicrosecondsSinceEpoch(map['date']),
      // category: map['category']
    );
  }
}
