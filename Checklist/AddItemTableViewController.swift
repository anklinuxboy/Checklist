//
//  AddItemTableViewController.swift
//  Checklist
//
//  Created by Ankit Sharma on 10/3/19.
//  Copyright © 2019 Ankit Sharma. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func add(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension AddItemTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText)
        else {
            return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            addButton.isEnabled = false
        } else {
            addButton.isEnabled = true
        }
        
        return true
    }
}
