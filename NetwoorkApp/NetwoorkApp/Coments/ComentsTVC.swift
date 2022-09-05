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

    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
     }
     */

    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             // Delete the row from the data source
             tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
             // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
     }
     */

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
     }
     */

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */

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
