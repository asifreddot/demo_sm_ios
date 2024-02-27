//
//  TaskTableViewCell.swift
//  smart to do
//
//  Created by Asif Reddot on 26/2/24.
//

import UIKit

protocol TaskTableViewDelegate: AnyObject {
    func markAsComplete(_ item: ToDoListITem)
}

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTaskDescription: Inter400Size12Color061053Alpha55!
    @IBOutlet weak var labelTaskName: Inter500Size14Color061053!
    @IBOutlet weak var imageViewComplete: UIImageView!
    @IBOutlet weak var labelSyncStatus: Inter400Size10Color009B3E!
    @IBOutlet weak var viewStatusBackground: UIView!
    
    var item: ToDoListITem?
    
    weak var delegate: TaskTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    func updateCell(_ item: ToDoListITem) {
        self.item = item
        labelTaskName.text = item.title
        labelTaskDescription.text = item.item_description
        
        imageViewComplete.image = item.completed ? UIImage(named: "ic_complete") : UIImage(named: "ic_incomplete")
        
        if item.sync_status == TaskStatus.synced.rawValue {
            labelSyncStatus.text = "Synced Successfully"
            labelSyncStatus.textColor = CustomColors().color009B3E
            viewStatusBackground.backgroundColor = CustomColors().color009B3E.withAlphaComponent(0.15)
        } else {
            labelSyncStatus.text = "Not synced"
            labelSyncStatus.textColor = CustomColors().colorAB8D00
            viewStatusBackground.backgroundColor = CustomColors().colorFFD300.withAlphaComponent(0.20)
        }
    }
}

extension TaskTableViewCell {
    func setupView() {
        self.clipsToBounds = true
        self.cornerRadius = 8
    
        viewStatusBackground.clipsToBounds = true
        viewStatusBackground.cornerRadius = 8
        
        imageViewComplete.isUserInteractionEnabled = true
        imageViewComplete.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(markAsComplete(_ :))))
        
        self.layer.shadowColor = CustomColors().color009A3E.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.16
        self.layer.shadowRadius = 11
        self.clipsToBounds = false
    }
    
    @objc func markAsComplete(_ sender: UITapGestureRecognizer) {
        item?.completed.toggle()
        
        do {
            try CoreDataService.shared.context.save()
        } catch {
            
        }
        
        delegate?.markAsComplete(item ?? ToDoListITem())
    }
}
