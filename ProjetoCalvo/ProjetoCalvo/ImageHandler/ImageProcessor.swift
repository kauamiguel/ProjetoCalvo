//
//  ImageProcessor.swift
//  ImageClassification
//
//  Created by Kaua Miguel on 22/02/24.
//

import CoreVideo


//This class take care of convert an UIImage in pixel buffer image, that is used to coreML see the patterns in the image and return the result

struct ImageProcessor {
    
    static func pixelBuffer (forImage image : CGImage) -> CVPixelBuffer? {
        
        let frameSize = CGSize(width: image.width, height: image.height)
        
        //Create an objects that contem all reference of the pixel in the buffer
        var pixelBuffer : CVPixelBuffer? = nil
        
        //Assign an pixel buffer to the variable that was created
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(frameSize.width), Int(frameSize.height),
        kCVPixelFormatType_32BGRA , nil, &pixelBuffer)
        
        if status != kCVReturnSuccess{
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags.init (rawValue: 0))
        let data = CVPixelBufferGetBaseAddress (pixelBuffer!)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue |
        CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        //The context has all drawing parameters and device specific information to render a paint
        let context = CGContext(data: data, width: Int(frameSize.width), height: Int(frameSize.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        //Draw the context in the specific parameter
        context?.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
    
}
