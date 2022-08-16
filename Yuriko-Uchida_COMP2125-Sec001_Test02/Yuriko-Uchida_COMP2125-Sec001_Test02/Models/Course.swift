//
//  Course.swift
//  Yuriko-Uchida_COMP2125-Sec001_Test02
//
//  Created by user212402 on 2022-08-15.
//

import Foundation

class Course{

    public var courseId: Int
    public var courseName: String
    public var credit: Int
    public var courseFee: Float
    public var semester: String
    
    init(){
        self.courseId = 0
        self.courseName = ""
        self.credit = 0
        self.courseFee = 0.0
        self.semester = ""
    }
}
