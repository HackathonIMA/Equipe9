//
//  AlertSource.swift
//  GrupoFlecha
//
//  Created by Davi Rodrigues on 05/03/16.
//  Copyright © 2016 Davi Rodrigues. All rights reserved.
//

import UIKit
import MapKit

class AlertSource: NSObject {
    
    static let confirmadosUrl = "https://187.110.34.171/rest/confirmados"
    static let focosUrl = "https://187.110.34.171/rest/focos"

    static let alertaSimples = "    Atenção em um raio de 300 metros dessa localização, um caso de dengue foi confirmado. Caso você apresente: \n\n- Febre alta com início súbito. \n- Dor de cabeça. \n- Dor atrás dos olhos, que piora com o movimento deles. \n- Perda do paladar e apetite. \n- Náuseas e vômitos. \n- Tonturas. \n\n   Procure uma unidade de Saúde o mais rápido possível. Redobre a atenção com a água parada, eliminando possíveis criadouros. Além disso use repelentes e roupas compridas contra o mosquito da Dengue."
    
    static var casosDeDengue = 1
    
    static var pinCoordinates = [CLLocationCoordinate2D]()
    
    static func addPinCoordinate(coordinate: CLLocationCoordinate2D) {
        pinCoordinates += [coordinate]
    }
    
    static func getData() {
        let url = NSURL(string: AlertSource.confirmadosUrl)
        
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {() -> Void in
            }<#T##(NSURLResponse?, NSData?, NSError?) -> Void#>)
        
        do {
        let contents = try NSString(contentsOfURL: url!, usedEncoding: nil)
        print(contents)
        } catch {
            
        }

        
        
        
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        //let paramString = "data=Hello"
        //request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }

            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(dataString)
            
        }
        
        task.resume()
        
        /*
        let dataTask = session.dataTaskWithURL(url!, completionHandler: {(data:NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                print(data)
            })
        
    }*/
    }
}
