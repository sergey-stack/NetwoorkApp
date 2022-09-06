//
//  DetailComentVC.swift
//  NetwoorkApp
//
//  Created by сергей on 5.09.22.
//

import UIKit

class DetailComentVC: UIViewController {
    var comment: Coments?

    
    @IBOutlet var lableEmail: UILabel!
    
    @IBOutlet var lableBody: UILabel!
    
    @IBOutlet var lableName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
       lableEmail.text = comment?.email
        lableBody.text = comment?.body
        lableName.text = comment?.name
    }
}
