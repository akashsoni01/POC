//
//  File.swift
//  CoreML_Pic
//
//  Created by Akash soni on 02/10/23.
//

import Foundation

class Debouncer {
    private let queue: DispatchQueue
    private var workItem: DispatchWorkItem?
    private let debounceTime: TimeInterval

    init(debounceTime: TimeInterval, queue: DispatchQueue = .main) {
        self.debounceTime = debounceTime
        self.queue = queue
    }

    func debounce(action: @escaping () -> Void) {
        // Cancel the previous work item if it exists
        workItem?.cancel()

        // Create a new work item with the specified debounce time
        let newWorkItem = DispatchWorkItem { [weak self] in
            action()
            self?.workItem = nil
        }

        // Store the new work item
        workItem = newWorkItem

        // Dispatch the work item to the specified queue after the debounce time
        queue.asyncAfter(deadline: .now() + debounceTime, execute: newWorkItem)
    }
}

