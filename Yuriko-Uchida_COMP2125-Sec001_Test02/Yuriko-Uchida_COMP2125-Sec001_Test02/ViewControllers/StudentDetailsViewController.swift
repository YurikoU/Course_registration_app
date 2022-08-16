//
//  StudentDetailsViewController.swift
//  Yuriko-Uchida_COMP2125-Sec001_Test02
//
//  Created by user212402 on 2022-08-15.
//

import UIKit

class StudentDetailsViewController: UIViewController {
    
    
    var student = Student();
    var course = Course();
    
    @IBOutlet weak var studentIdTextField: UITextField!
    @IBOutlet weak var studentNameTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var studentAddressTextField: UITextField!
    
    
    @IBOutlet weak var studentNameAlertLabel: UILabel!
    @IBOutlet weak var emailIdAlertLabel: UILabel!
    @IBOutlet weak var studentAddressAlertLabel: UILabel!

    
    
    @IBAction func goToCourseDetails(_ sender: Any) {
        var isValid = shouldPerformSegue(withIdentifier: "CourseDetailsViewController", sender: nil)
        if (isValid){
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailsViewController") as! CourseDetailsViewController
            student.studentName = studentNameTextField.text!
            student.emailId     = Int(emailIdTextField.text!)!
            student.studentAddress = studentAddressTextField.text!
            nextVC.course = course
            nextVC.student = student
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Assign the input vals previously user typed
        if (student.studentId == 0){
            student.studentId = Int.random(in: 100000..<1000000)
        }
        studentIdTextField.text = "Student ID : " + String(student.studentId);
        if (student.studentName != ""){
            studentNameTextField.text = student.studentName;
        }
        if (student.emailId != 0){
            emailIdTextField.text = String(student.emailId);
        }
        if (student.studentAddress != ""){
            studentAddressTextField.text = student.studentAddress;
        }
    }

    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var isValid = true;
        var isNameValid = true;
        var isEmailIdValid = true;
        
        //Regular expression for name
        let nameRange = NSRange(location: 0, length: studentNameTextField.text!.count)
        let nameRegex = try! NSRegularExpression(pattern: "^[a-zA-Z]{1}[a-zA-Z ]*$")
        isNameValid = (nameRegex.firstMatch(in: studentNameTextField.text!, options: [], range: nameRange) != nil)
        
        //Validate
        if(!isNameValid){
            studentNameAlertLabel.isHidden = false
            studentNameAlertLabel.text = "Student name can not be empty"
        }
        if (emailIdTextField.text == ""){
            isEmailIdValid = false
            emailIdAlertLabel.isHidden = false
            emailIdAlertLabel.text = "Email ID can not be empty"
        }
        if(!isNameValid || !isEmailIdValid){
            isValid = false
        }
        
        
        return isValid;
    }
    
    

}
