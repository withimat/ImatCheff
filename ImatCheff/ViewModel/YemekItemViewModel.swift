//
//  YemekItemViewModel.swift
//  ImatCheff
//
//  Created by İmat Gökaslan on 5.10.2024.
//

import Foundation
import Alamofire

class YemekItemViewModel : ObservableObject {
    
    
    
    
    func SepeteEkle(yemek_adi: String ,yemek_resim_adi : String, yemek_fiyat : Int, yemek_siparis_adet: Int , kullanici_adi:String){
        let url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php"
        let params : Parameters = ["yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":kullanici_adi]
        AF.request(url,method: .post,parameters: params).response { response in
            if let data = response.data{
                do {
                    let cevap = try JSONDecoder().decode(CRUDCevap.self,from: data)
                    print("Başarı: \(cevap.message!)")
                    print("Mesaj : \(cevap.success!)")
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }


}
