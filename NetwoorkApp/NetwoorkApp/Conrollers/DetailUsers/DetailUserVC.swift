//
//  DetailUserVC.swift
//  NetwoorkApp
//
//  Created by сергей on 4.09.22.
//

import UIKit

class DetailUserVC: UIViewController {
    var user:User?
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var username: UILabel!
    
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    
    
    @IBOutlet weak var website: UILabel!
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
    }
    
    @IBAction func toDoSAction() {
    }
    
    
    private func setupUI() {//опциональная цепочка
        name.text = user?.name
        username.text = user?.username
        email.text = user?.email
        phone.text = user?.phone
        website.text = user?.website
        
        
    }

}
