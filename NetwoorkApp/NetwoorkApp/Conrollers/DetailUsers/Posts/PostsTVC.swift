//
//  PostsTVC.swift
//  NetwoorkApp
//
//  Created by сергей on 4.09.22.
//

import UIKit

class PostsTVC: UITableViewController {
    var user: User?
    var posts: [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let storyboard = UIStoryboard(name: "PostsAndComents", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailPostVC") as! DetailPostVC
            vc.post = post
       // vc.user  = user
        navigationController?.pushViewController(vc, animated: true)
    }

 
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, let id = posts[indexPath.row].id {//вытащили один пост и у него забрали id
            NetworkService.deletePost(postID: id) { [weak self] json, error in
                if json != nil {
                    self?.posts.remove(at: indexPath.row)//удаляем из массива
                    tableView.deleteRows(at: [indexPath], with: .automatic)//удаляем из ячейки
                } else if let error = error {
                    print(error)
                }
            }
        }
    }

 



    
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         // Get the new view controller using segue.destination.
//         // Pass the selected object to the new view controller.
//     }
     
    func fetchPosts() {
        guard let userId = user?.id else { return }
        let pathUrl = "\(ApiConstants.postsPath)?userId=\(userId)"

        guard let url = URL(string: pathUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                self.posts = try JSONDecoder().decode([Post].self, from: data)
                print(self.posts)
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
