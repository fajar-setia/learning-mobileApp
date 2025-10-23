
class AppFeaturesImage {
  static const String layanan = 'assets/assets_feature/pet_service.png';
  static const String produk = 'assets/assets_feature/fitur_produk.png';
  static const String informasi = 'assets/assets_feature/article_pet.png';
  static const String adopsi = 'assets/assets_feature/adopt_hewan.png';
  static const String grooming = 'assets/assets_feature/grooming.png';
  static const String klinik = 'assets/assets_feature/klinik_pet.png';
  static const String penitipan = 'assets/assets_feature/penitipan_hewan.png';

  //logo
  static const String logo = 'assets/assets_feature/logo_petshop.png';

  //background app
  static const String bg = 'assets/assets_feature/background_app.png';

  //banner
  static const String banner = 'assets/assets_feature/banner_bg.png';

  //banner promo
  static const String promo1 = 'assets/assets_banner/banner_promo1.png';
  static const String promo2 = 'assets/assets_banner/banner_promo2.png';
  static const String promo3 = 'assets/assets_banner/banner_promo3.png';
  static const String promo4 = 'assets/assets_banner/banner_promo4.png';

  //bg login dan sign up
  static const String bg_login = 'assets/assets_bg_login/bg_login.jpg';
  static const String logo_remove = 'assets/assets_bg_login/logo_remove.png';

}

class AppFeature {
  static final List<Map<String, dynamic>> list = [
    {
      'gambar': AppFeaturesImage.produk,
      'title': 'Product',
      'route': '/product'
    },
    {
      'gambar': AppFeaturesImage.layanan,
      'title': 'Layanan',
      'route': '/layanan'
    },
    {
      'gambar': AppFeaturesImage.penitipan,
      'title': 'Penitipan Pet',
      'route': '/penitipan'
    },
    {
      'gambar': AppFeaturesImage.klinik,
      'title': 'Klinik',
      'route': '/klinik'
    },
    {
      'gambar': AppFeaturesImage.adopsi,
      'title': 'Adopsi',
      'route': '/adopsi'
    },
    {
      'gambar': AppFeaturesImage.grooming,
      'title': 'Grooming',
      'route': '/grooming'
    },
    {
      'gambar': AppFeaturesImage.informasi,
      'title': 'Informasi',
      'route': '/informasi'
    },
  ];
}

class AppBanner {
  static final List<Map<String, dynamic>> list = [
    {
      'gambar':AppFeaturesImage.promo1
    },
    {
      'gambar':AppFeaturesImage.promo2
    },
    {
      'gambar':AppFeaturesImage.promo3
    },
    {
      'gambar':AppFeaturesImage.promo4
    }
  ];
}