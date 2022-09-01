//
//  ActionsCollectionVC.swift
//  NetwoorkApp
//
//  Created by сергей on 1.09.22.
//

import UIKit

enum Actons: String, CaseIterable {
    case downloadImage = "Download Image"
    case users = "Users"
}

class ActionsCollectionVC: UICollectionViewController {
    private let reuseIdentifier = "ActionCollectionViewCell"

    private let actions = Actons.allCases

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let usersTVC = segue.destination as? UsersTVC else { return }
        usersTVC.fetchUsers()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ActionCollectionViewCell
        cell.labelAction.text = actions[indexPath.row].rawValue

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action = actions[indexPath.row]
        switch action {
            case .downloadImage: performSegue(withIdentifier: "showImageSegue",
                                              sender: nil)
            case .users: performSegue(withIdentifier: "showUsersSegue",
                                      sender: nil)
        }
    }

    // MARK: UICollectionViewDelegate

    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
         return true
     }
     */

    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
         return true
     }
     */

    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
         return false
     }

     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
         return false
     }

     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {

     }
     */
}

extension ActionsCollectionVC: UICollectionViewDelegateFlowLayout { // этот метод возвращает размер для collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 20
        return CGSize(width: width, height: width / 2)
    }
}
