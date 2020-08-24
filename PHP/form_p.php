<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
<?php
	
	//Declaring the variables
	$firstName = $surname = $studentID = $courseType = "";
	
	// Class: Units
	class Unit
	{
		//Declaring Private Variables
		private $unitCode;
		private $creditPoints;
		private $yearSemester;
		private $marks;

		function __construct ($unitCode, $creditPoints, $yearSemester, $marks)
		{
			$this->unitCode = $unitCode;
			$this->creditPoints = $creditPoints;
			$this->yearSemester = $yearSemester;
			$this->marks = $marks;
		}

		public function getUnitCode()
		{
			return $this->unitCode;
		}

		public function setUnitCode($unitCode)
		{
			$this->unitCode = $unitCode;
		}

		public function getCreditPoints()
		{
			return $this->creditPoints;
		}

		public function setCreditPoints($creditPoints)
		{
			$this->creditPoints = $creditPoints;
		}
		public function getYearSemester()
		{
			return $this->yearSemester;
		}

		public function setYearSemester($yearSemester)
		{
			$this->yearSemester = $yearSemester;
		}

		public function getMarks()
		{
			return $this->marks;
		}

		public function setMarks($marks)
		{
			$this->marks = $marks;	
		}
	}

	//Function: Validate student information
	function StudentInfoValidation()
	{
		$errorFlag = false;
		if (!preg_match("/^[a-zA-z ]*$/", $_POST["Firstname"]))
		{
			echo "Error: Firstname Entered Incorrectly";
			$errorFlag = true;
		}
		if (!preg_match("/^[a-zA-z ]*$/", $_POST["Surname"]))
		{
			echo "Error: Surname Entered Incorrectly!";
			$errorFlag = true;
		}
		if (!preg_match("/^[0-9]{8}$/", $_POST["StudentID"]))
		{
			$nameErr = "Error: StudentID Entered Incorrectly!";
			$errorFlag = true;
		}
		return $errorFlag;
	}

	//Function: Validate unit information
	function UnitValidation()
	{
		$errorFlag = false;
		for ($i=1;$i<30;$i++)
		{
			if (!empty($_POST["UnitCode_".$i]))
			{
				if (strlen($_POST["UnitCode_".$i])<7)
				{
					echo "Error: Unit Code Entered Incorrectly! <br>";
					$errorFlag = true;
				}
				if (!preg_match("/^(15|20)$/", $_POST["CP_".$i]))
				{
					echo "Error: Credit Points Entered Incorrectly! <br>";
					$errorFlag = true;
				}
				if (!preg_match("/^[0-9]{3}$/", $_POST["YS_".$i]))
				{
					echo "Error: Year Semester Entered Incorrectly! <br>";
					$errorFlag = true;
				}
				if (!preg_match("/^[0-9]*$/", $_POST["UM_".$i]) || $_POST["UM_".$i]<0 || $_POST["UM_".$i]>100)
				{
					echo "Error: Unit Marks Entered Incorrectly! <br>";
					$errorFlag = true;
				}
			}
		}
		return $errorFlag;
	}

	//Function: Calculate Average
	function GetAverage($listOfUnits)
	{
		$sumOfCreditPoints = 0;
		$currentCreditPoints = 0;

		foreach ($listOfUnits as $unit)
		{
			if($unit->getMarks()>=50)
			{
				$sumOfCreditPoints += ($unit->getCreditPoints()*$unit->getMarks());
				$currentCreditPoints += $unit->getCreditPoints();
			}
		}
		$average = $sumOfCreditPoints / $currentCreditPoints;
		return round($average,2);
	}

	//Function: Calculate Total Number of Units Completed
	function UnitsCompleted($listOfUnits)
	{
		$unitsCompleted = 0;
		foreach ($listOfUnits as $unit)
		{
			if ($unit->getMarks()>=50)
			{
				$unitsCompleted++;
			}
		}
		return $unitsCompleted;
	}

	//Function: Calculate Total Credit Points Completed
	function CreditPointsCompleted($listOfUnits)
	{
		$completedCreditPoints = 0;
		foreach ($listOfUnits as $unit)
		{
			if ($unit->getMarks()>=50)
			{
				$completedCreditPoints += $unit->getCreditPoints();
			}
		}
		return $completedCreditPoints;
	}
	
	//Function: Student Exclusion Validation 
	function StudentExclusionValidation($listOfUnits)
	{
		$exclusionArray = [];

		foreach ($listOfUnits as $unit)
		{
			if ($unit->getMarks()<50)
			{
				array_push($exclusionArray, $unit->getUnitCode()); 
			}
		}

		$excludedCourse = array_count_values($exclusionArray);

		if (sizeof($excludedCourse) == 1)
		{
			foreach ($excludedCourse as $key => $value)
			{
				if ($value >= 3)
				{
					echo "Alert: Excluded from Course!";
					exit();
				}
			}
		}
	}

	//Function: Conceded Pass Validation
	function ConcededPassValidation($listOfUnits, $totalCreditPoints, $CreditPointsCompleted)
	{
		$passed = [];
		$failed = [];
		$concededPassArray = [];

		$value = $totalCreditPoints * (2/3);

		if ($CreditPointsCompleted>=$value)
		{
			foreach ($listOfUnits as $unit)
			{
				if ($unit->getMarks()<50)
				{
					$failed[$unit->getUnitCode()] = $unit->getMarks();
				}
			}

			
			foreach ($listOfUnits as $unit)
			{
				if($unit->getMarks()>=50)
				{
					array_push($passed, $unit->getUnitCode());
				} 
			}
			foreach ($failed as $unitCode => $marks) 
			{
				if (!in_array($unitCode, $passed))
				{
					$concededPassArray[$unitCode]=$marks;
				}
			}

			if (sizeof($concededPassArray)==1)
			{
				foreach ($concededPassArray as $unitCode => $marks)
				{
					if ($marks>=40 && $marks<=45)
					{
						echo "Alert! Conceded Pass Granted!";
					}
					else if ($marks>45 && $marks<50)
					{
						echo "Alert! Supplementary Pass Granted!";
					}

				}
			}
		}
	}

	//Function: Calculate Grade
	function GradeValidation($average)
	{
		if ($average>=80 && $average<=100)
			$grade = "HD";
		else if ($average>=70 && $average<=79)
			$grade = "D";
		else if ($average>=60 && $average<=69)
			$grade = "CR";
		else if ($average>=50 && $average<=59)
			$grade = "C";
		else
			$grade = "F";

		return $grade;
	}

	//Validate Request Method
	if ($_SERVER["REQUEST_METHOD"]=="POST")
	{
		//Validate Student Information 
		$errorFlag = StudentInfoValidation();
		if ($errorFlag == True)
		{
			exit();
		}

		$firstName = $_POST["Firstname"];
		$surname = $_POST["Surname"];
		$studentID = (int)$_POST["StudentID"];
		$courseType = $_POST["CourseType"];
		if ($courseType==1)
		{
			$courseType = "Undergraduate Degree";
			$totalCreditPoints = 360;
		}
		else if ($courseType==2)
		{
			$courseType = "Graduate Diploma";
			$totalCreditPoints = 120;
		}
		else if ($courseType==3)
		{
			$courseType = "Masters by Coursework";
			$totalCreditPoints = 180;
		}
		else
		{
			$courseType = "Masters by Research";
			$totalCreditPoints = 240;
		}

		echo "<h1>Course Progress Analyzer</h1>";
		echo "<hr/>";

		echo "<h2>Student Information</h2>";
		echo "<strong>Firstname: </strong>".$firstName."</br>";
		echo "<strong>Surname: </strong>".$surname."</br>";
		echo "<strong>Student ID: </strong>".$studentID."</br>";
		echo "<strong>Course Type: </strong>".$courseType."</br>";		
	}
