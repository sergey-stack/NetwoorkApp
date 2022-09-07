//
//  DetailPostVC.swift
//  NetwoorkApp
//
//  Created by сергей on 4.09.22.
//

import UIKit

class DetailPostVC: UIViewController {
    var user: User?
    var post: Post?
    var coment: Coments?
    
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet weak var bodyTV: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUII()
    }
    
    @IBAction func comentAction() {
        let storyboard = UIStoryboard(name: "PostsAndComents", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ComentsTVC") as! ComentsTVC
        vc.coment = coment
        vc.post = post
        navigationController?.pushViewController(vc, animated: true)
    }
        
    private func setupUII() {
        titleLbl.text = post?.title
        bodyTV.text = post?.body
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
