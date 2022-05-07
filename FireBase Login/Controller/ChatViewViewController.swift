//
//  ChatViewViewController.swift
//  FireBase Login
//
//  Created by KimJongHee on 2022/05/07.
//

import UIKit
import Firebase

class ChatViewViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        
        // 뒤로가는 버튼을 숨김
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        // 로그아웃 버튼
        do {
            try Auth.auth().signOut()
            // 로그아웃 시도
            navigationController?.popToRootViewController(animated: true)
            // 루트 뷰를 포함한 나머지 것들을 다시 리뷰 시도하는 것같다. 
        } catch let signOutError as NSError {
            print("Error Sign Out : " ,signOutError)
        }
        
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
