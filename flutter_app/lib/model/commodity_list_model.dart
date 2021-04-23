//商品列表model
class CommodityList {
  final int id;
  final String title;
  final String price;
  final String imageUrl;

  CommodityList(
    this.id,
    this.title,
    this.price,
    this.imageUrl,
  );

  CommodityList.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        price = json['price'],
        imageUrl = json['image_url'];

  Map toJson() => {
        'title': title,
      };
}
