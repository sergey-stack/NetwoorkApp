//
//  DetailUserVC.swift
//  NetwoorkApp
//
//  Created by сергей on 4.09.22.
//

import UIKit

class DetailUserVC: UIViewController {
    var user: User?
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var username: UILabel!
    
    @IBOutlet var email: UILabel!
    
    @IBOutlet var phone: UILabel!
    
    @IBOutlet var adress: UILabel!
    @IBOutlet var website: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func postsAction() {
        let storyboard = UIStoryboard(name: "PostsAndComents", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostsTVC") as! PostsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func albomsAction() {
        let storyboard = UIStoryboard(name: "AlbumsAndPhotos", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlbomsTVC") as! AlbomsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
        
    @IBAction func toDoSAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ToDosTVC") as! ToDosTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func locationAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapsVC") as! MapsVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() { // опциональная цепочка
        name.text = user?.name
        username.text = user?.username
        email.text = user?.email
        phone.text = user?.phone
        website.text = user?.website
        adress.text = user?.address?.city
    }
}
