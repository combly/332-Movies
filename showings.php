<?php
// Start the session
session_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Movies for You</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="keywords">
  <meta content="" name="description">

  <!-- Favicons -->
  <link href="https://image.flaticon.com/icons/png/512/184/184578.png" rel="icon">
  <link href="img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Montserrat:300,400,500,700" rel="stylesheet">

  <!-- Bootstrap CSS File -->
  <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Libraries CSS Files -->
  <link href="lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link href="lib/animate/animate.min.css" rel="stylesheet">
  <link href="lib/ionicons/css/ionicons.min.css" rel="stylesheet">
  <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
  <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
  <link href= "css/movie.css" rel="stylesheet">

  <!-- Main Stylesheet File -->
  <link href="css/style.css" rel="stylesheet">

  <!-- =======================================================
    Theme Name: BizPage
    Theme URL: https://bootstrapmade.com/bizpage-bootstrap-business-template/
    Author: BootstrapMade.com
    License: https://bootstrapmade.com/license/
  ======================================================= -->
</head>

<body>

<!--==========================
 Showings Section
============================-->
<section id="movie"  class="section-bg" >
  <div class="container">

<!-- PHP ================-->
<?php

$host = "localhost";
$user = 'root';
$pass = '';
$db = 'moviedb';

$db = new mysqli($host, $user, $pass, $db) or die("Unable to connect");
if ($db->connect_error) {
    die("Connection failed: " . $db->connect_error);
} 

if (isset($_GET["TheatreComplex"])) {
  $theatre = $_GET['TheatreComplex'];
} 

echo "<fieldset>";
echo "<header class='section-header'>
      <br><br>
      <h3 class='section-title'>Showings for $theatre
      </header>";

/* iterate through and select names and emails */
$sql = "SELECT theatre, starttime, day, numseats, movie FROM showing WHERE complex = '$theatre'";
$result = $db->query($sql);
if (!$result) {
    trigger_error('Invalid query: ' . $db->error);
}

$numRows = $result->num_rows;
  if ($numRows > 0) {
    // output data of each row
    echo "<table class='t1'>
            <thead>
            <tr>
                <th>Movie</th>
                <th>Day</th>
                <th>Start Time</th>
                <th>Seats Left</th>
                <th>Theatre</th>
            </tr>
            </thead>
          ";
    while($row = $result->fetch_assoc()) {
      echo "<tbody>";
      echo "<tr>";
      echo "<td>" . $row["movie"] . "</td>";
      echo "<td>" . $row["day"] . "</td>";
      echo "<td>" . $row["starttime"] . "</td>";
      echo "<td>" . $row["numseats"] . "</td>";
      echo "<td>" . $row["theatre"] . "</td>";
      echo "</tr>";
      echo "</tbody>";
      }
    echo "</table>";
    echo "</fieldset>";
  } else {
    echo "0 results";
  }
  $db->close();
?>
<!--END PHP==============-->
<!--END SHOWINGS =========-->

<p style='text-align:center'><a href='http://localhost/#login'>Login to make a reservation</a></p>

</div>
</section>
</body>
</main>

  <!--==========================
    Footer
  ============================-->
  <footer id="footer">

    <div class="container">
      <div class="copyright">
        &copy; Copyright <strong>BizPage</strong>. All Rights Reserved
      </div>
      <div class="credits">
        <!--
          All the links in the footer should remain intact.
          You can delete the links only if you purchased the pro version.
          Licensing information: https://bootstrapmade.com/license/
          Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/buy/?theme=BizPage
        -->
        Best <a href="https://bootstrapmade.com/">Bootstrap Templates</a> by BootstrapMade
      </div>
    </div>
  </footer><!-- #footer -->

  <a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>

  <!-- JavaScript Libraries -->
  <script src="lib/jquery/jquery.min.js"></script>
  <script src="lib/jquery/jquery-migrate.min.js"></script>
  <script src="lib/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="lib/easing/easing.min.js"></script>
  <script src="lib/superfish/hoverIntent.js"></script>
  <script src="lib/superfish/superfish.min.js"></script>
  <script src="lib/wow/wow.min.js"></script>
  <script src="lib/waypoints/waypoints.min.js"></script>
  <script src="lib/counterup/counterup.min.js"></script>
  <script src="lib/owlcarousel/owl.carousel.min.js"></script>
  <script src="lib/isotope/isotope.pkgd.min.js"></script>
  <script src="lib/lightbox/js/lightbox.min.js"></script>
  <script src="lib/touchSwipe/jquery.touchSwipe.min.js"></script>
  <!-- Contact Form JavaScript File -->
  <script src="contactform/contactform.js"></script>

  <!-- Template Main Javascript File -->
  <script src="js/main.js"></script>

</body>
</html>
