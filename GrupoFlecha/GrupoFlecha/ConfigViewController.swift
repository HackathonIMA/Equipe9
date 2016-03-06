//
//  ConfigViewController.swift
//  GrupoFlecha
//
//  Created by Davi Rodrigues on 05/03/16.
//  Copyright © 2016 Davi Rodrigues. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var gestanteLabel: UILabel!
    
    @IBOutlet weak var gestanteSwitch: UISwitch!
    
    @IBOutlet weak var greenView: UIView!
    
    //var keyboard: CGSize = CGSize(width: 0, height: 0)
    
    
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        greenView.layer.cornerRadius = 50
    }

    ///Popula informações do usuário na tela
    override func viewWillAppear(animated: Bool) {
        
        if(UserInfo.userAge >= 0) {
            self.ageTextField.text = String(UserInfo.userAge)
        }
        
        self.gestanteSwitch.on = UserInfo.gestante
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        //Faz a persistencia de dados do usuário em NSUserDefaults ao deixar a tela
        UserInfo.gestante = self.gestanteSwitch.on
        self.defaults.setBool(self.gestanteSwitch.on, forKey: "gestante")
        if(self.ageTextField.text != "") {
            UserInfo.userAge = Int(self.ageTextField.text!)!
            self.defaults.setInteger(Int(self.ageTextField.text!)!, forKey: "age")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: Keyboard
    /*
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.ageTextField.resignFirstResponder()
        return true
    }
    
    
    func registerForKeyboardNotifications() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeShown:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeHidden:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    // Called when the UIKeyboardDidShowNotification is sent.
    func keyboardWillBeShown(sender: NSNotification) {
        let info: NSDictionary = sender.userInfo!
        let value: NSValue = info.valueForKey(UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.CGRectValue().size
        
        self.keyboard = keyboardSize
        if(ageTextField.isFirstResponder()) {
            self.view.center.y -= keyboardSize.height
        }
        
    }
    */
    
    //Recolhe teclado ao fim da edição do campo de texto
    @IBAction func tapGestureRecognizerHandler(sender: AnyObject) {
        self.ageTextField.resignFirstResponder()
    }
    
}
