//
//  Yemek.swift
//  ImatCheff
//
//  Created by İmat Gökaslan on 3.10.2024.
//

import Foundation

class Yemek: Identifiable, Codable {
    var yemek_id: String?
    var yemek_adi: String?
    var yemek_resim_adi: String?
    var yemek_fiyat: String?

    
    init(){}
    
    init(yemek_id: String, yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String) {
        self.yemek_id = yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
    }

    enum CodingKeys: String, CodingKey {
        case yemek_id = "yemek_id"
        case yemek_adi = "yemek_adi"
        case yemek_resim_adi = "yemek_resim_adi"
        case yemek_fiyat = "yemek_fiyat"
    }
}

class YemekCevap: Codable ,Identifiable{
    let yemekler: [Yemek]?
    let success : Int?
}

class SepetCevap: Codable , Identifiable {
    let sepet_yemekler: [Sepet_yemekler]?
    let success : Int?
}





class Sepet_yemekler: Codable , Identifiable , Equatable{
    var sepet_yemek_id : String?
    var yemek_adi : String?
    var yemek_resim_adi : String?
    var yemek_fiyat : String?
    var yemek_siparis_adet : String?
    var kullanici_adi : String?
    
    init(){}
    
    init(sepet_yemek_id: String, sepet_adi: String, yemek_resim_adi: String, yemek_fiyat: String, yemek_siparis_adet:String, kullanici_adi: String) {
        self.sepet_yemek_id = sepet_yemek_id
        self.yemek_adi = sepet_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
        self.yemek_siparis_adet = yemek_siparis_adet
        self.kullanici_adi = kullanici_adi
    }
    
    static func ==(lhs: Sepet_yemekler, rhs: Sepet_yemekler) -> Bool {
            return lhs.sepet_yemek_id == rhs.sepet_yemek_id
        }
    
}

