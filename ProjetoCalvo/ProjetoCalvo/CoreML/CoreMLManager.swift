//
//  CoreMLManager.swift
//  ProjetoCalvo
//
//  Created by Kaua Miguel on 25/03/24.
//

import Foundation
import CoreML
import UIKit


class CoreMLManager{
    var model = try? CalvoModel()
    
    func coreMlResult(forImage image : UIImage) -> String?{
        if let pixelImage = ImageProcessor.pixelBuffer(forImage: image.cgImage!){
            guard let predict = try? model?.prediction(image: pixelImage) else { fatalError() }
            return predict.target
        }
        return nil
    }
    
    
}
