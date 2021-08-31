//
//  ScoketIOManager.swift
//  TutorHubb
//
//  Created by Akash soni on 25/08/21.
//  Copyright © 2021 buzzyears. All rights reserved.
//

import Foundation
import SocketIO

class SocketChatManager {
    let manager = SocketManager(socketURL: URL(string: "http://18.140.112.332:3001/" )!, config: [.log(true), .compress])
    var socket: SocketIOClient? = nil
    init() {
        setupSocket()
        setupSocketEvents()
        socket?.connect()

    }
    func stop() {
        socket?.removeAllHandlers()
    }
    // MARK: - Socket Setup

    func setupSocket() {
        self.socket = manager.defaultSocket
    }
    
    func setupSocketEvents() {
        socket?.on(clientEvent: .connect) {data, ack in
            print("Connected")
        }
        socket?.onAny{print("Got event: \($0.event), with items: \($0.items)")}

        socket?.on("login") { (data, ack) in
            guard let dataInfo = data.first else { return }
            
//            if let response: SocketLogin = try? SocketParser.convert(data: dataInfo) {
//                print("Now this chat has \(response.numUsers) users.")
//            }
        }

        socket?.on("user joined") { (data, ack) in
            guard let dataInfo = data.first else { return }
//            if let response: SocketUserJoin = try? SocketParser.convert(data: dataInfo) {
//                print("User '\(response.username)' joined...")
//                print("Now this chat has \(response.numUsers) users.")
//            }
        }

        socket?.on("user left") { (data, ack) in
            guard let dataInfo = data.first else { return }
//            if let response: SocketUserLeft = try? SocketParser.convert(data: dataInfo) {
//                print("User '\(response.username)' left...")
//                print("Now this chat has \(response.numUsers) users.")
//            }
        }

        socket?.on("new_message") { (data, ack) in
            guard let dataInfo = data.first as? [String:String] else { return }
            print(dataInfo["message"])
        }
        socket?.on("send_message") { (data, ack) in
            guard let dataInfo = data.first as? Data else { return }
            print(String(data:dataInfo,encoding: String.Encoding.utf8))
//            if let response: SocketMessage = try? SocketParser.convert(data: dataInfo) {
//                print("Message from '\(response.username)': \(response.message)")
//            }
        }

        socket?.on("typing") { (data, ack) in
            guard let dataInfo = data.first else { return }
//            if let response: SocketUserTyping = try? SocketParser.convert(data: dataInfo) {
//                print("User \(response.username) is typing...")
//            }
        }

        socket?.on("stop typing") { (data, ack) in
            guard let dataInfo = data.first else { return }
//            if let response: SocketUserTyping = try? SocketParser.convert(data: dataInfo) {
//                print("User \(response.username) stopped typing...")
//            }
        }
    }
    // MARK: - Socket Emits

    func register(user: String) {
        let socketUser = ["user_id":"600","connections":user]
        socket?.emit("user_connected", socketUser)
    }

    func send(message: String) {
        let msg = ["sender_id":"600",
        "receiver_id":"603",
        "message":"na na re "]
        socket?.emit("send_message", msg)
    }
    
    
}
