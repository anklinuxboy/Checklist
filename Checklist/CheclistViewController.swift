//
//  ViewController.swift
//  Checklist
//
//  Created by Ankit Sharma on 10/2/19.
//  Copyright © 2019 Ankit Sharma. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var todoList: TodoList
    
    required init?(coder: NSCoder) {
        todoList = TodoList()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.todos.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todoList.todos.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        if let label = cell.viewWithTag(1000) as? UILabel {
            label.text = todoList.todos[indexPath.row].text
        }
        configureCheckmark(for: cell, at: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            configureCheckmark(for: cell, at: indexPath)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let controller = segue.destination as? AddItemTableViewController {
                controller.delegate = self
                controller.todoList = todoList
            }
        } else if segue.identifier == "EditItemSegue" {
            if let controller = segue.destination as? AddItemTableViewController {
                if let cell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: cell) {
                    let item = todoList.todos[indexPath.row]
                    controller.itemToEdit = item
                    controller.delegate = self
                }
            }
        }
    }
    
    func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
        guard let checkmark = cell.viewWithTag(1001) as? UILabel else {
            return
        }
        let isChecked = todoList.todos[indexPath.row].checked
        if isChecked {
            checkmark.text = "√"
        } else {
            checkmark.text = ""
        }
        
        todoList.todos[indexPath.row].checked = !isChecked
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        let newRowIndex = todoList.todos.count
        _ = todoList.addListItem()
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}


extension ChecklistViewController: AddItemViewDelegate {
    func editClicked(_ controller: AddItemTableViewController, shouldEditItem item: ChecklistItem) {
        if let index = todoList.todos.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                if let label = cell.viewWithTag(1000) as? UILabel {
                    label.text = item.text
                }
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func cancelClicked(_ controller: AddItemTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addClicked(_ controller: AddItemTableViewController, shouldAddItem item: ChecklistItem) {
        navigationController?.popViewController(animated: true)
        let rowIndex = todoList.todos.count
        let indexPath = IndexPath(row: rowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}
