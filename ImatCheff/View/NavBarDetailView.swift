//
//  NavBarDeetailView.swift
//  ImatCheff
//
//  Created by İmat Gökaslan on 3.10.2024.
//


import SwiftUI
import Lottie

struct NavBarDetailView: View {
    @ObservedObject var anasayfaviewmodel = AnasayfaViewModel()
    @State var itemsayisi = 0
    //MARK: - PROPERTIES
    @State private var isAnimated: Bool = false
    @Binding var aramaAktif: Bool // Arama çubuğunu tetiklemek için Binding
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            HStack {
                Button(action: {
                    // Arama butonuna basıldığında arama çubuğunu göster/gizle
                    aramaAktif.toggle()
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                        .foregroundColor(.orange.opacity(0.7))
                })//: BUTTON:
                
                Spacer()
                VStack {
                    HStack {
                        Text("CHEFF")
                            .font(.title3)
                            .fontWeight(.heavy)
                        if let url = URL(string: "https://lottie.host/7b544226-34be-408d-bd79-3c2d64177a61/lVB0KzaGTV.json") {
                            LottieView(animationUrl: url)
                                .frame(width: 70, height: 70)
                        }
                        Text("IMAT")
                            .font(.title3)
                            .fontWeight(.heavy)
                    }
                }
                .opacity(isAnimated ? 1 : 0)
                .offset(x: 0, y: isAnimated ? 0 : -25)
                .onAppear() {
                    withAnimation(.easeOut(duration: 2)) {
                        isAnimated.toggle()
                    }
                }
                Spacer()
                
                // NavigationLink to SepetView
                NavigationLink(destination: SepetView()) {
                    ZStack {
                        Image(systemName: "cart")
                            .font(.title)
                            .foregroundColor(.orange.opacity(0.7))
                        
                        if  itemsayisi > 0 {
                            Circle()
                                .fill(.orange.opacity(0.8))
                                .frame(width: 14, height: 14, alignment: .center)
                                .offset(x: 13, y: -10)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }//: NAVIGATIONVIEW
        .frame(height: 70)
    }
}




#Preview {
    NavBarDetailView(aramaAktif: .constant(false))
}
