//
//  ComentsTVC.swift
//  NetwoorkApp
//
//  Created by сергей on 5.09.22.
//

import UIKit

class ComentsTVC: UITableViewController {
    var post: Post?
    var coment: Coments?
    var comment: [Coments] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchComent()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comment.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coments = comment[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Coment", for: indexPath)
        cell.textLabel?.text = coments.name
        cell.detailTextLabel?.text = coments.body
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coments = comment[indexPath.row]
        let storyboard = UIStoryboard(name: "PostsAndComents", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailComentVC") as! DetailComentVC
        vc.comment = coments
        navigationController?.pushViewController(vc, animated: true)
    }

    private func fetchComent() {
        guard let postId = post?.id else { return }
        let pathUrl = "\(ApiConstants.commentsPath)?postId=\(postId)"

        guard let url = URL(string: pathUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                self.comment = try JSONDecoder().decode([Coments].self, from: data)
                print(self.comment)
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
