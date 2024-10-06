import SwiftUI
import Lottie

struct SepetView: View {
    @ObservedObject var viewmodel = SepetViewModel() // ViewModel
    @State private var toplam = 0 // Toplam değişkeni
    @State private var refreshID = UUID() // Sayfayı yenilemek için

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Text("SEPETİM")
                    .foregroundColor(.orange.opacity(0.7))
                    .font(.title2)
                    .fontWeight(.semibold)
                
                // Sepet boş mu değil mi kontrolü
                if viewmodel.yemeklistesi.isEmpty {
                    // Sepet boşken gösterilecek görünüm
                    VStack(spacing: 20) {
                        if let url = URL(string: "https://lottie.host/b012dc97-6109-4a96-b1fa-0a2c683d0987/seY4xgJ8PK.json") {
                            LottieView(animationUrl: url)
                                .frame(width: 300)
                            }
                        Text("Sepetiniz şu anda boş.")
                            .offset(y:-200)
                            .font(.title3)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding()
                }
                    
                else {
                    ScrollView {
                        Divider()
                        ForEach(viewmodel.yemeklistesi) { yemek in
                            HStack(spacing: 20) {
                                // Yemek Resmi
                                AsyncImage(url: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi ?? "")")) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                } placeholder: {
                                    ProgressView()
                                }

                                // Yemek Bilgileri
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(yemek.yemek_adi ?? "Yemek")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                    VStack (alignment:.leading){
                                        Text("Fiyat: \(yemek.yemek_fiyat ?? "0") ₺")
                                        Text("Adet: \(yemek.yemek_siparis_adet ?? "0")")
                                    }
                                }

                                Spacer()

                                // Toplam Fiyat ve Silme Butonu
                                VStack {
                                    Button(action: {
                                        viewmodel.sil(sepet_yemek_id: Int(yemek.sepet_yemek_id!)!, kullanici_adi: "imat")
                                        // Listeyi anında güncelle
                                        viewmodel.yemeklistesi.removeAll { $0.sepet_yemek_id == yemek.sepet_yemek_id }
                                        calculateTotal() // Toplamı hemen yeniden hesapla
                                    }) {
                                        Image(systemName: "trash")
                                            .font(.system(size: 20))
                                    }
                                    let fiyat = Int(yemek.yemek_fiyat ?? "0") ?? 0
                                    let adet = Int(yemek.yemek_siparis_adet ?? "0") ?? 0
                                    let yemekToplam = fiyat * adet
                                    Text("\(yemekToplam) ₺")
                                        .fontWeight(.semibold)
                                }
                                .padding(.trailing, 10)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.8))
                            .cornerRadius(15)
                        }
                        .padding(.horizontal)
                    }

                    VStack(spacing: 20) {
                        HStack {
                            Text("Gönderim Ücreti")
                                .fontWeight(.thin)
                            Spacer()
                            Text("0 ₺")
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Toplam")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(toplam) ₺")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                            // Sepeti onaylama işlemleri
                        }) {
                            Text("SEPETİ ONAYLA")
                        }
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(width: 220, height: 40)
                        .background(.orange.opacity(0.6))
                        .cornerRadius(10)
                    }
                }

                Spacer()
            }
            .id(refreshID) // Sayfayı yeniden yüklemek için ID'yi değiştiriyoruz
            .onAppear {
                viewmodel.SepettekiYemekleriGetir(kullanici_adi: "imat")
                calculateTotal() // Toplamı hesapla
            }
            .onChange(of: viewmodel.yemeklistesi) {
                calculateTotal() // Yemek listesi değiştiğinde toplamı hesapla
                
                // Eğer 1 ya da 0 öğe varsa, sayfayı yenile
                if viewmodel.yemeklistesi.count == 0 {
                    refreshID = UUID() // ID'yi değiştirerek sayfayı yeniden yüklüyoruz
                }
            }
        }
    }

    // Toplam hesaplama fonksiyonu
    private func calculateTotal() {
        toplam = viewmodel.yemeklistesi.reduce(0) { total, yemek in
            let fiyat = Int(yemek.yemek_fiyat ?? "0") ?? 0
            let adet = Int(yemek.yemek_siparis_adet ?? "0") ?? 0
            return total + (fiyat * adet)
        }
    }
}

#Preview {
    SepetView()
}

