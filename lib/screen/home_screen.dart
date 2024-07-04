import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Model untuk representasi produk kecantikan
class Produk {
  final String nama;
  final String deskripsi;
  final String image;

  Produk({
    required this.nama,
    required this.deskripsi,
    required this.image,
  });
}

// Daftar produk kecantikan
final List<Produk> daftarProduk = [
  Produk(
    nama: 'Serum Wajah A',
    deskripsi: 'Serum dengan formula khusus untuk kulit wajah cerah dan halus.',
    image: 'images/kosmetik1.jpeg',
  ),
  Produk(
    nama: 'Lipstik B',
    deskripsi: 'Lipstik matte dengan berbagai pilihan warna yang tahan lama.',
    image: 'images/kosmetik2.jpeg',
  ),
  Produk(
    nama: 'Masker C',
    deskripsi: 'Masker wajah untuk perawatan kulit kusam dan berminyak.',
    image: 'images/kosmetik3.jpeg',
  ),
  Produk(
    nama: 'Shampoo D',
    deskripsi: 'Shampoo untuk rambut kering dengan kandungan alami vitamin.',
    image: 'images/kosmetik4.jpeg',
  ),
  Produk(
    nama: 'Body Lotion E',
    deskripsi:
        'Body lotion dengan aroma segar dan melembapkan kulit sepanjang hari.',
    image: 'images/kosmetik5.jpeg',
  ),
];

// HomePage Widget
class HomePage extends StatelessWidget {
  final Cart keranjang = Cart(); // Inisialisasi keranjang belanja

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produk Kecantikan"),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HalamanKeranjang(keranjang: keranjang),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: daftarProduk.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    produk: daftarProduk[index],
                    keranjang: keranjang,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Image.asset(
                      daftarProduk[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          daftarProduk[index].nama,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          daftarProduk[index].deskripsi,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ProductDetailPage Widget
class ProductDetailPage extends StatelessWidget {
  final Produk produk;
  final Cart keranjang;

  const ProductDetailPage(
      {Key? key, required this.produk, required this.keranjang})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(produk.nama),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              produk.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              produk.nama,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              produk.deskripsi,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                keranjang.tambahkanKeKeranjang(produk);
                final snackBar = SnackBar(
                  content: Text('${produk.nama} ditambahkan ke keranjang'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('Tambahkan ke Keranjang'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HalamanKeranjang(keranjang: keranjang),
            ),
          );
        },
        child: Icon(Icons.shopping_cart),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}

// CartPage Widget
class HalamanKeranjang extends StatefulWidget {
  final Cart keranjang;

  const HalamanKeranjang({Key? key, required this.keranjang}) : super(key: key);

  @override
  _HalamanKeranjangState createState() => _HalamanKeranjangState();
}

class _HalamanKeranjangState extends State<HalamanKeranjang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang Belanja"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: ListView.builder(
        itemCount: widget.keranjang.items.length,
        itemBuilder: (context, index) {
          final item = widget.keranjang.items[index];
          return ListTile(
            title: Text(item.produk.nama),
            subtitle: Text('Jumlah: ${item.jumlah}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  widget.keranjang.hapusDariKeranjang(item.produk);
                });
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                // Implementasi logika checkout
                final snackBar = SnackBar(
                  content: Text('Checkout berhasil'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                setState(() {
                  widget.keranjang.items.clear();
                });
              },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}

// Kelas Cart dan CartItem
class CartItem {
  final Produk produk;
  int jumlah;

  CartItem({required this.produk, this.jumlah = 1});
}

class Cart {
  final List<CartItem> items = [];

  void tambahkanKeKeranjang(Produk produk) {
    // Periksa apakah produk sudah ada dalam keranjang
    for (var item in items) {
      if (item.produk.nama == produk.nama) {
        // Jika sudah ada, tambahkan jumlahnya
        item.jumlah++;
        return;
      }
    }
    // Jika belum ada, tambahkan item baru ke keranjang
    items.add(CartItem(produk: produk));
  }

  void hapusDariKeranjang(Produk produk) {
    items.removeWhere((item) => item.produk.nama == produk.nama);
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
