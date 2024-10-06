//
//  SepetItemViewModel.swift
//  ImatCheff
//
//  Created by İmat Gökaslan on 5.10.2024.
//

import Foundation
import Alamofire
class SepetItemViewModel : ObservableObject {
    @Published var yemeklistesi = [Sepet_yemekler]()
    
    func sil(sepet_yemek_id : Int,kullanici_adi: String){
        let url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php"
        let params: Parameters = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi]
        
        AF.request(url , method: .post,parameters: params).response{ response in
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("Başarı: \(cevap.success!)")
                    print("Mesaj: \(cevap.message!)")
                    self.SepettekiYemekleriGetir(kullanici_adi: "imat")
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func SepettekiYemekleriGetir(kullanici_adi:String){

            let url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php"
        let params = ["kullanici_adi":kullanici_adi]
            AF.request(url,method: .post,parameters: params).response { response in
                if let data = response.data {
                    do{
                        let cevap = try JSONDecoder().decode(SepetCevap.self, from: data)
                        if let liste = cevap.sepet_yemekler{
                            DispatchQueue.main.async {
                                self.yemeklistesi = liste
                            }
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
    
    
    
}
