DELIMITER $ 

-- create procedure `ProcedureName`(usernameT char(32))
-- begin
-- end$

CREATE PROCEDURE `Get_User_Session_ID`(usernameT char(32))
begin
	select * from tai_khoan 
    where username = usernameT;
end$

CREATE PROCEDURE `Login`(usernameT char(32), passwordT char(32))
begin
	select * from tai_khoan 
    where username = usernameT
		and password = passwordT;
end$

CREATE PROCEDURE `Set_User_Session_ID`(usernameT char(32), idT varchar(255))
begin
	update tai_khoan 
    set user_session_id = idT
    where username = usernameT;
end$

create procedure `Register`(usernameT char(32), passwordT char(32), ten_nguoi_dungT varchar(128))
begin
	 insert into tai_khoan(`username`, `password`, `ma_lop`, `ma_loai_tai_khoan`) value (usernameT, passwordT, 1, 1);
     insert into nguoi_dung(`username`,`ten_nguoi_dung`, `cau_hoi_hien_tai`, `do_doi`, `tien`, `kinh_nghiem`) value (usernameT, ten_nguoi_dungT, 0, 50, 500, 0);
end$

create procedure `FindTaiKhoanNguoiDungByUsername`(usernameT char(32))
begin
	 select tk.username,
			tk.password,
            lh.ma_lop,
            lh.ten_lop,
            nd.ma_nguoi_dung,
            nd.ten_nguoi_dung,
            nd.do_doi,
            nd.tien,
            nd.kinh_nghiem,
            nd.cau_hoi_hien_tai,
            ltk.ma_loai_tai_khoan,
            ltk.ten_loai_tai_khoan
     from tai_khoan tk join nguoi_dung nd on tk.username = nd.username 
					   join lop_hoc lh on tk.ma_lop = lh.ma_lop 
                       join loai_tai_khoan ltk on tk.ma_loai_tai_khoan = ltk.ma_loai_tai_khoan
     where tk.username = usernameT;
end$



create procedure `ChangeCauHoiByUsername`(usernameT char(32))
begin
	if (select do_doi from nguoi_dung where username = usernameT) > 0 then
		update nguoi_dung
		set cau_hoi_hien_tai = (
			select ma_cau_hoi 
			from cau_hoi 
			where ma_lop = (select ma_lop from tai_khoan where username = usernameT)
			ORDER BY RAND() limit 1)
		where username = usernameT;
	else
		update nguoi_dung
		set cau_hoi_hien_tai = 1
		where username = usernameT;
		end if;
end$

create procedure `SelectCauTraLoiByUsername`(usernameT char(32), cau_tra_loiT varchar(256))
begin
	if ((
    select cau_tra_loi_dung from cau_hoi 
    where ma_cau_hoi = (select cau_hoi_hien_tai from nguoi_dung where username = usernameT)) = cau_tra_loiT)
    then
		update nguoi_dung
        set
			tien = tien + (select tien_cau_hoi from cau_hoi where ma_cau_hoi = (select cau_hoi_hien_tai from nguoi_dung where username = usernameT)),
            kinh_nghiem = kinh_nghiem + (select kinh_nghiem_cau_hoi from cau_hoi where ma_cau_hoi = (select cau_hoi_hien_tai from nguoi_dung where username = usernameT))
		where username = usernameT;
        
        select tien_cau_hoi, kinh_nghiem_cau_hoi 
        from cau_hoi where ma_cau_hoi = (
			select cau_hoi_hien_tai 
            from nguoi_dung 
            where username = usernameT);
    end if;
    if (select do_doi from nguoi_dung where username = usernameT) > 0 then
		update nguoi_dung
		set do_doi = do_doi - 1
		where username = usernameT;
	end if;
end$

create procedure `GetCauHoiHienTaiByUsername`(usernameT char(32))
begin
	select ma_cau_hoi,
		   noi_dung_cau_hoi
	from cau_hoi
    where ma_cau_hoi = (select cau_hoi_hien_tai from nguoi_dung where username = usernameT);
end$

create procedure `GetCauTraLoiByUsername`(usernameT char(32))
begin
	select ma_cau_hoi,
		   ma_cau_tra_loi,
		   noi_dung_tra_loi
	from cau_tra_loi
    where ma_cau_hoi = (select cau_hoi_hien_tai from nguoi_dung where username = usernameT);
end$

create procedure `GetNoiDungSauTraLoiByMaCauTraLoi`(maCauTraLoiT int)
begin
	select noi_dung_sau_tra_loi
    from cau_tra_loi
    where ma_cau_tra_loi = maCauTraLoiT;
end$

DELIMITER ;

select * from lop_hoc;
select * from tai_khoan;
select * from nguoi_dung;
select * from cau_hoi;
select * from loai_tai_khoan;
select * from cau_tra_loi;

