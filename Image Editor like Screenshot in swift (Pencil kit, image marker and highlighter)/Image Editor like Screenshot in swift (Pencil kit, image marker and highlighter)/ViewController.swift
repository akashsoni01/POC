//
//  ViewController.swift
//  Image Editor like Screenshot in swift (Pencil kit, image marker and highlighter)
//
//  Created by AkashBuzzyears on 7/21/20.
//  Copyright © 2020 akash soni. All rights reserved.
//

import UIKit
import PencilKit

class ViewController: UIViewController {

    let canvasView = PKCanvasView(frame: .zero)
    var urlString = "https://dummyimage.com/600x400/000/fff"
    @IBOutlet weak var contentView: UIStackView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.addArrangedSubview(canvasView)
    }
    
    @IBAction func saveImage() {
        let image = canvasView.drawing.image(from: canvasView.drawing.bounds, scale: 1.0)
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
    }
    
    @IBAction func clear() {
        canvasView.drawing = PKDrawing()
    }
    
    @IBAction func redo() {
        canvasView.undoManager?.redo()
    }
    @IBAction func undo() {
        canvasView.undoManager?.undo()
    }
    
    
    @IBAction func togglePicker() {
        if canvasView.isFirstResponder{
            canvasView.resignFirstResponder()
        }else{
            canvasView.becomeFirstResponder()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let data = try? Data(contentsOf: URL(string: urlString)!){
            try? canvasView.drawing.append(PKDrawing(data: data))
            setupCanvas()
        }
        setupCanvas()
    }
    func setupCanvas(){
        guard
            let window = view.window,
            let toolPicker = PKToolPicker.shared(for: window) else { return }

        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }

}

