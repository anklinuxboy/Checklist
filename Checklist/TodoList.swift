//
//  TodoList.swift
//  Checklist
//
//  Created by Ankit Sharma on 10/2/19.
//  Copyright © 2019 Ankit Sharma. All rights reserved.
//

import Foundation

class TodoList {
    var todos: [ChecklistItem] = []
    
    init() {
        let row0Item = ChecklistItem()
        let row1Item = ChecklistItem()
        let row2Item = ChecklistItem()
        let row3Item = ChecklistItem()
        let row4Item = ChecklistItem()
        
        row0Item.text = "Run Marathon"
        row1Item.text = "Code"
        row2Item.text = "Walk Dog"
        row3Item.text = "Eat"
        row4Item.text = "Sleep"
        
        todos.append(row0Item)
        todos.append(row1Item)
        todos.append(row2Item)
        todos.append(row3Item)
        todos.append(row4Item)
    }
    
    func addListItem() -> ChecklistItem {
        let item = ChecklistItem()
        item.text = "New Item"
        item.checked = true
        todos.append(item)
        return item
    }
}
