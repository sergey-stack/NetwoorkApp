//
//  ToDosTVC.swift
//  NetwoorkApp
//
//  Created by сергей on 7.09.22.
//

import UIKit

class ToDosTVC: UITableViewController {
    var user: User?
    var toDoS: [toDos] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchToDos()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoS.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toDo = toDoS[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowToDos", for: indexPath)
        cell.textLabel?.text = toDo.title
        cell.detailTextLabel?.text = toDo.completed?.description

        return cell
    }

    func fetchToDos() {
        guard let userId = user?.id else { return }
        let pathUrl = "\(ApiConstants.postsPath)?userId=\(userId)"

        guard let url = URL(string: pathUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                self.toDoS = try JSONDecoder().decode([toDos].self, from: data)
                print(self.toDoS)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}
