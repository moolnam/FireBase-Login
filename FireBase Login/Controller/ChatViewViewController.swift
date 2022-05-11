//
//  ChatViewViewController.swift
//  FireBase Login
//
//  Created by KimJongHee on 2022/05/07.
//

import UIKit
import Firebase

class ChatViewViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
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
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessage()
    }
    
    func loadMessage() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            
            if let e = error {
                print("There was an issue retrieving data from firestore\(e)")
            } else {
                if let querySnapshotDocuments = querySnapshot?.documents {
                    for doc in querySnapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            // 텍스트 필드 안에 입력이 되었다면 그리고 messageSender 안에 현재 계정이 있다면
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField : messageSender,
                K.FStore.bodyField : messageBody,
                K.FStore.dateField : Date().timeIntervalSince1970
            ]) { error in
                // db는 firestore 를 가지고 있고 컬렉션에 messages 라는 스트링 타입으로 시작이 되고
                // addDocument 에는 키와 벨류 타입인 sender:messageSender, body:messageBody 으로 저장이 된다.
                if let e = error {
                    // 반드시 error 를 포함해야 한다.
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data")
                }
                self.messageTextField.text = ""
            }
        }
        
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
