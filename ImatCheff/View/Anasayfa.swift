//
//  Anasayfa.swift
//  ImatCheff
//
//  Created by İmat Gökaslan on 3.10.2024.
//

import SwiftUI
import Lottie


struct Anasayfa: View {
    @ObservedObject var anasayfaviewmodel = AnasayfaViewModel()
    @State private var aramaMetni = "" // Arama sorgusu için state
    @State private var aramaAktif = false // Arama çubuğunun aktif olup olmadığını takip eden state
    
    var body: some View {
        GeometryReader { geo in
            let ekranGenislik = geo.size.width
            let itemGenislik = (ekranGenislik-50)/2
            
            NavigationStack {
                VStack {
                    NavBarDetailView(aramaAktif: $aramaAktif)
                    Divider()
                    
                    // Arama çubuğunu yalnızca aramaAktif true olduğunda göster
                    if aramaAktif {
                        // Arama kutusu
                        TextField("Yemek Ara", text: $aramaMetni)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                    }
                    
                    // Arama kutusu ve sonuçları filtrele
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(filteredYemekListesi) { yemek in
                                NavigationLink {
                                    YemekDetayView(yemekk: yemek)
                                } label: {
                                    YemekItemView(yemek: yemek, genislik: itemGenislik)
                                }
                            }
                        }
                    }
                    .padding(10)
                }
            }
            .onAppear(){
                anasayfaviewmodel.veriYukle()
            }
        }
    }
    
    // Yemek listesini arama metnine göre filtreleme
    var filteredYemekListesi: [Yemek] {
        if aramaMetni.isEmpty {
            return anasayfaviewmodel.yemekListesi
        } else {
            return anasayfaviewmodel.yemekListesi.filter { yemek in
                yemek.yemek_adi?.lowercased().contains(aramaMetni.lowercased()) ?? false
            }
        }
    }
}



#Preview {
    Anasayfa()
}
