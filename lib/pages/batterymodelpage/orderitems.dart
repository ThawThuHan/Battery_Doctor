class Item {
  final String model;
  final String imgUrl;
  final int price;
  final int qty;

  Item({
    this.model,
    this.imgUrl,
    this.price,
    this.qty,
  });
}

class OrderItems {
  List<Item> cartItems = [];

  addItem({Item item}) {
    cartItems.add(item);
  }

  removeItem({Item item}) {
    cartItems.remove(item);
  }
}