insert into lop_hoc(`TEN_LOP`, `MIEU_TA`) values ('L???p t??? h???c', 'L???p t??? h???c l?? l???p h???c nhi???u ch??? ?????, kh??ng chuy??n v??? ch??? ????? n??o');
insert into lop_hoc(`TEN_LOP`, `MIEU_TA`) values ('Cao nguy??n To??n h???c', 'Cao nguy??n to??n h???c l?? n??i l??u tr??? tinh hoa c???a to??n h???c c?? b???n, nh???ng ng?????i th???y gi??o tuy???t v???i ??ang c?? ng??? ??? ????y');
insert into loai_tai_khoan(`ten_loai_tai_khoan`) values ('Ng?????i d??ng');
insert into loai_tai_khoan(`ten_loai_tai_khoan`) values ('Admin');

-- call Get_User_Session_ID('mrhaomp2001'); 

call Register('mrhaomp2001', 'aA442666', 'Hu???nh Nh???t H??o');
call FindTaiKhoanNguoiDungByUsername('mrhaomp2001');
-- C??u 1 L???p 1
INSERT INTO `cau_hoi` (`MA_LOP`, `NOI_DUNG_CAU_HOI`, `CAU_TRA_LOI_DUNG`, `TIEN_CAU_HOI`, `KINH_NGHIEM_CAU_HOI`) 
VALUES ('1', 'B???n ??ang ????i! h??y t??m th??? g?? ???? ??n tr?????c khi ti???p t???c h???c.', '0', '0', '0');
INSERT INTO `cau_tra_loi` (`MA_CAU_HOI`, `NOI_DUNG_TRA_LOI`, `NOI_DUNG_SAU_TRA_LOI`) 
VALUES ('1', 'B???n ??ang ????i!', 'H??y ??i ??n tr?????c!');

-- C??u 2 L???p 1
insert into cau_hoi(`ma_lop`, `noi_dung_cau_hoi`, `cau_tra_loi_dung`, `tien_cau_hoi`, `kinh_nghiem_cau_hoi`) 
values (1, 'M???t con r??a b?? ngang v?? h???i b???n: 14 + 2*8^2 b???ng bao nhi??u, b???n s??? tr??? l???i nh?? th??? n??o?', '142', 10, 1);

insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (2, '142', 'Con r??a khen b???n hay, sau ???? n?? ti???p t???c cu???c ??ua c???a n??');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (2, '143', 'Con r??a ch?? b???n kh??ng th??ng minh, sau ???? n?? ti???p t???c cu???c ??ua c???a n??');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (2, '144', 'Con r??a l?? nh?? con c??, b???n ???? sai');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (2, '145', 'Con r??a di chuy???n v???i t???c ????? si??u thanh do b???n ???? t??nh sai, b???n ???? sai!');

-- c??u 3 L???p 1
insert into cau_hoi(`ma_lop`, `noi_dung_cau_hoi`, `cau_tra_loi_dung`, `tien_cau_hoi`, `kinh_nghiem_cau_hoi`) 
values (1, 'M???t c?? gi??o h??a h???c h???i b???n gi?? tr??? c???a bi???u th???c 8.(a2 + b2) + 100 t???i a = 3, b = 4.', '300', 15, 2);

insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (3, '200', 'Ph??ng c???a c?? gi??o b??? n???, m???t gi??o ??en thui do b???n t??nh sai s??? thu???c c???n th??m v??o. B???n ???? sai!');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (3, '300', 'C?? gi??o cho b???n 1 vi??n k???o :D');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (3, '400', 'C?? gi??o ???? ch???i v?? t??nh to??n sai th??nh ph???n thu???c! B???n ???? sai :D');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (3, '500', '"H???c l???p m???y r???i m???y?" - c?? gi??o said');


-- C??u 4 l???p 2
 insert into cau_hoi(`ma_lop`, `noi_dung_cau_hoi`, `cau_tra_loi_dung`, `tien_cau_hoi`, `kinh_nghiem_cau_hoi`) 
values (2, 'T??m gi?? tr??? c???a x th???a m??n: {23 + [1 + (3 ??? 1)2]} : x = 13', '1', 30, 3);

insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (4, '1', 'B???n ????ng');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (4, '2', 'B???n sai');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (4, '3', 'B???n sai');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (4, '0', 'B???n sai');

call ChangeCauHoiByUsername('mrhaomp2001');
-- select ma_cau_hoi from cau_hoi ORDER BY RAND() limit 1;

select cau_tra_loi_dung from cau_hoi where ma_cau_hoi = (select cau_hoi_hien_tai from nguoi_dung where username = 'mrhaomp2001');
call SelectCauTraLoiByUsername('mrhaomp2001', '142');
call GetCauHoiHienTaiByUsername('mrhaomp2001');
call GetCauTraLoiByUsername('mrhaomp2001');
call GetNoiDungSauTraLoiByMaCauTraLoi(2);