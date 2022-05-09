//
//  ChatViewViewController.swift
//  FireBase Login
//
//  Created by KimJongHee on 2022/05/07.
//

import UIKit
import Firebase

class ChatViewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Message] = [
        Message(sender: "1@1.com", body: "Hi"),
        Message(sender: "2@1.com", body: "Hello"),
        Message(sender: "3@1.com", body: "안녕"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self

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
    


}

extension ChatViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCellIdentifier, for: indexPath)
        cell.textLabel?.text = "\(messages[indexPath.row].body)"
        
        return cell
    }
    
    
}
