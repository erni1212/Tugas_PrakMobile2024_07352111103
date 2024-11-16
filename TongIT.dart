// Kelas ProdukDigital
class ProdukDigital {
  String namaProduk;
  double harga;
  String kategori;

  ProdukDigital(this.namaProduk, this.harga, this.kategori);

  void terapkanDiskon() {
    if (kategori == 'NetworkAutomation' && harga > 200000) {
      harga *= 0.85; // diskon 15%
      if (harga < 200000) harga = 200000; // Harga tidak boleh di bawah 200000
    }
  }
}

// Kelas Karyawan Abstrak
abstract class Karyawan {
  String nama;
  int umur;
  String peran;

  Karyawan(this.nama, this.umur, this.peran);

  void bekerja();
}

// Subclass KaryawanTetap
class KaryawanTetap extends Karyawan {
  KaryawanTetap(String nama, int umur, String peran) : super(nama, umur, peran);

  @override
  void bekerja() {
    print('$nama sedang bekerja pada hari kerja reguler.');
  }
}

// Subclass KaryawanKontrak
class KaryawanKontrak extends Karyawan {
  KaryawanKontrak(String nama, int umur, String peran) : super(nama, umur, peran);

  @override
  void bekerja() {
    print('$nama bekerja pada proyek tertentu.');
  }
}

// Mixin Kinerja
mixin Kinerja {
  int produktivitas = 90;

  void updateProduktivitas(int kenaikan) {
    if (kenaikan > 0) {
      produktivitas += kenaikan;
      if (produktivitas > 100) produktivitas = 100; // Maksimal 100
    }
  }
}

// Karyawan Manager yang menerapkan mixin Kinerja
class Manager extends Karyawan with Kinerja {
  Manager(String nama, int umur, String peran) : super(nama, umur, peran);

  @override
  void bekerja() {
    print('$nama sebagai Manager sedang memimpin tim.');
  }

  void updateProduktivitas(int kenaikan) {
    if (produktivitas + kenaikan >= 95) {
      super.updateProduktivitas(kenaikan);
    } else {
      print('Produktivitas Manager harus minimal 90.');
    }
  }
}

// Enum FaseProyek
enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

class Proyek {
  FaseProyek fase = FaseProyek.Perencanaan;
  int jumlahKaryawanAktif = 0;
  int hariBerjalan = 0;

  void beralihFase() {
    if (fase == FaseProyek.Perencanaan && jumlahKaryawanAktif >= 5) {
      fase = FaseProyek.Pengembangan;
      print('Proyek beralih ke fase Pengembangan.');
    } else if (fase == FaseProyek.Pengembangan && hariBerjalan > 45) {
      fase = FaseProyek.Evaluasi;
      print('Proyek beralih ke fase Evaluasi.');
    } else {
      print('Tidak memenuhi syarat untuk beralih fase.');
    }
  }
}

// Kelas Perusahaan untuk Pembatasan Jumlah Karyawan Aktif
class Perusahaan {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < 20) {
      karyawanAktif.add(karyawan);
    } else {
      print('Batas maksimal karyawan aktif tercapai.');
    }
  }

  void resignKaryawan(Karyawan karyawan) {
    if (karyawanAktif.contains(karyawan)) {
      karyawanAktif.remove(karyawan);
      karyawanNonAktif.add(karyawan);
    }
  }
}

void main() {
  // Penggunaan kelas ProdukDigital
  var produk1 = ProdukDigital('Sistem Manajemen Data', 180000, 'DataManagement');
  var produk2 = ProdukDigital('Sistem Otomasi Jaringan', 250000, 'NetworkAutomation');
  produk1.terapkanDiskon();
  produk2.terapkanDiskon();
  print('Harga produk2 setelah diskon: ${produk2.harga}');

  // Penggunaan kelas Karyawan dan subclass
  var karyawan1 = KaryawanTetap('Alice', 30, 'Developer');
  var karyawan2 = KaryawanKontrak('Fani', 28, 'NetworkEngineer');
  karyawan1.bekerja();
  karyawan2.bekerja();

  // Penggunaan mixin Kinerja
  var manager = Manager('Charlos', 40, 'Manager');
  manager.updateProduktivitas(20);
  print('Produktivitas manager: ${manager.produktivitas}');

  // Penggunaan enum FaseProyek
  var proyek = Proyek();
  proyek.jumlahKaryawanAktif = 8;
  proyek.beralihFase(); // Beralih ke Pengembangan
  proyek.hariBerjalan = 60;
  proyek.beralihFase(); // Beralih ke Evaluasi

  // Penggunaan kelas Perusahaan
  var perusahaan = Perusahaan();
  perusahaan.tambahKaryawan(karyawan1);
  perusahaan.tambahKaryawan(karyawan2);
  perusahaan.resignKaryawan(karyawan1);
  print('Jumlah karyawan aktif: ${perusahaan.karyawanAktif.length}');
  print('Jumlah karyawan non-aktif: ${perusahaan.karyawanNonAktif.length}');
}

