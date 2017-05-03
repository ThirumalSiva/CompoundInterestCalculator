//
//  ViewController.swift
//  CompoundInterestCalculator
//
//  Created by think24 on 4/25/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{
    //MARK:- Variables
    //MARK:-- Outlet

    @IBOutlet weak var amountTxtFld: UITextField!
    @IBOutlet weak var interestTxtFld: UITextField!
    @IBOutlet weak var termsTxtFld: UITextField!
    @IBOutlet weak var resultTxtView: UITextView!
    @IBOutlet weak var termsSegmentControl: UISegmentedControl!
    
    //MARK:-- Class
    
    //MARK:- View life cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Button Action
    
    @IBAction func calculateButtonAction(_ sender: UIButton)
    {
        self.view.endEditing(true)
        self.resultTxtView.text = ""
        let amount = checkNilValue(textFieldStrig: self.amountTxtFld.text)
        let interest = checkNilValue(textFieldStrig: self.interestTxtFld.text)
        let terms = checkNilValue(textFieldStrig: self.termsTxtFld.text)
        if amount == ""
        {
            self.showAlert(text: "Enter valid amount.")
        }
        else if interest == ""
        {
            self.showAlert(text: "Enter valid interest.")
        }
        else if terms == ""
        {
            self.showAlert(text: "Enter valid Years.")
        }
        else
        {
            self.calculateInterest(amount: amount, interest: interest, terms: terms)
        }
    }
    
    //MARK:- Private function
    
    private func checkNilValue(textFieldStrig : String?) -> String
    {
        if let text = textFieldStrig
        {
            return text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        return ""
    }
    
    private func showAlert(text : String)
    {
        let alertController = UIAlertController(title: "Alert", message: text, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (alert) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func calculateInterest(amount : String, interest : String, terms : String)
    {
        let termsCompounded = [12.0,4.0,2.0,1.0][self.termsSegmentControl.selectedSegmentIndex]
        let rate = 1 + (Double(interest)! / (100.0 * termsCompounded))
        let totalAmount = Double(amount)! * pow(rate, Double(Double(terms)! * termsCompounded))
        self.resultTxtView.text = "At end of " + terms + " years total amount will be Rs. " + String(format: "%.2f", totalAmount) + " for loan amount of Rs. " + amount + " with interest rate " + interest + " % per annum." + "\n\nTotal interest amount will be Rs. " + String(format: "%.2f", (totalAmount - Double(amount)!))       
    }
}

