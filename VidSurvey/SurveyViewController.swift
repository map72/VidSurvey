
import UIKit
import ResearchKit

class SurveyViewController: UIViewController, ORKTaskViewControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let taskViewController = ORKTaskViewController(task: BodyPartImageTask, taskRun: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        present(taskViewController, animated: true, completion: nil)
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        detailViewController.shareURL = taskViewController.outputDirectory
        taskViewController.present(detailViewController,animated:false, completion:nil)
    }
    
    var BodyPartImageTask: ORKTask {
        var steps = [ORKStep]()
        var videoCaptureSteps = [ORKVideoCaptureStep]()
        var instructionSteps =  [ORKInstructionStep]()
        
        for index in 1...2{
    
            let videoCaptureStep =  setCommonVideoCaptureSteps(index: index)
            videoCaptureSteps.append(videoCaptureStep)
            
            let instructionStep = ORKInstructionStep(identifier: "videoInstructionStep" + String(index))
            instructionStep.title = NSLocalizedString("Capitalism", comment: "")
            
            switch index {
                
                case 1:
                 instructionStep.text = "Is there a specific object that you think should be included in the collection of the Museum of Capitalism? Describe the object. (It could also be an entire site or an intangible experience.) Why does it belong in the Museum?"
                
                case 2:
                 instructionStep.text = "When did capitalism begin?"
                
                default:
                 instructionStep.text = "Unknown"
                
            }
            instructionSteps.append(instructionStep)
        
        }
        
        return ORKOrderedTask(identifier: "BodyPartImageTask", steps: [
            instructionSteps[0],
            videoCaptureSteps[0],
            instructionSteps[1],
            videoCaptureSteps[1]
            ])
    }
    
    func setCommonVideoCaptureSteps(index: Int) -> ORKVideoCaptureStep{
        let videoCaptureStep =  ORKVideoCaptureStep(identifier: "VideoCaptureStep" + String(index))
        videoCaptureStep.accessibilityInstructions = NSLocalizedString("Your instructions for capturing the video", comment: "")
        videoCaptureStep.templateImageInsets = UIEdgeInsets(top: 0.05, left: 0.05, bottom: 0.05, right: 0.05)
        videoCaptureStep.duration = 30.0; // 30 seconds
        videoCaptureStep.devicePosition = AVCaptureDevicePosition.front // change to the front camera
        return videoCaptureStep
    }


    
}


