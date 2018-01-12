//
//  Author.swift
//  UTTLibrary
//
//  Created by Le Gia Lam PHAM on 1/11/18.
//  Copyright © 2018 Sy Hung NGHIEM. All rights reserved.
//

import Foundation
class  Author {
    var id      : Int
    let nom     : String
    let prenom  : String
    var idSetted : Bool
    init(nom : nom , prenom : prenom){
        self.nom = nom
        self.prenom = prenom
    }
    public var description : String {return nom + " " + prenom}
    
    public func setId(id : Int){
        if idSetted {
            throw IdSettedError.IdSetted
        }
        self.id = id
        self.idSetted = true
    }
    
    public func getId(){
        return self.id
    }
    
    enum IdSettedError : Error {
        case IdSetted
    }
}
