import SwiftUI

struct YemekItemView: View {
    @ObservedObject var viewmodel = YemekItemViewModel()
    var yemek = Yemek()
    var genislik = 0.0
    @State var countsayisi = 1
    @State var isAnimating: Bool = false
    
    var body: some View {
        VStack(spacing: 5) {
            // Opsiyonel binding ile resim adını güvenli bir şekilde çözümle
            if let resimAdi = yemek.yemek_resim_adi,
               let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(resimAdi)") {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: genislik, height: 200)
                            .cornerRadius(8)
                            .shadow(radius: 5)
                    case .failure(_):
                        // Resim yüklenemezse gösterilecek görsel
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: genislik, height: 200)
                            .foregroundColor(.gray)
                    case .empty:
                        // Yükleme sırasında gösterilecek
                        ProgressView()
                            .frame(width: genislik, height: 200)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                // Geçersiz veya boş resim adı durumunda
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: genislik, height: 200)
                    .foregroundColor(.gray)
            }

            HStack {
                Text(yemek.yemek_adi ?? "Yemek Adı")
                    .fontWeight(.semibold)
                Spacer()
            }
            .foregroundColor(.orange)
            .padding(.horizontal)
            .padding(.bottom)
            .offset(y: isAnimating ? 0 : -200)
            .animation(.easeIn(duration: 2), value: isAnimating)

            HStack(alignment: .center) {
                Text("\(yemek.yemek_fiyat ?? "0") ₺")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .padding(.bottom, 10)
                    .padding(.leading, 10)

                Button(action: {
                    viewmodel.SepeteEkle(yemek_adi: yemek.yemek_adi!, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: Int(yemek.yemek_fiyat!)!, yemek_siparis_adet: countsayisi, kullanici_adi: "imat")
                    print("\(yemek.yemek_adi!) sepete eklendi")
                }, label: {
                    Text("Sepete Ekle")
                        .padding(10)
                        .background(.black.opacity(0.7))
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .frame(height: 35)
                        .border(Color.orange.opacity(0.6), width: 2)
                        .cornerRadius(5)
                        .italic()
                        .padding(.bottom, 10)
                })
            }
        }
        .background(Rectangle().fill(Color.white).shadow(radius: 3))
        .border(Color.orange.opacity(0.7), width: 1)
        .cornerRadius(4)
        .onAppear {
            withAnimation(.easeInOut(duration: 2.5)) {
                isAnimating.toggle()
            }
        }
    }
}

#Preview {
    YemekItemView(yemek: Yemek(yemek_id: "", yemek_adi: "Pizza", yemek_resim_adi: "kofte.png", yemek_fiyat: "150"), genislik: 300)
}
