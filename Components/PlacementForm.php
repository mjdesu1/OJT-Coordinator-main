<?php
session_start();
$dbhost = "localhost";
$dbusername = "root";
$dbpassword = "";
$dbname = "ojtcs_database";

try {
    $conn = mysqli_connect($dbhost, $dbusername, $dbpassword, $dbname);
    if ($conn) {
    } else {
        echo "<script>console.log('Failed to connect to database.');</script>";
    }
} catch (\Throwable $th) {
    header("location: ErrorPage.php?error=500");
}

$sql = "SELECT * FROM tbl_programs WHERE progID = '" . $_SESSION['USERID'] . "'";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        $title = $row['title'];
        $description = $row['description'];
        $date = date("F j, Y", strtotime($row['start_date']));
        $comp = date("F j, Y", strtotime($row['end_date']));
        $venue = $row['progloc'];
        $start = date("h:i A", strtotime($row['start_time']));
        $end = date("h:i A", strtotime($row['end_time']));
        $duration = $row['Duration'] . " Weeks";
        $super = $row['Supervisor'];
    }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../Style/Bootstrap_Style/bootstrap.css">
    <title>Placement Form</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        .header-container {
            position: relative;
            text-align: center;
            padding: 5px 0;
            border-bottom: 2px solid #000;
            margin-bottom: 10px;
        }

        .logo-left {
            position: absolute;
            top: 2px;
            left: 15px;
            width: 28px;
            height: 28px;
            object-fit: contain;
        }

        .logo-right {
            position: absolute;
            top: 2px;
            right: 15px;
            width: 28px;
            height: 28px;
            object-fit: contain;
        }

        .header-text {
            margin: 0 50px;
            line-height: 1.1;
        }

        .header-text .country {
            font-size: 8px;
            font-weight: normal;
            margin: 0;
            letter-spacing: 0.3px;
        }

        .header-text .school-name {
            font-size: 9px;
            font-weight: bold;
            margin: 1px 0 0 0;
            letter-spacing: 0.5px;
        }

        .header-text .location {
            font-size: 8px;
            font-style: normal;
            margin: 0;
            letter-spacing: 0.2px;
        }

        .header-text .contact {
            font-size: 6px;
            margin: 1px 0 0 0;
            letter-spacing: 0.1px;
        }

        .header-text .website {
            font-size: 6px;
            font-weight: normal;
            margin: 0;
            letter-spacing: 0.1px;
        }

        .header-text .website a {
            color: #000;
            text-decoration: none;
        }

        body {
            font-family: Arial, sans-serif;
            margin: 15px;
        }

        h3 {
            text-align: center;
            font-size: 16px;
            margin: 15px 0;
            font-weight: bold;
        }

        .form-container {
            max-width: 800px;
            margin: 0 auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 12px;
            margin-bottom: 15px;
        }

        table tr {
            border-bottom: 1px solid #ddd;
        }

        table th {
            text-align: left;
            padding: 8px 12px;
            font-weight: bold;
            background-color: #f8f9fa;
            width: 40%;
        }

        table td {
            padding: 8px 12px;
            width: 60%;
        }

        .description-section {
            margin-top: 20px;
        }

        .description-section h4 {
            font-size: 14px;
            margin-bottom: 8px;
            font-weight: bold;
        }

        .description-text {
            font-size: 11px;
            line-height: 1.4;
            text-align: justify;
            padding: 10px;
            background-color: #f8f9fa;
            border-left: 3px solid #007bff;
        }
    </style>
</head>

<body>
    <header>
        <div class="header-container">
            <!-- ASSCAT Logo (Left) -->
            <img src="https://tse1.mm.bing.net/th?id=OIP.Io0CSZ-c6H2XA9KnczZmLAHaHa&pid=Api&P=0&h=220" 
                 alt="ASSCAT Logo" class="logo-left">
            
            <!-- Department Logo (Right) -->
            <img src="https://tse4.mm.bing.net/th?id=OIP.oZn4j3_rbFhI7mU7XlRqMwHaHa&pid=Api&P=0&h=220" 
                 alt="Department Logo" class="logo-right">
            
            <!-- Header Text -->
            <div class="header-text">
                <div class="country">Republic of the Philippines</div>
                <div class="school-name">AGUSAN DEL SUR STATE COLLEGE OF AGRICULTURE AND TECHNOLOGY</div>
                <div class="location">Bunawan, Agusan del Sur</div>
                <div class="contact">Tel. No: (085) 343-0760 | Email: info@asscat.edu.ph</div>
                <div class="website"><a href="https://www.asscat.edu.ph/" target="_blank">www.asscat.edu.ph</a></div>
            </div>
        </div>
    </header>
    
    <main>
        <div class="form-container">
            <h3>PLACEMENT FORM</h3>
            
            <table>
                <tr>
                    <th>Name of Trainee:</th>
                    <td><?php echo $_SESSION['GlobalName']; ?></td>
                </tr>
                <tr>
                    <th>Email Address:</th>
                    <td><?php echo $_SESSION['GlobalEmail']; ?></td>
                </tr>
                <tr>
                    <th>Contact Number:</th>
                    <td><?php echo $_SESSION['GlobalPhone']; ?></td>
                </tr>
                <tr>
                    <th>Course and Section:</th>
                    <td><?php echo $_SESSION['GlobalCourse']; ?></td>
                </tr>
                <tr>
                    <th>Main Address:</th>
                    <td><?php echo $_SESSION['GlobalAddress']; ?></td>
                </tr>
                <tr>
                    <th>Program:</th>
                    <td><?php echo $title; ?></td>
                </tr>
                <tr>
                    <th>Program Duration:</th>
                    <td><?php echo $duration; ?></td>
                </tr>
                <tr>
                    <th>Program Start Date:</th>
                    <td><?php echo $date; ?></td>
                </tr>
                <tr>
                    <th>Estimated Completion Date:</th>
                    <td><?php echo $comp; ?></td>
                </tr>
                <tr>
                    <th>Location:</th>
                    <td><?php echo $venue; ?></td>
                </tr>
                <tr>
                    <th>Time:</th>
                    <td><?php echo $start . " - " . $end; ?></td>
                </tr>
                <tr>
                    <th>Supervisor:</th>
                    <td><?php echo $super; ?></td>
                </tr>
            </table>

            <div class="description-section">
                <h4>Program Description:</h4>
                <div class="description-text">
                    <?php echo $description; ?>
                </div>
            </div>
        </div>
    </main>
    
</body>

</html>