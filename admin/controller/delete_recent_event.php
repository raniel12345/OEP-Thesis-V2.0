<?php session_start();

	require_once("../model/Content_Model.php");

	$contentModel = new Content_Model();

	if ($contentModel->isAdminLoggedIn()){

		if (isset($_POST['eventID'])){

			$eventID = $_POST['eventID'];
			$affectedRow = $contentModel->deleteEvent($eventID);
			
			if ($affectedRow > 0){
				echo "TRUE";
				exit();
			}
		}
	}

	echo "FALSE";
	exit();
?>