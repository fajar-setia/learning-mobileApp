
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