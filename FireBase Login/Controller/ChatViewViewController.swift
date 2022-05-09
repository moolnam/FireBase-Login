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
        
        tableView.register(UINib(nibName: K.celNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        // MessageCell 안에 있는 것으로 바꿔줬기 때문에 textLabel?. 이 아니라 label.
        cell.label.text = "\(messages[indexPath.row].body)"
        // MessageCell 안 label 텍스트에 값이 있어도 messages[] 어레이 안에 있는 스트럭트가 가지고 있는 값으로 변경된다. 
        
        return cell
    }
    
    
}