?>
<?php
	$listOfUnits = [];

	if (UnitValidation()==false)
	{	
		for ($i=1;$i<30;$i++)
		{
			if (!empty($_POST["UnitCode_".$i]))
			{
				$unitCode = $_POST["UnitCode_".$i];
				$creditPoints = $_POST["CP_".$i];
				$yearSemester = $_POST["YS_".$i];
				$marks = $_POST["UM_".$i];

				$unit = new Unit($unitCode,$creditPoints,$yearSemester,$marks);
				array_push($listOfUnits, $unit);		
			}
		}
	}
	else
	{
		exit();
	}

	StudentExclusionValidation($listOfUnits);

	$creditPointsComplete = CreditPointsCompleted($listOfUnits);
	$creditPointsIncomplete = $totalCreditPoints - $creditPointsComplete;
	echo "<h2>Course Details</h2>";
	echo "<strong>Total Course Credit Points: </strong>".$totalCreditPoints."<br>";
	echo "<strong>Total Complete Credit Points: </strong>".$creditPointsComplete."<br>";
	echo "<strong>Total Incomplete Credit Points: </strong>".$creditPointsIncomplete."<br>";


	$unitsCompleted = UnitsCompleted($listOfUnits);
	$unitsAttempted = count($listOfUnits);
	echo "<h2>Unit Details</h2>";
	echo "<strong>Units Attempted: </strong>".$unitsAttempted."<br>";
	echo "<strong>Units Completed: </strong>".$unitsCompleted."<br>";

	echo "<h2>Supplementary and Conceded Pass</h2>";
	ConcededPassValidation($listOfUnits,$totalCreditPoints,$creditPointsComplete);

	$studentAverage = GetAverage($listOfUnits);
	echo "<h2>Performance Details</h2>";
	echo "<strong>Student Average: </strong>".$studentAverage."<br>";
	echo "<strong>Student Grade: </strong>".GradeValidation($studentAverage)."<br>";
?>
</body>
</html>