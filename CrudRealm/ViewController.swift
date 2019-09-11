//
//  ViewController.swift
//  CrudRealm
//
//  Created by Thiago Valente on 11/09/19.
//  Copyright © 2019 Thiago Valente. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    var people: Results<Person>!
    var tableView = UITableView()

    private var database: Realm!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRealm()
        setupTable()
        setupNavbar()

        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupRealm() {
        do {
            self.database = try Realm()
        } catch let error as NSError {
            print(error)
        }

        people = database.objects(Person.self)

    }
    
    @objc
    func addTapped() {
        let person = Person()
        person.name = "Thiago Valente"
        person.age = Int.random(in: 18...60)
        insertPerson(person: person)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: people.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    func insertPerson(person: Person) {
        do {
            try database.write {
                database.add(person)
                print("Added new person")
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func deletePerson(person: Person) {
        do {
            try database.write {
                database.delete(person)
                print("Delete person")
            }
        } catch let error as NSError {
            print(error)
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            deletePerson(person: people[indexPath.row])
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = people[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = "\(person.age)"
        
        return cell
    }

}

