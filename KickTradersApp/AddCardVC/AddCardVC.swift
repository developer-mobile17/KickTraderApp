//
//  AddCardVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 02/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import CreditCardForm
import Stripe

class AddCardVC: UIViewController, STPPaymentCardTextFieldDelegate {

@IBOutlet weak var creditCardView: CreditCardFormView!
    
    // Stripe textField
    let paymentTextField = STPPaymentCardTextField()
      private var cardHolderNameTextField: TextField!
       private var cardParams: STPPaymentMethodCardParams!

    override func viewDidLoad() {
            super.viewDidLoad()
        
      
        
            creditCardView.cardHolderString = ""
            creditCardView.cardGradientColors[Brands.Amex.rawValue] = [UIColor.red, UIColor.black]
            creditCardView.cardNumberFont = UIFont(name: "HelveticaNeue", size: 20)!
            creditCardView.cardPlaceholdersFont = UIFont(name: "HelveticaNeue", size: 10)!
            creditCardView.cardTextFont = UIFont(name: "HelveticaNeue", size: 12)!
            
            paymentTextField.postalCodeEntryEnabled = false
            
            createTextField()
            
            cardParams = STPPaymentMethodCardParams()
         /*   cardParams.number = ""
            cardParams.expMonth = 03
            cardParams.expYear = 23
            cardParams.cvc = "7997"  */
            self.paymentTextField.cardParams = cardParams
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            // load saved card params
            creditCardView.paymentCardTextFieldDidChange(cardNumber: cardParams.number, expirationYear: cardParams!.expYear as? UInt, expirationMonth: cardParams!.expMonth as? UInt, cvc: cardParams.cvc)
        }
        
        func createTextField() {
            cardHolderNameTextField = TextField(frame: CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44))
            cardHolderNameTextField.placeholder = "CARD HOLDER NAME"
            cardHolderNameTextField.delegate = self
            cardHolderNameTextField.translatesAutoresizingMaskIntoConstraints = false
          //  cardHolderNameTextField.setBottomBorder()
            cardHolderNameTextField.addTarget(self, action: #selector(AddCardVC.textFieldDidChange(_:)), for: .editingChanged)
            view.addSubview(cardHolderNameTextField)
            
            paymentTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44)
            paymentTextField.delegate = self
            paymentTextField.translatesAutoresizingMaskIntoConstraints = false
           // paymentTextField.borderWidth = 0
            
            let border = CALayer()
            let width = CGFloat(1.0)
            border.borderColor = UIColor.lightGray.cgColor
            border.frame = CGRect(x: 0, y: paymentTextField.frame.size.height - width, width:  paymentTextField.frame.size.width, height: paymentTextField.frame.size.height)
            border.borderWidth = width
            paymentTextField.layer.addSublayer(border)
            paymentTextField.layer.masksToBounds = true
            
            view.addSubview(paymentTextField)
            
            NSLayoutConstraint.activate([
                cardHolderNameTextField.topAnchor.constraint(equalTo: creditCardView.bottomAnchor, constant: 20),
                cardHolderNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                cardHolderNameTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-25),
                cardHolderNameTextField.heightAnchor.constraint(equalToConstant: 44)
            ])
            
            NSLayoutConstraint.activate([
                paymentTextField.topAnchor.constraint(equalTo: cardHolderNameTextField.bottomAnchor, constant: 20),
                paymentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                paymentTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20),
                paymentTextField.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
            creditCardView.paymentCardTextFieldDidChange(cardNumber: textField.cardNumber, expirationYear: textField.expirationYear, expirationMonth: textField.expirationMonth, cvc: textField.cvc)
        }
        
        func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
            creditCardView.paymentCardTextFieldDidEndEditingExpiration(expirationYear: textField.expirationYear)
        }
        
        func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
            creditCardView.paymentCardTextFieldDidBeginEditingCVC()
        }
        
        func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
            creditCardView.paymentCardTextFieldDidEndEditingCVC()
        }
    }

    extension AddCardVC: UITextFieldDelegate {
        @objc func textFieldDidChange(_ textField: UITextField) {
            creditCardView.cardHolderString = textField.text!
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == cardHolderNameTextField {
                textField.resignFirstResponder()
                paymentTextField.becomeFirstResponder()
            } else if textField == paymentTextField  {
                textField.resignFirstResponder()
            }
            return true
        }
    }

    extension UITextField {
        
        func setBottomBorder() {
            self.borderStyle = UITextField.BorderStyle.none
            let border = CALayer()
            let width = CGFloat(1.0)
            border.borderColor = UIColor.darkGray.cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
            border.borderWidth = width
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
        }
    }

