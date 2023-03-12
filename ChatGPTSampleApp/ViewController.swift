//
//  ViewController.swift
//  ChatGPTSampleApp
//

import UIKit

import UIKit
import OpenAISwift

class ViewController: UIViewController {


    @IBOutlet weak var aiTextView: UITextView!
    @IBOutlet weak var inputTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func chat() {
        Task {
            do {
                let chatMessages = [
                    ChatMessage(role: .system, content: "嬉しいときは語尾に「(嬉)」をつけます。楽しいときは語尾に「(楽)」をつけます。寂しいときは語尾に「(寂)」をつけます。不安なときは語尾に「(不安)」をつけます。驚いたときは語尾に「(驚き)」をつけます。"),
                    ChatMessage(role: .assistant, content: "私の名前はアイです。よろしくね！(嬉)"),
                    ChatMessage(role: .user, content: inputTextField.text ?? "")
                ]
                let answer = try await answer(from: chatMessages)
                print(answer)
                self.aiTextView.text = answer

            } catch {
                print(error)
            }
        }
    }

    private func answer(from chatMessages: [ChatMessage]) async throws -> String {
        let openAI = OpenAISwift(authToken: "")// SECRET KEY
        let result = try await openAI.sendChat(with: chatMessages)

        return result.choices.first?.message.content ?? ""
    }

    @IBAction func send(_ sender: Any) {
        chat()
    }
}

