DROP DATABASE IF EXISTS HoiHocThuat;

CREATE DATABASE IF NOT EXISTS HoiHocThuat;
USE HoiHocThuat;
# -----------------------------------------------------------------------------
#       TABLE : CAU_HOI
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CAU_HOI
 (
   MA_CAU_HOI INTEGER NOT NULL AUTO_INCREMENT ,
   MA_LOP INTEGER NOT NULL  ,
   NOI_DUNG_CAU_HOI VARCHAR(256) NULL  ,
   CAU_TRA_LOI_DUNG VARCHAR(256) NULL  ,
   TIEN_CAU_HOI INTEGER NULL  ,
   KINH_NGHIEM_CAU_HOI INTEGER NULL  
   , PRIMARY KEY (MA_CAU_HOI) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : NGUOI_DUNG
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS NGUOI_DUNG
 (
   MA_NGUOI_DUNG INTEGER NOT NULL AUTO_INCREMENT ,
   USERNAME CHAR(32) NOT NULL  ,
   TEN_NGUOI_DUNG VARCHAR(128) NULL  ,
   DO_DOI INTEGER NULL  ,
   TIEN INTEGER NULL  ,
   KINH_NGHIEM INTEGER NULL  ,
   CAU_HOI_HIEN_TAI INTEGER NULL  
   , PRIMARY KEY (MA_NGUOI_DUNG) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : TAI_KHOAN
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS TAI_KHOAN
 (
   USERNAME CHAR(32) NOT NULL  ,
   MA_LOP INTEGER NOT NULL  ,
   MA_LOAI_TAI_KHOAN INTEGER NOT NULL  ,
   PASSWORD VARCHAR(64) NULL  ,
   USER_SESSION_ID CHAR(32) NULL  
   , PRIMARY KEY (USERNAME) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : LOAI_TAI_KHOAN
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS LOAI_TAI_KHOAN
 (
   MA_LOAI_TAI_KHOAN INTEGER NOT NULL AUTO_INCREMENT ,
   TEN_LOAI_TAI_KHOAN VARCHAR(128) NULL  
   , PRIMARY KEY (MA_LOAI_TAI_KHOAN) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : CAU_TRA_LOI
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CAU_TRA_LOI
 (
   MA_CAU_TRA_LOI INTEGER NOT NULL AUTO_INCREMENT ,
   MA_CAU_HOI INTEGER NOT NULL  ,
   NOI_DUNG_TRA_LOI VARCHAR(256) NULL  ,
   NOI_DUNG_SAU_TRA_LOI VARCHAR(256) NULL  
   , PRIMARY KEY (MA_CAU_TRA_LOI) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : LOP_HOC
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS LOP_HOC
 (
   MA_LOP INTEGER NOT NULL AUTO_INCREMENT ,
   TEN_LOP VARCHAR(128) NULL  ,
   MIEU_TA VARCHAR(256) NULL  
   , PRIMARY KEY (MA_LOP) 
 ) 
 comment = "";


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE CAU_HOI 
  ADD FOREIGN KEY FK_CAU_HOI_LOP_HOC (MA_LOP)
      REFERENCES LOP_HOC (MA_LOP) ;


ALTER TABLE NGUOI_DUNG 
  ADD FOREIGN KEY FK_NGUOI_DUNG_TAI_KHOAN (USERNAME)
      REFERENCES TAI_KHOAN (USERNAME) ;


ALTER TABLE TAI_KHOAN 
  ADD FOREIGN KEY FK_TAI_KHOAN_LOP_HOC (MA_LOP)
      REFERENCES LOP_HOC (MA_LOP) ;


ALTER TABLE TAI_KHOAN 
  ADD FOREIGN KEY FK_TAI_KHOAN_LOAI_TAI_KHOAN (MA_LOAI_TAI_KHOAN)
      REFERENCES LOAI_TAI_KHOAN (MA_LOAI_TAI_KHOAN) ;


ALTER TABLE CAU_TRA_LOI 
  ADD FOREIGN KEY FK_CAU_TRA_LOI_CAU_HOI (MA_CAU_HOI)
      REFERENCES CAU_HOI (MA_CAU_HOI) ;

