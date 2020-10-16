//
//  PairListViewController.swift
//  PairRandomizer
//
//  Created by Owen Barrott on 10/16/20.
//  Copyright © 2020 Owen Barrott. All rights reserved.
//

import UIKit

class PairListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var pairListTableView: UITableView!
    
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        pairListTableView.delegate = self
        pairListTableView.dataSource = self
        
    }
    
    // MARK: - Actions
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presentAlertController()
        //reloadData()
    }
    
    @IBAction func randomButtonTapped(_ sender: Any) {
        
    }
    
    
    
    // MARK: - Class Functions
    func reloadData() {
        pairListTableView.reloadData()
    }
    
    func presentAlertController() {
        let alertController = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .alert)
        
        alertController.addTextField { (personTextField) in
            personTextField.placeholder = "Full name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alertController.textFields?[0].text, !name.isEmpty else { return }
            
            PersonController.shared.createPerson(name: name)
            self.pairListTableView.reloadData()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
}





extension PairListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let sectionNumber: Int
        if PersonController.shared.peopleArray.count % 2 == 0 {
            sectionNumber = PersonController.shared.peopleArray.count / 2
        } else {
            sectionNumber = (PersonController.shared.peopleArray.count / 2) + 1
        }
        return sectionNumber
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Group \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionNumber: Int
        let rowNumber: Int
        
        sectionNumber = PersonController.shared.peopleArray.count / 2
//        sectionNumber = PersonController.shared.people.count / 2
        

        
        if section == sectionNumber {
            if PersonController.shared.peopleArray.count % 2 == 0 {
                rowNumber = 2
            } else {
                rowNumber = 1
            }
        } else {
            rowNumber = 2
            }
        return rowNumber
        }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        var currentRow = 0
        for section in 0..<indexPath.section {
                let rows = self.pairListTableView.numberOfRows(inSection: section)
                currentRow += rows
        }

        currentRow += indexPath.row
        
        let nameText = PersonController.shared.peopleArray[currentRow].name
        
//        let nameValue = PersonController.shared.keyArray[currentRow]
//        guard let nameText = PersonController.shared.people[nameValue]?.name else { return UITableViewCell() }
        
        print("\(nameText)")
        cell.textLabel?.text = "\(nameText)"
        return cell
    }
}
