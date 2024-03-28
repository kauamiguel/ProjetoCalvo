import SwiftUI

struct CameraView: View {
    @State private var image: UIImage?

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Button("Take Photo") {
                    self.showImagePicker()
                }
            }
        }
    }

    func showImagePicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = Coordinator(parent: self)
        UIApplication.shared.windows.first?.rootViewController?.present(picker, animated: true, completion: nil)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
               
                parent.image = selectedImage
            }
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
