<<%@ Page Language ="C#" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title></title>

    <script runat ="server">

        // Declaring Varibales 
        string firstName, surname, courseType;
        int studentID, courseTypeIndex, totalCreditPoints;

        // Create a class for the student units 
        public class Unit
        {
            // Declaring private variables 
            private string unitCode;
            private int creditPoints;
            private int yearSemester;
            private int marks;

            public Unit (string unitCode, int creditPoints, int yearSemester, int marks)
            {
                this.UnitCode = unitCode;
                this.CreditPoints = creditPoints;
                this.YearSemester = yearSemester;
                this.Marks = marks;
            }

            // Defining the properties of Unit class
            public String UnitCode
            {
                get
                {
                    return unitCode;
                }
                set
                {
                    unitCode = value;
                }
            }

            public int CreditPoints
            {
                get
                {
                    return creditPoints;
                }
                set
                {
                    creditPoints = value;
                }
            }

            public int YearSemester
            {
                get
                {
                    return yearSemester;
                }
                set
                {
                    yearSemester = value;
                }
            }

            public int Marks
            {
                get
                {
                    return marks;
                }
                set
                {
                    marks = value;
                }
            }
        }

        // Function: Validate Student Information 
        public bool StudentInfoValidation ()
        {
            // Flag to mark blank fields
            bool error = false;
            Response.Write("<br/>");

            if(!(Regex.IsMatch(Request.Form["Firstname"], @"^[a-zA-Z]+$")))  // Validation for First name
            {
                Response.Write("Error: Student Firstname should be an alphabetic string!</br>");
                error = true;
            }

            if(!(Regex.IsMatch(Request.Form["Surname"], @"^[a-zA-Z]+$")))    //Validation for Surname
            {
                Response.Write("Error: Student Surname should be an alphabetic string!</br>");
                error = true;
            }

            int temp;
            if (!int.TryParse(Request.Form["StudentID"], out temp) || ((Request.Form["StudentID"].ToString().Length < 8))) // Validation for student ID: numerical and not less that 08 digits 
            {
                error = true;
                Response.Write("Error: Student ID should be numerical and less than 08 digits! </br>");

            }
            return error;
        }

        //Function: Validate Unit Information
        public bool UnitValidation ()
        {
            bool error = false;
            for (int i=1; i<30; i++)
            {
                if (!string.IsNullOrEmpty(Request.Form["UnitCode_" + i]))
                {
                    if (Request.Form["UnitCode_" + i].Length < 7)
                    {
                        Response.Write("Error: Unit Code Entered Incorectly!<br>");
                        error = true;
                    }

                    int tempvar1;
                    if (int.TryParse(Request.Form["CP_" + i], out tempvar1))
                    {
                        if (int.Parse(Request.Form["CP_" + i]) != 15 && int.Parse(Request.Form["CP_" + i]) != 20)
                        {
                            Response.Write("Error: Credit Points Entered Incorrectly!<br>");
                            error = true;
                        }
                    }
                    int tempvar2;
                    if (int.TryParse(Request.Form["YS_" + i], out tempvar2))
                    {
                        if (Request.Form["YS_" + i].ToString().Length != 3)
                        {
                            Response.Write("Error: Year Semester Entered Incorrectly!<br>");
                            error = true;
                        }
                    }
                    int tempvar3;
                    if (int.TryParse(Request.Form["UM_" + i], out tempvar3))
                    {
                        if (int.Parse(Request.Form["UM_" + i]) < 0 || int.Parse(Request.Form["UM_" + i]) > 100)
                        {
                            Response.Write("Error: Unit Marks Entered Incorrectly!<br>");
                            error = true;
                        }
                    }
                }

            }
            return error;
        }

        // Function: Calculate the Average
        public double GetAverage (List<Unit> listOfUnits)
        {
            double sumOfCreditPoints = 0.0;
            double currentCreditPoints = 0.0;
            foreach (Unit unit in listOfUnits)
            {
                // credit points are added only if marks are above 50
                if (unit.Marks>=50)
                {
                    sumOfCreditPoints += (unit.CreditPoints * unit.Marks);
                    currentCreditPoints += unit.CreditPoints;
                }
            }
            double average = sumOfCreditPoints/currentCreditPoints;
            return Math.Round(average, 2);
        }

        // Function: Completed Units 
        public int UnitsCompleted (List<Unit> listOfUnits)
        {
            int numberOfUnits = 0;
            foreach (Unit unit in listOfUnits)
            {
                if (unit.Marks >= 50)
                {
                    numberOfUnits++;
                }
            }
            return numberOfUnits;
        }

        //Function: Completed Credit Points
        public int CreditPointsCompleted (List<Unit> listOfUnits)
        {
            int completedCreditPoints=0;
            foreach (Unit unit in listOfUnits)
            {
                if (unit.Marks >= 50)
                {
                    completedCreditPoints += unit.CreditPoints;
                }
            }
            return completedCreditPoints;
        }

        // Function: Student Exclusion Validation
        public void StudentExclusionValidation (List<Unit> listOfUnits)
        {
            List<string> Excluded = new List<string>();
            Dictionary<string, int> ExcludedCourse = new Dictionary<string, int>();
            foreach (Unit unit in listOfUnits)
            {
                if (unit.Marks<50)
                {
                    Excluded.Add(unit.UnitCode);
                }
            }
            foreach (string unit in Excluded)
            {
                if (ExcludedCourse.ContainsKey(unit))
                {
                    int value = ExcludedCourse[unit];
                    value++;
                    ExcludedCourse[unit] = value;
                }
                else
                {
                    ExcludedCourse[unit] = 1;
                }
            }

            
            foreach (KeyValuePair<string, int> keys in ExcludedCourse)
            {
                if (keys.Value >= 3)
                {
                    Response.Write("Alert: Excluded from Course!");
                    Response.End();
                }
            }
            
        }

        // Function: Student Conceded Pass Module 
        public void ConcededPassValidation (List<Unit> listOfUnits, int creditPointsCompleted)
        {
            double value = totalCreditPoints * 2 / 3;

            List<string> passedUnits = new List<string>();
            Dictionary<string, int> failedUnits = new Dictionary<string, int>();
            Dictionary<string, int> concedePass = new Dictionary<string, int>();

            if (creditPointsCompleted >= value)
            {

                foreach (Unit unit in listOfUnits)
                {
                    if (unit.Marks < 50)
                    {
                        failedUnits[unit.UnitCode] = unit.Marks;
                    }
                }

                foreach (Unit unit in listOfUnits)
                {
                    if (unit.Marks >= 50)
                    {
                        passedUnits.Add(unit.UnitCode);
                    }
                }

                foreach (KeyValuePair<string, int> unit in failedUnits)
                {
                    if (!passedUnits.Contains(unit.Key))
                    {
                        concedePass[unit.Key] = unit.Value;
                    }
                }

                if (concedePass.Count == 1)
                {
                    foreach (KeyValuePair<string, int> keys in concedePass)
                    {
                        if (keys.Value >= 40 && keys.Value <= 45)
                        {
                            Response.Write("Alert: Conceded Pass Granted!");
                        }
                        else if (keys.Value > 45 && keys.Value < 50)
                        {
                            Response.Write("Alert: Supp Assessment Granted!");
                        }
                    }
                }
            }
        }

        // Function: Calculate Grade
        public string GradeValidation(double average)
        {
            string grade;
            if (average>=80 && average<=100)
            {
                grade = "HD";
            }
            else if (average>=70 && average<=79)
            {
                grade = "D";
            }
            else if (average>=60 && average<=69)
            {
                grade = "CR";
            }
            else if (average>=50 && average<=59)
            {
                grade = "C";
            }
            else
            {
                grade = "F";
            }
            return grade;
        }

    </script>
