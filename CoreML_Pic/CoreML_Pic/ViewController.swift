//
//  ViewController.swift
//  CoreML_Pic
//
//  Created by Akash soni on 03/10/23.
//

import UIKit
import Photos
import Vision

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var images = [PHAsset]()
    private var selectedImage: UIImage? {
        didSet {
            self.recognizeText(in: self.selectedImage)
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        populatePhotos()
        collectionView.contentInset = .init(top: 0, left: collectionView.bounds.size.width / 2, bottom: 0, right: collectionView.bounds.size.width / 2)
    }
        
    func recognizeText(in image: UIImage?) {
        guard let cgImage = image?.cgImage else { return }
        
        let request = VNRecognizeTextRequest { (request, error) in
            if let results = request.results as? [VNRecognizedTextObservation] {
                var recognizedText = ""
                for observation in results {
                    if let candidate = observation.topCandidates(1).first {
                        recognizedText += candidate.string + "\n"
                    }
                }
                // Display the recognized text in your UITextView or UILabel
                print("Recognized text = \(recognizedText)")
                
                DispatchQueue.main.async {
                    self.textView.text = recognizedText
                }
            }
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("Error: \(error)")
        }
    }

    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            
            if status == .authorized {
                
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                
                assets.enumerateObjects { (object,_, _) in
                    self?.images.append(object)
                }
                
                self?.images.reverse()
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
            
        }
        
    }

}


extension ViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerPoint = CGPoint(x: collectionView.contentOffset.x + collectionView.bounds.size.width / 2, y: collectionView.bounds.size.height / 2)
        
        if let indexPath = collectionView.indexPathForItem(at: centerPoint) {
            let asset = self.images[indexPath.row]
            let manager = PHImageManager.default()
            
            manager.requestImage(for: asset, targetSize: CGSize(width: 400, height: 700), contentMode: .aspectFit, options: nil) { image, _ in
                
                DispatchQueue.main.async {
                    self.selectedImage = image
                    self.imageView.image = image
                    
                }
                
            }
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FooterCollectionViewCell", for: indexPath) as? FooterCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.photoView.tag = indexPath.item
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 30, height: 50), contentMode: .aspectFit, options: nil) { image, _ in
            
            DispatchQueue.main.async {
                cell.photoView.setImage(image, for: .normal)
            }
            
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
}
