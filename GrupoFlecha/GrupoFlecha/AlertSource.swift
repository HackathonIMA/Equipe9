//
//  AlertSource.swift
//  GrupoFlecha
//
//  Created by Davi Rodrigues on 05/03/16.
//  Copyright © 2016 Davi Rodrigues. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class AlertSource: NSObject {
    
    static let confirmadosUrl = "http://187.110.34.171/rest/confirmados"
    static let focosUrl = "http://187.110.34.171/rest/focos"

    static let alertaSimples = "    Atenção em um raio de 300 metros dessa localização, um caso de dengue foi confirmado. Caso você apresente: \n\n- Febre alta com início súbito. \n- Dor de cabeça. \n- Dor atrás dos olhos, que piora com o movimento deles. \n- Perda do paladar e apetite. \n- Náuseas e vômitos. \n- Tonturas. \n\n   Procure uma unidade de Saúde o mais rápido possível. Redobre a atenção com a água parada, eliminando possíveis criadouros. Além disso use repelentes e roupas compridas contra o mosquito da Dengue."
    
    static var casosDeDengue = 2
    
    static var pinCoordinates = [CLLocationCoordinate2D]()
    
    static func addPinCoordinate(coordinate: CLLocationCoordinate2D) {
        pinCoordinates += [coordinate]
    }
    
    static func getData() {
        
        var json = JSON(data: NSData())
        
        var latitude = String()
        var longitude = String()
      
        Alamofire.request(.GET, confirmadosUrl, parameters: ["foo": "bar"])
            .responseJSON { response in
                
                json = JSON(data: response.data!)
                
                for index in 0...(json.count - 1) {
                    //print(json[index]["Latitude"].stringValue)
                    latitude = json[index]["Latitude"].stringValue
                    longitude = json[index]["Longitude"].stringValue
                    
                    //stringToCoordinate(latitude)
                    //stringToCoordinate(longitude)
                }
                
                
        }

        
    }
    
    static func stringToCoordinate(str: String) -> Double {
        var string = str
        
        string.removeAtIndex(string.startIndex.advancedBy(2))
        string.removeAtIndex(string.startIndex.advancedBy(2))
        string.removeAtIndex(string.startIndex.advancedBy(4))
        string.removeAtIndex(string.startIndex.advancedBy(4))
        string.removeAtIndex(string.startIndex.advancedBy(6))
        string.removeAtIndex(string.endIndex.predecessor()) //S
        string.removeAtIndex(string.endIndex.predecessor())
        string.removeAtIndex(string.endIndex.predecessor())
        
        //print(string)
        
        let coord = Double(string)!/100000000
        //print(coord)
        return coord
    }
}
