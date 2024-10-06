//
//  SepetItemView.swift
//  ImatCheff
//
//  Created by İmat Gökaslan on 3.10.2024.
//
import SwiftUI

struct SepetItemView: View {
    var yemek: Sepet_yemekler
    @ObservedObject var viewmodel = SepetItemViewModel()
    @State var toplam : Int?
    var body: some View {
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
            .frame(width: 100, height: 100)

            // Yemek Bilgileri
            VStack(alignment: .leading, spacing: 10) {
                if let yemekAdi = yemek.yemek_adi {
                    Text(yemekAdi)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("Fiyat:")
                    if let yemekFiyat = yemek.yemek_fiyat {
                        Text("\(yemekFiyat)")
                            .fontWeight(.semibold)
                    }
                }
                HStack {
                    Text("Adet:")
                    if let yemekSiparisAdet = yemek.yemek_siparis_adet {
                        Text("\(yemekSiparisAdet)")
                            .fontWeight(.semibold)
                    }
                }
            }

            Spacer() // Öğeleri düzgün yaymak için Spacer ekleniyor

            // Yemek Toplam Fiyat ve Silme Butonu
            VStack(spacing: 30) {
                Button(action: {
                    viewmodel.sil(sepet_yemek_id: Int(yemek.sepet_yemek_id!)!, kullanici_adi: "imat")
                    
                }, label: {
                    Image(systemName: "trash")
                        .foregroundColor(.orange.opacity(0.7))
                        .font(.system(size: 20))
                })

                if let fiyatStr = yemek.yemek_fiyat,
                   let adetStr = yemek.yemek_siparis_adet,
                   let fiyat = Int(fiyatStr),
                   let adet = Int(adetStr) {
                    Text("$ \(fiyat * adet)")
                        .fontWeight(.semibold)
                }
            }
            .padding(.trailing, 10)
        }
        .onAppear(){
            topla()
            print("\(toplam!)")
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
    }
    
    
    func topla() {
        if let fiyatStr = yemek.yemek_fiyat,
           let adetStr = yemek.yemek_siparis_adet,
           let fiyat = Int(fiyatStr),
           let adet = Int(adetStr){
            toplam = fiyat*adet
        }
       
    }
    
    
}

#Preview {
    SepetItemView(yemek: Sepet_yemekler(sepet_yemek_id: "1", sepet_adi: "pizza", yemek_resim_adi: "baklava.png", yemek_fiyat: "11", yemek_siparis_adet: "5", kullanici_adi: "IMAT"))
}
