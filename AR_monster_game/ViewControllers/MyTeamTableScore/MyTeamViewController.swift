//
//  MyTeamViewController.swift
//  AR_monster_game
//
//  Created by Антон Казеннов on 14.06.2023.
//

import UIKit
import CoreData
import MapKit

class MyTeamViewController: UIViewController, NSFetchedResultsControllerDelegate {

    let tableView = UITableView()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var monsters = [Entity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        getAllData()
        tableView.dataSource = self
        tableView.delegate = self
        makeConstraints()
    }
    func makeConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.register(CustomCell.self, forCellReuseIdentifier: "myTable")
    }
    private func getAllData() {
        do {
            monsters = try context.fetch(Entity.fetchRequest())
            print(monsters.count)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}


// MARK: - UITableViewDataSource
extension MyTeamViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monsters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = monsters[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "myTable", for: indexPath) as? CustomCell {
            cell.imageC.image = UIImage(named: model.name ?? "Anna")
            cell.header.text = model.name
            cell.text.text = "\(model.level!) пойман!"
            return cell
        }
        return UITableViewCell()
    }
}

extension MyTeamViewController: UITableViewDelegate {
    
}
