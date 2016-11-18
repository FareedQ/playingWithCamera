import UIKit
import AVFoundation

class MainVC: UIViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var cameraView: UIView!
    
    var captureSession:AVCaptureSession?
    var stillImageOutput:AVCaptureStillImageOutput?
    var previewLayer:AVCaptureVideoPreviewLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        let error: NSError? = nil
        do {
            let input = try AVCaptureDeviceInput(device:backCamera)
            if error == nil && (captureSession?.canAddInput(input))! {
                captureSession?.addInput(input)
                stillImageOutput = AVCaptureStillImageOutput()
                stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
                
                if ((captureSession?.canAddOutput(stillImageOutput)) != nil) {
                    captureSession?.addOutput(stillImageOutput)
                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                    previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                    cameraView.layer.addSublayer(previewLayer!)
                    captureSession?.startRunning()
                }
            }
            
        } catch {
            print(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = cameraView.bounds
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
