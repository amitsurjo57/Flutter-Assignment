class Item {
  final String name;
  final String id;
  final String code;
  final String price;
  final String quantity;
  final String totalPrice;
  final void Function()? onEdit;
  final void Function()? onDelete;

  Item({
    required this.name,
    required this.id,
    required this.code,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    this.onEdit,
    this.onDelete,
  });
}
