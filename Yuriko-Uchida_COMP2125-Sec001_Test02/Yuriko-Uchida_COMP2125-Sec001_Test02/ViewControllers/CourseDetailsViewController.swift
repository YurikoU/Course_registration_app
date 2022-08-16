//
//  CourseDetailsViewController.swift
//  Yuriko-Uchida_COMP2125-Sec001_Test02
//
//  Created by user212402 on 2022-08-15.
//

import UIKit

class CourseDetailsViewController: UIViewController {
    var student = Student();
    var course = Course();
    
    
    
    @IBOutlet weak var courseIdTextField: UITextField!
    @IBOutlet weak var courseNameTextField: UITextField!
    @IBOutlet weak var creditTextField: UITextField!
    @IBOutlet weak var courseFeeTextField: UITextField!
    @IBOutlet weak var courseMsgTextView: UITextView!
    
    @IBOutlet weak var courseNameAlertLabel: UILabel!
    @IBOutlet weak var creditAlertLabel: UILabel!
    @IBOutlet weak var courseFeeAlertLabel: UILabel!
    
    
    
    @IBAction func displayCourseMsg(_ sender: Any) {
        
        courseMsgTextView.isHidden = false
        let msg = "- Course ID : \(course.courseId)\n- Course Name : \(courseNameTextField.text!)\n- Course Credit : \(creditTextField.text!)\n- Course Fee per Credit : $\(courseFeeTextField.text!)"
        courseMsgTextView.text = msg;
        
    }
    
    @IBAction func goToRegistrationDetails(_ sender: Any) {
        var isValid = shouldPerformSegue(withIdentifier: "RegistrationDetailsViewController", sender: nil)
        if (isValid){
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationDetailsViewController") as! RegistrationDetailsViewController
            course.courseName = courseNameTextField.text!
            course.credit	     = Int(creditTextField.text!)!
            course.courseFee = Float(courseFeeTextField.text!)!
            nextVC.student = student
            nextVC.course = course
            self.navigationController?.pushViewController(nextVC, animated: true)
        }

    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Assign the input vals previously user typed
        if (course.courseId == 0){
            course.courseId = Int.random(in: 100..<1000)
        }
        courseIdTextField.text = "Course ID : " + String(course.courseId);
        if (course.courseName != ""){
            courseNameTextField.text = course.courseName;
        }
        if (course.credit != 0){
            creditTextField.text = String(course.credit);
        }
        if (course.courseFee != 0.0){
            courseFeeTextField.text = String(course.courseFee);
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var isValid = true;
        var isNameValid = true;
        var isCreditValid = true;
        var isFeeValid = true;
        
        //Regular expression for name
        let nameRange = NSRange(location: 0, length: courseNameTextField.text!.count)
        let nameRegex = try! NSRegularExpression(pattern: "^[a-zA-Z]{1}[a-zA-Z ]*$")
        isNameValid = (nameRegex.firstMatch(in: courseNameTextField.text!, options: [], range: nameRange) != nil)
        
        //Validate
        if(!isNameValid){
            courseNameAlertLabel.isHidden = false
            courseNameAlertLabel.text = "Course name can not be empty"
        }
        if (creditTextField.text == ""){
            isCreditValid = false
            creditAlertLabel.isHidden = false
            creditAlertLabel.text = "Credit can not be empty"
        } else if (Int(creditTextField.text!)! < 1 || 3 < Int(creditTextField.text!)!){
            isCreditValid = false
            creditAlertLabel.isHidden = false
            creditAlertLabel.text = "Credit must be between 1 and 3"
        }
        if (courseFeeTextField.text == ""){
            isFeeValid = false
            courseFeeAlertLabel.isHidden = false
            courseFeeAlertLabel.text = "Course fee can not be empty"
        } else if (Int(courseFeeTextField.text!)! < 0){
            isFeeValid = false
            courseFeeAlertLabel.isHidden = false
            courseFeeAlertLabel.text = "Course fee must be greater than 0"
        }
        
        if(!isNameValid || !isCreditValid || !isFeeValid){
            isValid = false
        }
        
        
        return isValid;
    }


}
