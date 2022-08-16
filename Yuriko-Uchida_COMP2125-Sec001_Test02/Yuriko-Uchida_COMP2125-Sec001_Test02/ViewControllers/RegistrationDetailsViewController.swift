//
//  RegistrationDetailsViewController.swift
//  Yuriko-Uchida_COMP2125-Sec001_Test02
//
//  Created by user212402 on 2022-08-15.
//

import UIKit

class RegistrationDetailsViewController: UIViewController {

    var student = Student();
    var course = Course();
    
    
    @IBOutlet weak var studentNameTextField: UITextField!
    @IBOutlet weak var courseNameTextField: UITextField!
    @IBOutlet weak var totalCourseFeeTextField: UITextField!
    @IBOutlet weak var semesterTextField: UITextField!
    @IBOutlet weak var registrationMsgTextField: UITextView!
    
    @IBOutlet weak var semesterAlertLabel: UILabel!
    
    
    @IBAction func submit(_ sender: Any) {
        if (validate()){
            registrationMsgTextField.isHidden = false
            let totalFee = course.courseFee * Float(course.credit)
            let msg =
            "- Student ID : \(student.studentId)\n- Student Name : \(student.studentName)\n- Course ID : \(course.courseId)\n- Course Name : \(course.courseName)\n- Total Course Fee : $\(totalFee)\n- Semester : \(String(describing: semesterTextField.text!) )"
            registrationMsgTextField.text = msg;

        }

    }
    
    func validate() -> Bool {
        var isValid = true;
        //Regular expression for project name
        let nameRange = NSRange(location: 0, length: semesterTextField.text!.count)
        let nameRegex = try! NSRegularExpression(pattern: "^[a-zA-Z]{1}[a-zA-Z ]*$")
        isValid = (nameRegex.firstMatch(in: semesterTextField.text!, options: [], range: nameRange) != nil)
        
        if(!isValid){
            semesterAlertLabel.isHidden = false;
            semesterAlertLabel.text = "Semester can not be empty"
        }
        return isValid
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Assign the input vals previously user typed
        studentNameTextField.text = "Student Name : " + student.studentName;
        courseNameTextField.text = "Course Name : " + course.courseName;
        let totalFee = course.courseFee * Float(course.credit)
        totalCourseFeeTextField.text = "Total Course Fee : $" + String(totalFee);
        if (course.semester != ""){
            semesterTextField.text = course.semester;
        }

    }
    

}
