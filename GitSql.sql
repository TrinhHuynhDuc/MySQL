--git


--CREATE DATABASE SQL_GIT

CREATE TABLE GIANGVIEN
( MAGV CHAR(10) PRIMARY KEY,
HOTEN NCHAR(20),
DIACHI NCHAR(20),
NGAYSINH DATE)

CREATE TABLE DETAI
( MADT CHAR(10) PRIMARY KEY,
TENTD NCHAR(20),
CAP NCHAR(20),
KINHPHI FLOAT)

CREATE TABLE THAMGIA
(MAGV CHAR(10) FOREIGN KEY REFERENCES GIANGVIEN(MAGV),
MADT CHAR(10) FOREIGN KEY REFERENCES DETAI(MADT),
SOGIO INT)


INSERT GIANGVIEN
VALUES
(N'1',N'VŨ TUYẾT TRINH',N'HN','1975/10/10'),
(N'2',N'nGUYỄN NHẬT QUANG',N'TH','1976/3/1'),
(N'3',N'TRẦN ĐỨC KHÁNH',N'NA','1977/2/3'),
(N'4',N'NGUYỄN HÔNG PHƯƠNG',N'TB','1984/2/3'),
(N'5',N'LÊ THANH HƯƠNG',N'PT','1976/4/5')

INSERT DETAI
VALUES
(N'01',N'TOAN',N'NHA NUOC','700'),
(N'02',N'LY',N'BO','300'),
(N'03',N'HOA',N'BO','270'),
(N'04',N'SINH',N'TRUONG','30')

INSERT THAMGIA
VALUES
(N'1',N'01','100'),
(N'1',N'02','80'),
(N'1',N'03','80'),
(N'2',N'01','120'),
(N'2',N'03','140'),
(N'3',N'03','150'),
(N'4',N'04','180')


--1. Đưa ra thông tin giảng viên có địa chỉ ở quận “Hai Bà Trưng”, sắp xếp theo thứ tự giảm 
--dần của họ tên.
SELECT *
FROM GIANGVIEN
WHERE DIACHI LIKE '%'
ORDER BY HOTEN ASC 
--2. Đưa ra danh sách gồm họ tên, địa chỉ, ngày sinh của giảng viên có tham gia vào đề tài 
--“Tính toán lưới”.
SELECT HOTEN,DIACHI,NGAYSINH
FROM GIANGVIEN AS G, DETAI, THAMGIA AS T
WHERE G.MAGV=T.MAGV AND DETAI.MADT=T.MADT AND DETAI.TENTD='TOAN';

--3. Đưa ra danh sách gồm họ tên, địa chỉ, ngày sinh của giảng viên có tham gia vào đề tài 
--“Phân loại văn bản” hoặc “Dịch tự động Anh Việt”.
SELECT HOTEN,DIACHI,NGAYSINH
FROM GIANGVIEN AS G, DETAI, THAMGIA AS T
WHERE G.MAGV=T.MAGV AND DETAI.MADT=T.MADT AND (TENTD='SINH' OR TENTD='LY');
--4. Cho biết thông tin giảng viên tham gia ít nhất 2 đề tài.
SELECT *
FROM GIANGVIEN
WHERE MAGV IN
	(SELECT MAGV
	FROM THAMGIA
	GROUP BY MAGV 
	HAVING COUNT(MAGV) >1);
--5. Cho biết tên giảng viên tham gia nhiều đề tài nhất.
SELECT *
FROM GIANGVIEN
WHERE MAGV IN
	(SELECT TOP (1) MAGV
	FROM THAMGIA
	GROUP BY MAGV 
	HAVING COUNT(MAGV) >1);
--6. Đề tài nào tốn ít kinh phí nhất?
SELECT TOP(1) *
FROM DETAI
ORDER BY KINHPHI ASC
--7. Cho biết tên và ngày sinh của giảng viên sống ở quận Tây Hồ và tên các đề tài mà giảng 
--viên này tham gia.
SELECT HOTEN,DIACHI,NGAYSINH,TENTD
FROM GIANGVIEN AS G, DETAI, THAMGIA AS T
WHERE G.MAGV=T.MAGV AND DETAI.MADT=T.MADT AND DIACHI='TH';

--8. Cho biết tên những giảng viên sinh trước năm 1980 và có tham gia đề tài “Phân loại văn 
--bản”
SELECT HOTEN,DIACHI,NGAYSINH
FROM GIANGVIEN AS G, DETAI, THAMGIA AS T
WHERE G.MAGV=T.MAGV AND DETAI.MADT=T.MADT AND YEAR(NGAYSINH)<1980 AND TENTD='TOAN';
--9. Đưa ra mã giảng viên, tên giảng viên và tổng số giờ tham gia nghiên cứu khoa học của 
--từng giảng viên.
SELECT HOTEN,G.MAGV,NGAYSINH,SOGIO
FROM GIANGVIEN AS G, DETAI, THAMGIA AS T
WHERE G.MAGV=T.MAGV AND DETAI.MADT=T.MADT;
--10. Giảng viên Ngô Tuấn Phong sinh ngày 08/09/1986 địa chỉ Đống Đa, Hà Nội mới tham 
--gia nghiên cứu đề tài khoa học. Hãy thêm thông tin giảng viên này vào bảng GiangVien.
INSERT GIANGVIEN VALUES (N'6',N'NGO TUAN PHONG',N'HN','1986/9/8')
--11. Giảng viên Vũ Tuyết Trinh mới chuyển về sống tại quận Tây Hồ, Hà Nội. Hãy cập nhật 
--thông tin này.
UPDATE GIANGVIEN
SET DIACHI='HCM'
WHERE MAGV='1';
--12. Giảng viên có mã GV02 không tham gia bất kỳ đề tài nào nữa. Hãy xóa tất cả thông tin 
--liên quan đến giảng viên này trong CSDL
DELETE FROM GIANGVIEN
WHERE MAGV='2';