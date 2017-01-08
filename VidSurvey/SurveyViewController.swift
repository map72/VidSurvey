
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
        
    }
    
    private func taskViewController(taskViewController: ORKTaskViewController, stepViewControllerWillAppear stepViewController: ORKStepViewController){
        stepViewController.skipButtonTitle = "Cancel"
    }
    
    var BodyPartImageTask: ORKOrderedTask {
        var steps = [ORKStep]()
        
        let step =  ORKVideoCaptureStep(identifier: "VideoCaptureStep")
        step.title = "Say Cheese"
        steps.append(step)
        return ORKOrderedTask(identifier: "BodyPartImageTask", steps: steps)
    }
    
}


