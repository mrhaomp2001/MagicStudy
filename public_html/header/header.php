<header class="header-area header-sticky">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <nav class="main-nav">
                    <!-- ***** Logo Start ***** -->
                    <a href="../home" class="logo">
                        <img src="../assets/images/logo.png" alt="">
                    </a>
                    <!-- ***** Logo End ***** -->
                    <!-- ***** Search End ***** -->
                    <!-- <div class="search-input">
                        <form id="search" action="#">
                            <input type="text" placeholder="Type Something" id='searchText' name="searchKeyword" onkeypress="handle" />
                            <i class="fa fa-search"></i>
                        </form>
                    </div> -->
                    <!-- ***** Search End ***** -->
                    <!-- ***** Menu Start ***** -->
                    <ul class="nav">
                        <li><a href="">Home</a></li>
                        <li><a href="">Browse</a></li>
                        <li><a href="">Details</a></li>
                        <li><a href="">Streams</a></li>
                        <?php
                        if ($_SESSION["isLogin"] == -1) {
                            echo '<li><a href="../login">Đăng nhập <img src="../assets/images/profile-header.jpg" alt=""></a></li>';
                        } else if ($_SESSION["isLogin"] == 1) {
                            echo '<li><a href="#">'. $nguoiDung->tenNguoiDung .'<img src="../assets/images/profile-header.jpg" alt=""></a></li>';
                        }
                        ?>
                    </ul>
                    <a class='menu-trigger'>
                        <span>Menu</span>
                    </a>
                    <!-- ***** Menu End ***** -->
                </nav>
            </div>
        </div>
    </div>
</header>