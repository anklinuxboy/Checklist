//
//  AddItemTableViewController.swift
//  Checklist
//
//  Created by Ankit Sharma on 10/3/19.
//  Copyright © 2019 Ankit Sharma. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    weak var delegate: AddItemViewDelegate?
    weak var todoList: TodoList?
    weak var itemToEdit: ChecklistItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            addButton.title = "Edit"
            addButton.isEnabled = true
        } else {
            addButton.title = "Add"
            addButton.isEnabled = false
        }
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.cancelClicked(self)
    }

    @IBAction func add(_ sender: Any) {
        if let item = itemToEdit,
            let text = textField.text {
            item.text = text
            delegate?.editClicked(self, shouldEditItem: item)
        } else {
            if let item = todoList?.addListItem(),
                let todoText = textField.text {
                    item.text = todoText
                item.checked = false
                delegate?.addClicked(self, shouldAddItem: item)
            }
        }
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

protocol AddItemViewDelegate: class {
    func cancelClicked(_ controller: AddItemTableViewController)
    func addClicked(_ controller: AddItemTableViewController, shouldAddItem item: ChecklistItem)
    func editClicked(_ controller: AddItemTableViewController, shouldEditItem item: ChecklistItem)
}
