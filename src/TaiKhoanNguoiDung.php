<?php
namespace MagicClass;

class TaiKhoanNguoiDung
{
    private $db;

    public $username;
    public $password;
    public $maLop;
    public $tenLop;
    public $maNguoiDung;
    public $tenNguoiDung;
    public $doDoi;
    public $tien;
    public $kinhNghiem;
    public $maLoaiTaiKhoan;
    public $tenLoaiTaiKhoan;
    public $cauHoiHienTai;


    public function __construct($pdo)
    {
        $this->db = $pdo;
    }

    public function FindTaiKhoanNguoiDungByUsername($usernameT)
    {
        $stmt = $this->db->prepare('CALL FindTaiKhoanNguoiDungByUsername(?)');
        $stmt->execute(
            [
                $usernameT
            ]
        );

        if ($row = $stmt->fetch()) {
            $this->username = $row['username'];
            $this->password = $row['password'];
            $this->maLop = $row['ma_lop'];
            $this->tenLop = htmlspecialchars($row['ten_lop']);
            $this->maNguoiDung = $row['ma_nguoi_dung'];
            $this->tenNguoiDung = htmlspecialchars($row['ten_nguoi_dung']);
            $this->doDoi = $row['do_doi'];
            $this->tien = $row['tien'];
            $this->kinhNghiem = $row['kinh_nghiem'];
            $this->maLoaiTaiKhoan = $row['ma_loai_tai_khoan'];
            $this->tenLoaiTaiKhoan = htmlspecialchars($row['ten_loai_tai_khoan']);
            $this->cauHoiHienTai = $row['cau_hoi_hien_tai'];
        }
        return $this;
    }
}
