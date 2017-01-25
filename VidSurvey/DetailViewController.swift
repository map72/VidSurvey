import UIKit

class DetailViewController: UIViewController {
    
    var shareURL:URL?

    @IBOutlet var webView:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action methods
    @IBAction func share(sender: AnyObject) {
        let objectsToShare = [shareURL]
        let activityController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        let excludedActivities = [UIActivityType.postToFlickr, UIActivityType.postToWeibo, UIActivityType.message, UIActivityType.mail, UIActivityType.print, UIActivityType.copyToPasteboard, UIActivityType.assignToContact, UIActivityType.saveToCameraRoll, UIActivityType.addToReadingList, UIActivityType.postToFlickr, UIActivityType.postToVimeo, UIActivityType.postToTencentWeibo]
        
        activityController.excludedActivityTypes = excludedActivities
        //check ipad
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            //ios > 8.0
           if (activityController.responds(to: #selector(getter: UIViewController.popoverPresentationController)) ) {
                activityController.popoverPresentationController?.sourceView = super.view
                present(activityController, animated: true, completion: nil)
            }
        }
        else {
            present(activityController, animated: true, completion: nil)
        }
    }
}




