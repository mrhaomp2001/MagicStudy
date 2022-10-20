<?php
include '../vars/vars.php';
include '../../partials/db_connect.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (!empty($_POST['username']) && !empty($_POST['password'])) {

        $query = 'CALL LOGIN(?, ?)';

        try {
            $sth = $pdo->prepare($query);
            $sth->execute([
                $_POST['username'],
                $_POST['password']
            ]);
        } catch (PDOException $e) {
            $pdo_error = $e->getMessage();
        }

        if ($sth && $sth->rowCount() == 1) {
            $_SESSION['isLogin'] = 1;
            $_SESSION["username"] = $_POST['username'];

            session_regenerate_id();

            $_SESSION["user_session_id"] = session_id();

            $query = "call SET_USER_SESSION_ID(?, ?)";

            try {
                $sth = $pdo->prepare($query);
                $sth->execute([
                    $_POST['username'],
                    $_SESSION["user_session_id"]
                ]);
            } catch (PDOException $e) {
                $pdo_error = $e->getMessage();
            }

            Redirection('../home');
        } else {
            echo 'Lỗi';
            echo 'Không rõ nguyên nhân';
        }
    } else {
        echo 'gõ vô tài khoản và mật khẩu';
    }
}


