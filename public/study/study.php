<?php
require_once '../vars/vars.php';
CheckUserSession();

require_once '../../src/TaiKhoanNguoiDung.php';
if ($_SESSION['isLogin'] == 1) {
  $nguoiDung = new MagicClass\TaiKhoanNguoiDung($pdo);
  $nguoiDung = $nguoiDung->FindTaiKhoanNguoiDungByUsername($_SESSION['username']);
} else {
  Redirection('../home');
}

if ($nguoiDung->cauHoiHienTai == 0) {
  Redirection('../study');
}

if ($_SESSION["isStudy"] != "1") {
  Redirection('../study');
}
$_SESSION["isStudy"] = "0";

if (isset($_GET['maCauTraLoi']) && isset($_GET['noiDungTraLoi'])) {
  $maCauTraLoi = $_GET['maCauTraLoi'];
  $noiDungTraLoi = $_GET['noiDungTraLoi'];
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet" />

  <title>Cyborg - Awesome HTML5 Template</title>

  <!-- Bootstrap core CSS -->
  <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

  <!-- Additional CSS Files -->
  <link rel="stylesheet" href="../assets/css/fontawesome.css" />
  <link rel="stylesheet" href="../assets/css/templatemo-cyborg-gaming.css" />
  <link rel="stylesheet" href="../assets/css/owl.css" />
  <link rel="stylesheet" href="../assets/css/animate.css" />
  <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css" />
  <!--

TemplateMo 579 Cyborg Gaming

https://templatemo.com/tm-579-cyborg-gaming

-->
</head>

<body>
  <!-- ***** Preloader Start ***** -->
  <div id="js-preloader" class="js-preloader">
    <div class="preloader-inner">
      <span class="dot"></span>
      <div class="dots">
        <span></span>
        <span></span>
        <span></span>
      </div>
    </div>
  </div>
  <!-- ***** Preloader End ***** -->

  <!-- ***** Header Area Start ***** -->
  <?php
  include '../header/header.php';
  ?>
  <!-- ***** Header Area End ***** -->

  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <div class="page-content">
          <!-- ***** Banner Start ***** -->
          <div class="main-banner">
            <div class="row">
              <div class="col-lg-7">
                <div class="header-text">
                  <h6>Chào mừng bạn</h6>
                  <h4><em>Đến với </em> <br> Hội nghiên cứu <br>học thuật</h4>
                </div>
              </div>
            </div>
          </div>
          <!-- ***** Banner End ***** -->

          <!-- ***** Most Popular Start ***** -->
          <div class="most-popular">
            <div class="row">
              <div class="col-lg-12 text-light text-center mb-3">
                <?php
                $query = 'CALL GetNoiDungSauTraLoiByMaCauTraLoi(?)';
                try {
                  $sth = $pdo->prepare($query);

                  $sth->execute(
                    [
                      $maCauTraLoi
                    ]
                  );
                } catch (PDOException $e) {
                  $pdo_error = $e->getMessage();
                }

                while ($row = $sth->fetch()) {
                  echo htmlspecialchars($row['noi_dung_sau_tra_loi']);
                }
                ?>
                <br>
                <?php
                $query = 'CALL SelectCauTraLoiByUsername(?,?)';
                try {
                  $sth = $pdo->prepare($query);

                  $sth->execute(
                    [
                      $_SESSION["username"],
                      $noiDungTraLoi
                    ]
                  );
                } catch (PDOException $e) {
                  $pdo_error = $e->getMessage();
                }

                if ($row = $sth->fetch()) {
                  echo '<br>Tiền nhận được: ' . htmlspecialchars($row['tien_cau_hoi']);
                  echo '<br>Kinh nghiệm nhận được: ' . htmlspecialchars($row['kinh_nghiem_cau_hoi']);
                }

                $query = 'CALL ChangeCauHoiByUsername(?)';
                try {
                  $sth = $pdo->prepare($query);

                  $sth->execute(
                    [
                      $_SESSION["username"]
                    ]
                  );
                } catch (PDOException $e) {
                  $pdo_error = $e->getMessage();
                }

                ?>
                <div style="height: 20px; width: 50px; text-align:center"></div>
                <div class="main-button">
                  <a href="../study/">Tiếp tục cuộc hành trình >> </a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- ***** Most Popular End ***** -->

      </div>
    </div>
  </div>
  </div>

  <footer>
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <p>
            Copyright © 2036 <a href="#">Cyborg Gaming</a> Company. All rights reserved.

            <br />Design: <a href="https://templatemo.com" target="_blank" title="free CSS templates">TemplateMo</a> Distributed By <a href="https://themewagon.com" target="_blank">ThemeWagon</a>
          </p>
        </div>
      </div>
    </div>
  </footer>

  <!-- Scripts -->
  <!-- Bootstrap core JavaScript -->
  <script src="../vendor/jquery/jquery.min.js"></script>
  <script src="../vendor/bootstrap/js/bootstrap.min.js"></script>

  <script src="../assets/js/isotope.min.js"></script>
  <script src="../assets/js/owl-carousel.js"></script>
  <script src="../assets/js/tabs.js"></script>
  <script src="../assets/js/popup.js"></script>
  <script src="../assets/js/custom.js"></script>
  <script src="../home/main.js"></script>
</body>

</html>