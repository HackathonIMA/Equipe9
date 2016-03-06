//
//  MainTabBarController.swift
//  GrupoFlecha
//
//  Created by Davi Rodrigues on 05/03/16.
//  Copyright © 2016 Davi Rodrigues. All rights reserved.
//

import UIKit
import CoreLocation

class MainTabBarController: UITabBarController {
    
    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Inicializa titulo e imagem dos icones da tabBar
        self.tabBar.items![0].title = "Alerta"
        self.tabBar.items![1].title = "Zonas de risco"
        self.tabBar.items![2].title = "Configurações"
        
        self.tabBar.items![0].image = UIImage(named: "alert")
        self.tabBar.items![1].image = UIImage(named: "area")
        self.tabBar.items![2].image = UIImage(named: "user")
        
        self.tabBar.tintColor = UIColor(red: 51/256, green: 179/256, blue: 151/256, alpha: 1)
        
        self.tabBar.barStyle = UIBarStyle.Black
        
        self.selectedIndex = 2
        
        //Recupera dados salvos do usuário
        if(defaults.integerForKey("age") != 0) {
            UserInfo.userAge = defaults.integerForKey("age")
        }
        UserInfo.gestante = defaults.boolForKey("gestante")

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
