import 'package:currx/controllers/crypto_controller.dart';
import 'package:currx/pages/crypto_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CryptoTab extends StatelessWidget {
  const CryptoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final CryptoController controller = Get.put(CryptoController());

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(26.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (query) {
                      controller.updateSearchQuery(
                          query); // Arama kutusuna yazıldıkça filtreleniceek.
                    },
                    decoration: InputDecoration(
                      hintText: 'İsim veya Kod ile arayın',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: controller.searchQuery.value.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                controller.updateSearchQuery('');
                              },
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
        child: Obx(() {
          //* Veri boş ise bu ayzacak
          if (controller.filteredList.isEmpty) {
            return const Center(child: Text('Veri Yok'));
          }

          return ListView.builder(
            itemCount: controller.filteredList.length,
            itemBuilder: (context, index) {
              final crypto = controller.filteredList[index];
              final changeColor =
                  crypto.changeDay < 0 ? Colors.red : Colors.green;

              return Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red[500],
                    child: Text(
                      crypto.code.length > 4
                          ? crypto.code
                              .substring(0, 4) //* İlk 4 harfi gösteriyoruz
                          : crypto.code,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    crypto.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    crypto.code,
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w700),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${crypto.pricestr} USD',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${crypto.changeDaystr}%',
                        style: TextStyle(
                          color: changeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.to(() => CryptoDetailPage(crypto: crypto));
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
