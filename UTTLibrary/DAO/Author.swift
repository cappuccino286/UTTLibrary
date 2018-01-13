//
//  Author.swift
//  UTTLibrary
//
//  Created by Le Gia Lam PHAM on 1/11/18.
//  Copyright © 2018 Sy Hung NGHIEM. All rights reserved.
//

import Foundation
class  Author {
    var id      : Int64
    let nom     : String
    let prenom  : String
    var idSetted : Bool
    init(nom : String , prenom : String){
        self.nom = nom
        self.prenom = prenom
        self.idSetted = false
        self.id = -1
    }
    public var description : String {return nom + " " + prenom}
    
    public func setId(id : Int64){
        self.id = id
        self.idSetted = true
    }
    
    public func getId() -> Int64{
        return self.id
    }
    
    enum IdSettedError : Error {
        case IdSetted
    }
}
