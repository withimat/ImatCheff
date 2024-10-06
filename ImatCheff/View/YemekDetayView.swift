//
//  YemekDetayView.swift
//  ImatCheff
//
//  Created by İmat Gökaslan on 3.10.2024.
//


import SwiftUI


struct YemekDetayView: View {
    @ObservedObject var viewmodel = YemekDetayModelView()
    @State var countsayisi = 1
    @State var itemsayisi = 0
    var yemekk = Yemek()
    var body: some View {
        NavigationView {
            VStack(alignment:.center,spacing:30){
                Text(yemekk.yemek_adi!)
                    .font(.system(size: 30))
                    .fontWeight(.thin)
                    
                Text("₺ \(yemekk.yemek_fiyat!)")
                    .font(.system(size: 25))
                
                AsyncImage(url: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemekk.yemek_resim_adi!)"))
                    .frame(width: 300,height: 300)
                
                HStack(spacing:20){
                    Button(action: {
                        if countsayisi != 1{
                            countsayisi -= 1
                        }
                        
                    }, label: {
                        Image(systemName: "minus")
                            .frame(width: 40,height: 40)
                            .background(.orange.opacity(0.8))
                            .cornerRadius(4)
                            .shadow(radius: 5)
                    })
                    Text("\(countsayisi)")
                        .font(.title2)
                    Button(action: {
                        if countsayisi != 10{
                            countsayisi += 1
                        }
                    }, label: {
                        Image(systemName: "plus")
                            .frame(width: 40,height: 40)
                            .background(.orange.opacity(0.8))
                            .cornerRadius(4)
                            .shadow(radius: 5)
                    })
                }
                
                
                
                HStack(spacing:10){
                    Text("Ücretsiz Teslimat")
                        .frame(width: 100,height: 40)
                        .font(.system(size: 8))
                        .foregroundColor(.white)
                        .background(.gray)
                        .clipShape(Capsule())
                    
                    Text("Canlı Destek")
                        .frame(width: 100,height: 40)
                        .font(.system(size: 8))
                        .foregroundColor(.white)
                        .background(.gray)
                        .clipShape(Capsule())
                    Text("%20 indirim")
                        .frame(width: 100,height: 40)
                        .font(.system(size: 8))
                        .foregroundColor(.white)
                        .background(.gray)
                        .clipShape(Capsule())
                }
                
                Spacer()
                
                Button(action: {
                    self.itemsayisi += 1
                    viewmodel.SepeteEkle(yemek_adi: yemekk.yemek_adi!, yemek_resim_adi: yemekk.yemek_resim_adi!, yemek_fiyat: Int(yemekk.yemek_fiyat!)!, yemek_siparis_adet: countsayisi, kullanici_adi: "imat")
                    
                    
                }, label: {
                    HStack{
                        Text("SEPETE EKLE ")
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                        Image(systemName: "cart")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .frame(width: 220,height: 50)
                    .background(.orange.opacity(0.8))
                    .cornerRadius(10)
                    
                    
                })
                
                Spacer()
                
               
            }
            .toolbar{
                ToolbarItem {
                    
                    NavigationLink(destination: SepetView()) {
                        ZStack {
                            Image(systemName: "cart")
                                .font(.title)
                            .foregroundColor(.black)
                            
                            if (itemsayisi != 0) {
                                Circle()
                                    .fill(.orange.opacity(0.8))
                                    .frame(width: 14,height: 14,alignment: .center)
                                    .offset(x: 13,y: -10)
                            }
                            
                                
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    YemekDetayView(yemekk: Yemek(yemek_id: "1", yemek_adi: "pizza", yemek_resim_adi: "pizza", yemek_fiyat: "2"))
}
