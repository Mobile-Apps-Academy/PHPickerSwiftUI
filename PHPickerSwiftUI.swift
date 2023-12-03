//
// Created By: Mobile Apps Academy
// Subscribe : https://www.youtube.com/@MobileAppsAcademy?sub_confirmation=1
// Medium Blob : https://medium.com/@mobileappsacademy
// LinkedIn : https://www.linkedin.com/company/mobile-apps-academy
// Twitter : https://twitter.com/MobileAppsAcdmy
// Lisence : https://github.com/Mobile-Apps-Academy/MobileAppsAcademyLicense/blob/main/LICENSE.txt
//

import PhotosUI
import SwiftUI

var preselectedAssetIdentifiers = [String]()

struct PHPickerSwiftUI: UIViewControllerRepresentable {
   
    @Environment(\.presentationMode) var presentationMode
    let config: PHPickerConfiguration
    let completion: (_ selectedImages: [PHPickerResult]) -> Void
    
    func makeUIViewController(context: Context) ->  PHPickerViewController {
        
        let controller = PHPickerViewController(configuration: config) // We need a config for phpicker, which we'll add it later.
        controller.delegate = context.coordinator //This is coordinator which we ll create now.
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // We'll not update anything on this view.
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self) // This class is not yet created.
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        let parent: PHPickerSwiftUI
        
        init(parent: PHPickerSwiftUI) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            preselectedAssetIdentifiers = results.map(\.assetIdentifier!)
            
            self.parent.completion(results)
            //We'll dismiss this using presentationMode
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
}
