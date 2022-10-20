<?php
session_start();

try {
    $pdo = new PDO('mysql:host=localhost;dbname=hoihocthuat', 'root', '');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    $error_message = 'Không thể kết nối đến CSDL';
    $reason = $e->getMessage();
    include 'show_error.php';

    include 'footer.php';
    exit();
}

if (!isset($_SESSION["isLogin"])) {
    $_SESSION["isLogin"] = -1;
}

if (!isset($_SESSION["username"])) {
    $_SESSION["username"] = "";
}

if (!isset($_SESSION["user_session_id"])) {
    $_SESSION["user_session_id"] = "";
}


if (!isset($_SESSION["isStudy"])) {
    $_SESSION["isStudy"] = "";
}




function CheckLogin()
{
    if ($_SESSION['isLogin'] == 1) {
        header('Location: ../home');
        exit();
    }
}

function Redirection(string $location)
{
    header('Location: ' . $location);
    exit();
}

function CheckUserSession()
{
    try {
        $pdo = new PDO('mysql:host=localhost;dbname=hoihocthuat', 'root', '');
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $e) {
        $error_message = 'Không thể kết nối đến CSDL';
        $reason = $e->getMessage();
        include 'show_error.php';

        include 'footer.php';
        exit();
    }

    $query = "CALL GET_USER_SESSION_ID(?)";

    if ($_SESSION['isLogin'] == 1) {
        $sth = $pdo->prepare($query);

        $sth->execute(
            [
                $_SESSION['username']
            ]
        );

        while ($row = $sth->fetch()) {
            if ($row['USER_SESSION_ID'] != $_SESSION['user_session_id']) {
                Redirection('../logout');
            }
        }


        try {
        } catch (PDOException $e) {
            $pdo_error = $e->getMessage();
        }
    }
}

require '../vendor/Psr4AutoloaderClass.php';
$loader = new Psr4AutoloaderClass;
$loader->register();
// Các lớp có không gian tên bắt đầu với MagicClass nằm ở src
$loader->addNamespace('MagicClass', __DIR__ . '/src');
