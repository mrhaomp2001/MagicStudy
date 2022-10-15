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

insert into lop_hoc(`TEN_LOP`, `MIEU_TA`) values ('Lớp tự học', 'Lớp tự học là lớp học nhiều chủ đề, không chuyên về chủ đề nào');
insert into lop_hoc(`TEN_LOP`, `MIEU_TA`) values ('Cao nguyên Toán học', 'Cao nguyên toán học là nơi lưu trữ tinh hoa của toán học cơ bản, những người thầy giáo tuyệt vời đang cư ngụ ở đây');
insert into loai_tai_khoan(`ten_loai_tai_khoan`) values ('Người dùng');
insert into loai_tai_khoan(`ten_loai_tai_khoan`) values ('Admin');

-- call Get_User_Session_ID('mrhaomp2001'); 

call Register('mrhaomp2001', 'aA442666', 'Huỳnh Nhựt Hào');
call FindTaiKhoanNguoiDungByUsername('mrhaomp2001');
-- Câu 1 Lớp 1
INSERT INTO `cau_hoi` (`MA_LOP`, `NOI_DUNG_CAU_HOI`, `CAU_TRA_LOI_DUNG`, `TIEN_CAU_HOI`, `KINH_NGHIEM_CAU_HOI`) 
VALUES ('1', 'Bạn đang đói! hãy tìm thứ gì đó ăn trước khi tiếp tục học.', '0', '0', '0');
INSERT INTO `cau_tra_loi` (`MA_CAU_HOI`, `NOI_DUNG_TRA_LOI`, `NOI_DUNG_SAU_TRA_LOI`) 
VALUES ('1', 'Bạn đang đói!', 'Hãy đi ăn trước!');

-- Câu 2 Lớp 1
insert into cau_hoi(`ma_lop`, `noi_dung_cau_hoi`, `cau_tra_loi_dung`, `tien_cau_hoi`, `kinh_nghiem_cau_hoi`) 
values (1, 'Một con rùa bò ngang và hỏi bạn: 14 + 2*8^2 bằng bao nhiêu, bạn sẽ trả lời như thế nào?', '142', 10, 1);

insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (2, '142', 'Con rùa khen bạn hay, sau đó nó tiếp tục cuộc đua của nó');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (2, '143', 'Con rùa chê bạn không thông minh, sau đó nó tiếp tục cuộc đua của nó');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (2, '144', 'Con rùa lú như con cú, bạn đã sai');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (2, '145', 'Con rùa di chuyển với tốc độ siêu thanh do bạn đã tính sai, bạn đã sai!');

-- câu 3 Lớp 1
insert into cau_hoi(`ma_lop`, `noi_dung_cau_hoi`, `cau_tra_loi_dung`, `tien_cau_hoi`, `kinh_nghiem_cau_hoi`) 
values (1, 'Một cô giáo hóa học hỏi bạn giá trị của biểu thức 8.(a2 + b2) + 100 tại a = 3, b = 4.', '300', 15, 2);

insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (3, '200', 'Phòng của cô giáo bị nổ, mặt giáo đen thui do bạn tính sai số thuốc cần thêm vào. Bạn đã sai!');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (3, '300', 'Cô giáo cho bạn 1 viên kẹo :D');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (3, '400', 'Cô giáo đô chời vì tính toán sai thành phần thuốc! Bạn đã sai :D');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (3, '500', '"Học lớp mấy rồi mậy?" - cô giáo said');


-- Câu 4 lớp 2
 insert into cau_hoi(`ma_lop`, `noi_dung_cau_hoi`, `cau_tra_loi_dung`, `tien_cau_hoi`, `kinh_nghiem_cau_hoi`) 
values (2, 'Tìm giá trị của x thỏa mãn: {23 + [1 + (3 – 1)2]} : x = 13', '1', 30, 3);

insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (4, '1', 'Bạn đúng');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (4, '2', 'Bạn sai');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (4, '3', 'Bạn sai');
insert into cau_tra_loi(`ma_cau_hoi`, `noi_dung_tra_loi`, `noi_dung_sau_tra_loi`) 
values (4, '0', 'Bạn sai');

call ChangeCauHoiByUsername('mrhaomp2001');
-- select ma_cau_hoi from cau_hoi ORDER BY RAND() limit 1;

select cau_tra_loi_dung from cau_hoi where ma_cau_hoi = (select cau_hoi_hien_tai from nguoi_dung where username = 'mrhaomp2001');
call SelectCauTraLoiByUsername('mrhaomp2001', '142');
call GetCauHoiHienTaiByUsername('mrhaomp2001');
call GetCauTraLoiByUsername('mrhaomp2001');
call GetNoiDungSauTraLoiByMaCauTraLoi(2);