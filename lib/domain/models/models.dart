// ignore_for_file: public_member_api_docs, sort_constructors_first
class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;
  SliderViewObject({
    required this.sliderObject,
    required this.numOfSlides,
    required this.currentIndex,
  });

}

//login models
class Customer{
  String id;
  String name;
  int numOfNotifications;
  Customer(this.id,this.name,this.numOfNotifications);
}
class Contacts{
  String phone;
  String email;
  String link;
  Contacts(this.phone,this.email,this.link);
}
class Authentication{
  Customer? customer;
  Contacts? contacts;
  Authentication(this.customer,this.contacts);
}
//home
class Service{
  int id;
  String title;
  String image;
  Service(this.id,this.title,this.image);
}
class Store{
  int id;
  String title;
  String image;
  Store(this.id,this.title,this.image);
}
class BannerAd{
  int id;
  String title;
  String image;
  String link;
  BannerAd(this.id,this.title,this.image,this.link);
}
class HomeData{
  List<Service> services;
  List<Store> stores;
  List<BannerAd> banners;
  HomeData(this.services,this.stores,this.banners);
}
class HomeObject{
  HomeData data;
  HomeObject(this.data);
}