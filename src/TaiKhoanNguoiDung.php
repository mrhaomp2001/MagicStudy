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
        $stmt = $this->db->prepare('CALL FINDTAIKHOANNGUOIDUNGBYUSERNAME(?)');
        $stmt->execute(
            [
                $usernameT
            ]
        );

        if ($row = $stmt->fetch()) {
            $this->username = $row['USERNAME'];
            $this->password = $row['PASSWORD'];
            $this->maLop = $row['MA_LOP'];
            $this->tenLop = htmlspecialchars($row['TEN_LOP']);
            $this->maNguoiDung = $row['MA_NGUOI_DUNG'];
            $this->tenNguoiDung = htmlspecialchars($row['TEN_NGUOI_DUNG']);
            $this->doDoi = $row['DO_DOI'];
            $this->tien = $row['TIEN'];
            $this->kinhNghiem = $row['KINH_NGHIEM'];
            $this->maLoaiTaiKhoan = $row['MA_LOAI_TAI_KHOAN'];
            $this->tenLoaiTaiKhoan = htmlspecialchars($row['TEN_LOAI_TAI_KHOAN']);
            $this->cauHoiHienTai = $row['CAU_HOI_HIEN_TAI'];
        }
        return $this;
    }
}
