// ignore: file_names
class ProductDataModel {
  //data Type
  int? id;
  String? name;
  String? category;
  String? imageURL;
  String? Lokasi ;
  String? price ;
  String? MenuUrl;

// constructor
  ProductDataModel(
      {this.id,
        this.name,
        this.category,
        this.imageURL,
        this.Lokasi ,
        this.price,
        this.MenuUrl
      });

  //method that assign values to respective datatype vairables
  ProductDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    imageURL = json['imageUrl'];
    Lokasi  = json['Lokasi'];
    price  = json['price'];
    MenuUrl = json['MenuUrl'];
  }
}