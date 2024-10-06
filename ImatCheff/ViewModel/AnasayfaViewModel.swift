//
//  AnasayfaViewModel.swift
//  ImatCheff
//
//  Created by İmat Gökaslan on 3.10.2024.
//


import Foundation
import Alamofire

class AnasayfaViewModel : ObservableObject {
    @Published var yemekListesi = [Yemek]()
    
    func veriYukle(){
      //yukleme
            let url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php"
            
            AF.request(url,method: .get).response { response in
                if let data = response.data {
                    do{
                        let cevap = try JSONDecoder().decode(YemekCevap.self, from: data)
                        if let liste = cevap.yemekler {
                            DispatchQueue.main.async {
                                self.yemekListesi = liste
                            }
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
    
    
    func SepeteEkle(yemek_adi: String ,yemek_resim_adi : String, yemek_fiyat : Int, yemek_siparis_adet: Int , kullanici_adi:String){
        let url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php"
        let params : Parameters = ["yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet":yemek_siparis_adet]
        AF.request(url,method: .post,parameters: params).response { response in
            if let data = response.data{
                do {
                    let cevap = try JSONDecoder().decode(CRUDCevap.self,from: data)
                    print("Başarı: \(cevap.message!)")
                    print("Mesaj : \(cevap.success!)")
                    print("bura çalışıyor")
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
}