</head>
<body>       
    <%
        //Validating the inputs 
        bool studentErrorFlag = StudentInfoValidation();
        if (studentErrorFlag == true)
        {
            Response.End(); // stop page execution if there is error
        }

        // Accessing values from the Form
        firstName = Request.Form["Firstname"];
        surname = Request.Form["Surname"];
        studentID = int.Parse(Request.Form["StudentID"]);
        courseTypeIndex = int.Parse(Request.Form["CourseType"]);

        // Allocating course types for the respective course index
        if (courseTypeIndex == 1)
        {
            courseType = "Undergraduate Degree";
            totalCreditPoints = 360;
        }
        else if (courseTypeIndex == 2)
        {
            courseType = "Graduate Diploma";
            totalCreditPoints = 120;
        }
        else if (courseTypeIndex == 3)
        {
            courseType = "Masters by Coursework";
            totalCreditPoints = 180;
        }
        else
        {
            courseType = "Masters by Research";
            totalCreditPoints = 240;
        }

        // Display Student Details
        Response.Write("<h1> Course Progress Analyzer </h1>");
        Response.Write("<hr/>");

        Response.Write("<h2>Student Information: </h2>");
        Response.Write("<strong>FirstName: </strong>" + firstName + "<br/>");
        Response.Write("<strong>Surname: </strong>" + surname + "<br/>");
        Response.Write("<strong>Student ID: </strong>" + studentID + "<br/>");
        Response.Write("<strong>Course Type: </strong>" + courseType + "<br/>");
    %>

    <%
        //Create a List of Units
        List<Unit> listOfUnits = new List<Unit>();
        for (int i=1; i<30; i++) //traverse through the 30 rows
        {
            if (!string.IsNullOrEmpty(Request.Form["UnitCode_" + i]))
            {
                string unitCode = Request.Form["UnitCode_" + i];
                int creditPoints = int.Parse(Request.Form["CP_" + i]);
                int yearSemester = int.Parse(Request.Form["YS_" + i]);
                int marks = int.Parse(Request.Form["UM_" + i]);

                if (UnitValidation()==false)
                {
                    //Passing values to the object and add to array
                    Unit unit = new Unit(unitCode, creditPoints, yearSemester, marks);
                    listOfUnits.Add(unit);
                }
                else
                {
                    Response.End();
                }
            }
        }

        //Function Decides the exclusion of the sutdent from a subject
        StudentExclusionValidation(listOfUnits);

        //Print Student Course Details
        int creditPointsCompleted = CreditPointsCompleted(listOfUnits);
        int creditPointsIncomplete = totalCreditPoints - creditPointsCompleted;
        Response.Write("<h2>Course Details</h2>");
        Response.Write("<strong>Total Course Credit Points: </strong>" + totalCreditPoints + "</br>");
        Response.Write("<strong>Total Completed Credit Points:  </strong>" + creditPointsCompleted + "</br>");
        Response.Write("<strong>Total Incomplete Credit Points: </strong>" + creditPointsIncomplete + "</br>");

        //Print Student Unit Details
        int unitsCompleted = UnitsCompleted(listOfUnits);
        int unitsAttempted = listOfUnits.Count;
        Response.Write("<h2>Unit Details</h2>");
        Response.Write("<strong>Units Attempted: </strong>" + unitsAttempted + "</br>");
        Response.Write("<strong>Units Completed: </strong>" + unitsCompleted + "</br>");

        //Print Supplementary and Conceded Pass
        Response.Write("<h2>Supplementary and Conceded Pass</h2>");
        ConcededPassValidation(listOfUnits, creditPointsCompleted);

        //Print Student Performance Details
        double studentAverage = GetAverage(listOfUnits);
        Response.Write("<h2>Performance Details</h2>");
        Response.Write("<strong>Student Average : </strong>" + studentAverage + "</br>");
        Response.Write("<strong>Studet Grade: </strong>" + GradeValidation(studentAverage) +"</br>");
    %>
</body>
</html>