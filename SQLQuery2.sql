
--1.Hiển thị toàn bộ thông tin nhân viên
SELECT * FROM NHANVIEN
GO

--2.Hiển thị họ và tên, lương của toàn bộ nhân viên:
SELECT(NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV) AS N'Họ tên nhân viên', NHANVIEN.LUONG
FROM NHANVIEN
GO

--3.Hiển thị tên đầy đủ và lương của toàn bộ nhân viên của 5 dòng đầu tiên
SELECT TOP 5 CONCAT(HONV ,' ', TENLOT ,' ', TENNV) ho_va_ten,luong salary
FROM NHANVIEN
GO

--4.Hiện thị các mức lương mà công ty phải trả
SELECT DISTINCT NHANVIEN.LUONG  
FROM NHANVIEN
GO

--5.Liệt kê tên nhân viên và phòng nhân viên đó đang làm
SELECT  TENNV, PHG
FROM NHANVIEN
ORDER BY PHG, TENNV DESC
GO

--6.Tìm lương lớn nhất mà công ty phải trả cho nhân viên
SELECT MAX(LUONG) maxluong
FROM NHANVIEN
GO

SELECT TOP 1 LUONG
FROM NHANVIEN
ORDER BY LUONG DESC
GO

--7.Đếm xem có bao nhiêu nhân viên
SELECT COUNT(MANV) TOTAL
FROM NHANVIEN
GO

--8.Tính tổng lương công ty phải trả cho nhân viên
SELECT SUM(LUONG) AS TOTALMONEY
FROM NHANVIEN
GO

--9.Liệt kê toàn bộ thông tin nhân viên với điều kiện họ phải là ĐINH.
SELECT *
FROM NHANVIEN
WHERE HONV COLLATE SQL_Latin1_General_CP1_CI_AI = 
     N'ĐINH' COLLATE SQL_Latin1_General_CP1_CI_AI 
GO

--10.Tính tổng lương từng phòng công ty phải trả cho nhân viên
SELECT PHG,SUM(LUONG) AS TOTALMONEY
FROM NHANVIEN
GROUP BY PHG 
GO

SELECT PHG, PHAI, SUM(LUONG) AS TOTALMONEY
FROM NHANVIEN
GROUP BY PHG,PHAI
GO

-- 11.Tính tổng nhân viên có mặt tại từng phòng
SELECT PHG,COUNT(MANV) AS TOTALNV
FROM NHANVIEN
GROUP BY PHG
GO

-- 12.Tính tổng nhân viên có mặt tại từng phòng, lấy những phòng nhân viên lớn hơn 2
SELECT PHG,COUNT(MANV)AS TOTALNV
FROM NHANVIEN
GROUP BY PHG
HAVING COUNT(MANV) > 2
GO

--13.Tính xem mỗi phải có bao nhiêu nhân viên
SELECT PHAI,COUNT(MANV) AS TOTAL
FROM NHANVIEN
GROUP BY PHAI
GO

--14.Đếm xem mỗi phái có bao nhiêu nhân viên, chỉ lấy những phái có số lượng lớn hơn 5
SELECT PHAI,COUNT(MANV) TOTALPEOPLE
FROM NHANVIEN
GROUP BY PHAI
HAVING COUNT(MANV) > 5
GO

--15.Hiển thị tên nhân viên và phái của nhân viên đó
--case..when..then
SELECT TENNV,
		CASE PHAI WHEN N'NAM' THEN 'MALE'
		          WHEN N'NỮ' THEN 'FEMALE'
	   END GENDER
FROM NHANVIEN
GO

SELECT TENNV,
		CASE PHAI WHEN N'NAM' THEN 'MALE'
		          ELSE'FEMALE'
	    END GENDER
FROM NHANVIEN
GO

--case when..then
SELECT TENNV,
		CASE WHEN PHAI = N'NAM' THEN 'MALE'
		     WHEN PHAI = N'NỮ' THEN 'FEMALE'
	   END GENDER
FROM NHANVIEN
GO

--16.Liệt kê toàn bộ thông tin nhân viên vs người quản lý là null
SELECT *
FROM NHANVIEN
WHERE MA_NQL is null
GO

--17.Liệt kê toàn bộ nhân viên ngoại trừ sếp
SELECT *
FROM NHANVIEN
WHERE MA_NQL is NOT NULL
GO

--18.Liệt kê toàn bộ thông tin nhân viên với năm sinh phải là 1967
SELECT *
FROM NHANVIEN
WHERE DATEPART(YEAR,NGAYSINH) = 1967
GO

--19.Liệt kê toàn bộ thông tin nhân viên với tên nhân viên phải có từ H đầu tiên
SELECT *
FROM NHANVIEN
WHERE TENNV LIKE N'H%' 
GO

--20.Liệt kê toàn bộ thông tin nhân viên với tên nhân viên phải có từ G cuối cùng
SELECT *
FROM NHANVIEN
WHERE TENNV LIKE N'%G' 
GO

--21.Liệt kê toàn bộ thông tin nhân viên với tên nhân viên phải có từ u trong tên
SELECT *
FROM NHANVIEN
WHERE TENNV COLLATE SQL_Latin1_General_CP1_CI_AI  LIKE
     N'%U%' COLLATE SQL_Latin1_General_CP1_CI_AI 
GO

--22.Liệt kê toàn bộ thông tin nhân viên sinh trong 1962-1965
SELECT *
FROM NHANVIEN
WHERE YEAR(NGAYSINH) >=1962 AND
      YEAR(NGAYSINH) <=1965
GO

SELECT *
FROM NHANVIEN
WHERE YEAR(NGAYSINH) BETWEEN 1962 AND 1965
GO

--23.Hiển thị tên và năm sinh của nhân viên với ngày sinh phải là dd-MM-yyyy
SELECT TENNV, CONVERT(VARCHAR,NGAYSINH,105) NGAYSINH
FROM NHANVIEN
GO

--24.Liệt kê tên phòng ban và nhân viên làm việc ở phòng ban
SELECT TENPHG, TENNV
FROM PHONGBAN INNER JOIN NHANVIEN
    ON PHONGBAN.MAPHG = NHANVIEN.PHG
ORDER BY TENPHG
GO

--25.Liệt kê tên nhân viên và thời gian nhân viên tham gia đồ án
SELECT TENNV, THOIGIAN
FROM NHANVIEN INNER JOIN PHANCONG
    ON NHANVIEN.MANV = PHANCONG.MA_NVIEN
GO

--26.Liệt kê tên công việc và tên công việc của từng phòng
SELECT *
FROM DEAN
		INNER JOIN PHONGBAN ON DEAN.PHONG = PHONGBAN.MAPHG
		INNER JOIN CONGVIEC ON DEAN.MADA = CONGVIEC.MADA
ORDER BY TENPHG
GO

--27.Liệt kê địa điểm phòng và tên công việc tại các địa điểm đó xếp hạng dữ liệu có thêm phòng ban
SELECT PHG, MANV, TENNV, LUONG
FROM NHANVIEN
ORDER BY PHG
GO

SELECT ROW_NUMBER() OVER( ORDER BY LUONG) [TOP], 
	MANV, TENNV, LUONG, PHG
FROM NHANVIEN
GO
SELECT ROW_NUMBER() OVER( ORDER BY LUONG DESC) [TOP], 
	MANV, TENNV, LUONG, PHG
FROM NHANVIEN
GO

SELECT ROW_NUMBER() OVER( PARTITION BY PHG ORDER BY LUONG DESC) [TOP], MANV, TENNV, LUONG, PHG
FROM NHANVIEN
GO

SELECT RANK() OVER( PARTITION BY PHG ORDER BY LUONG DESC) [TOP], MANV, TENNV, LUONG, PHG
FROM NHANVIEN
GO

SELECT DENSE_RANK() OVER( PARTITION BY PHG ORDER BY LUONG DESC) [TOP], MANV, TENNV, LUONG, PHG
FROM NHANVIEN
GO

--28.Cho biết tên các nhân viên ở phòng số 5.
SELECT NHANVIEN.HONV +' '+ NHANVIEN.TENLOT+' ' + NHANVIEN.TENNV AS N'Nhân viên phòng 5'
FROM NHANVIEN
WHERE NHANVIEN.PHG = 5
GO

--29.Cho biết tên phòng mà nhân viên trực thuộc.
SELECT DISTINCT PHONGBAN.TENPHG AS N'Tên phòng'
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.PHG = PHONGBAN.MAPHG
GO

--30.Cho biết tên của trưởng phòng phòng nghiên cứu.
SELECT NHANVIEN.HONV+' ' + NHANVIEN.TENLOT+' ' + NHANVIEN.TENNV AS N'Trưởng phòng nghiên cứu'
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.MANV = PHONGBAN.TRPHG AND
	  PHONGBAN.TENPHG = N'Nghiên cứu' 
GO

--31.Cho biết mức lương trung bình của từng phòng ban.
SELECT PHONGBAN.MAPHG, PHONGBAN.TENPHG, AVG(NHANVIEN.LUONG) AS LTB
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.MANV = PHONGBAN.TRPHG
GROUP BY  PHONGBAN.MAPHG, PHONGBAN.TENPHG
 GO

--32.Cho biết tên các phòng có mức lương trung bình cao nhất.
SELECT LUONG_TB_PHONG.MAPHG, LUONG_TB_PHONG.TENPHG, LTB
FROM
	(SELECT PHONGBAN.MAPHG, PHONGBAN.TENPHG, AVG(NHANVIEN.LUONG) AS LTB
	 FROM NHANVIEN, PHONGBAN
	 WHERE NHANVIEN.PHG = PHONGBAN.MAPHG
	 GROUP BY PHONGBAN.MAPHG, PHONGBAN.TENPHG
	 ) AS LUONG_TB_PHONG
WHERE LUONG_TB_PHONG.LTB >= ALL (SELECT MAX(LUONG_TB_PHONG.LTB)
								 FROM (SELECT PHONGBAN.MAPHG, PHONGBAN.TENPHG, AVG(NHANVIEN.LUONG) AS LTB
								       FROM NHANVIEN, PHONGBAN
										WHERE NHANVIEN.PHG = PHONGBAN.MAPHG
										GROUP BY PHONGBAN.MAPHG, PHONGBAN.TENPHG
											 ) AS LUONG_TB_PHONG
										)
GO

--33.Cho biết tên các nhân viên không tham gia đề án nào.
SELECT (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV)
FROM NHANVIEN
WHERE NHANVIEN.PHG NOT IN (SELECT DEAN.PHONG FROM DEAN)
GO

--34.Cho biết tên các nhân viên tham gia tất cả các đề án.
SELECT NHANVIEN.MANV
FROM NHANVIEN,DEAN
WHERE NHANVIEN.PHG =  DEAN.PHONG 
GROUP BY NHANVIEN.MANV
HAVING COUNT(NHANVIEN.MANV) >=(SELECT COUNT(DEAN.PHONG)
									FROM DEAN)
GO

--35.Tìm các nhân viên làm việc ở phòng số 4.
SELECT *
FROM NHANVIEN
WHERE NHANVIEN.PHG = 4
GO

--36.Tìm các nhân viên có mức lương trên 30000.
SELECT *
FROM NHANVIEN
WHERE NHANVIEN.LUONG >30000
GO

--37.Tìm các nhân viên có mức lương trên 25,000 ở phòng 4 hoặc các nhân viên có mức lương trên 30,000 ở phòng 5.
SELECT *
FROM NHANVIEN
WHERE (NHANVIEN.LUONG >25000 AND NHANVIEN.PHG = 4)OR(NHANVIEN.LUONG >30000 AND NHANVIEN.PHG = 5)
GO

--38. Cho biết họ tên đầy đủ của các nhân viên ở TP HCM.
SELECT NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV AS tennhanvien
FROM NHANVIEN
WHERE NHANVIEN.DCHI LIKE '%HCM'
GO

--39.Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự 'N'.
SELECT NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV AS tennhanvien
FROM NHANVIEN
WHERE NHANVIEN.HONV LIKE N'N%'
GO

--40.Cho biết ngày sinh và địa chỉ của nhân viên Đinh Bá Tiến.
SELECT  NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV AS N'Tên Nhân Viên',NHANVIEN.NGAYSINH,NHANVIEN.DCHI
FROM NHANVIEN
WHERE NHANVIEN.TENNV = N'Tiến'
GO

--41.Cho biết các nhân viên có năm sinh trong khoảng 1960 đến 1965.
SELECT *
FROM NHANVIEN
WHERE YEAR(NGAYSINH) >=1960 AND
		  YEAR(NGAYSINH) <=1965
GO

--42.Cho biết các nhân viên và năm sinh của nhân viên.
SELECT NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV AS tennhanvien, YEAR(NGAYSINH) AS N'Năm Sinh'
FROM NHANVIEN
GO

--43.Cho biết các nhân viên và tuổi của nhân viên.
SELECT NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV AS tennhanvien, (YEAR(GETDATE()) - YEAR(NHANVIEN.NGAYSINH)) AS N'Tuổi'
FROM NHANVIEN
GO

--44.Với mỗi phòng ban, cho biết tên phòng ban và địa điểm phòng.
SELECT PHONGBAN.TENPHG,  DIADIEM_PHG.DIADIEM
FROM   PHONGBAN,DIADIEM_PHG
WHERE PHONGBAN.MAPHG = DIADIEM_PHG.MAPHG
GROUP BY PHONGBAN.TENPHG, DIADIEM_PHG.DIADIEM
GO

--45.Tìm tên những người trưởng phòng của từng phòng ban.
SELECT  (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV) AS N'Tên Trưởng Phòng',TENPHG
FROM NHANVIEN, PHONGBAN
WHERE PHONGBAN.TRPHG = NHANVIEN.MANV
GO

--46. Tìm tên và địa chỉ của tất cả các nhân viên của phòng "Nghiên cứu".
SELECT  (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV) AS N'Nhân Viên Phòng Nghiên Cứu', NHANVIEN.DCHI AS N'Địa Chỉ'
FROM NHANVIEN
WHERE NHANVIEN.PHG = 5
GO

--46. Với mỗi đề án ở Hà Nội, cho biết tên đề án, tên phòng ban, họ tên và ngày nhận chức của trưởng phòng của phòng ban chủ trì đề án đó.
SELECT  NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV AS N'Nhân Viên', PHONGBAN.NG_NHANCHUC AS N'Ngày Nhận Chức', 
			PHONGBAN.TENPHG AS N'Tên Phòng Ban'
FROM NHANVIEN, PHONGBAN ,DEAN
WHERE DEAN.DDIEM_DA = N'HÀ NỘI' AND
	  DEAN.PHONG = PHONGBAN.MAPHG AND
	  PHONGBAN.TRPHG = NHANVIEN.MANV
GO

--47.Tìm tên những nữ nhân viên và tên người thân của họ.
SELECT  (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV) AS N'Nhân Viên', NHANVIEN.PHAI AS N'Giới Tính',
	    THANNHAN.TENTN AS N'Tên Người Thân'
FROM   NHANVIEN, THANNHAN
WHERE THANNHAN.MA_NVIEN = NHANVIEN.MANV AND
		  NHANVIEN.PHAI = N'Nữ'
GO

--48. Với mỗi nhân viên, cho biết họ tên nhân viên và họ tên người quản lý trực tiếp của nhân viên đó.
SELECT (NV.HONV+' '+ NV.TENLOT+' '+ NV.TENNV) AS N'Nhân Viên',
       (QL.HONV+' '+ QL.TENLOT+' '+ QL.TENNV) AS N'Ng Quản Lý'
FROM NHANVIEN AS NV,  NHANVIEN AS QL
WHERE QL.MANV = NV.MA_NQL
GO

--49.Với mỗi nhân viên, cho biết họ tên của nhân viên đó, họ tên người trưởng phòng và họ tên người quản lý trực tiếp của nhân viên đó.
SELECT (NV.HONV+' '+ NV.TENLOT+' '+ NV.TENNV) AS N'Tên Nhân Viên',
       (QL.HONV+' '+ QL.TENLOT+' '+ QL.TENNV) AS N'Tên Người Quản Lý',
	   (TP.HONV+' '+ TP.TENLOT+' '+ TP.TENNV) AS N'Tên Người Trưởng Phòng'
FROM NHANVIEN AS NV,  NHANVIEN AS QL, NHANVIEN AS TP, PHONGBAN
WHERE QL.MANV = NV.MA_NQL AND TP.MANV = PHONGBAN.TRPHG AND
      NV.PHG = PHONGBAN.MAPHG
GO

--50.Tên những nhân viên phòng số 5 có tham gia vào đề án "Sản phẩm X" và nhân viên này do "Nguyễn Thanh Tùng" quản lý trực tiếp.
SELECT (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV) AS 'Ten Nhan Vien tham gia de an San Pham X'
FROM   NHANVIEN, DEAN
WHERE  DEAN.TENDA = N'Sản phẩm X' AND 
       DEAN.PHONG = 5 AND 
	   NHANVIEN.MA_NQL = (SELECT NHANVIEN.MANV
							 FROM NHANVIEN
							 WHERE NHANVIEN.HONV = N'Nguyễn'AND
								   NHANVIEN.TENLOT = N'Thanh' AND
								   NHANVIEN.TENNV = N'Tùng'
							)
GO

--51.Cho biết tên các đề án mà nhân viên Đinh Bá Tiến đã tham gia.
SELECT DEAN.TENDA
FROM NHANVIEN, DEAN
WHERE NHANVIEN.HONV = N'Đinh' AND
	  NHANVIEN.TENLOT = N'Bá' AND
	  NHANVIEN.TENNV = N'Tiến'AND
	  NHANVIEN.PHG = DEAN.PHONG
GO

--52.Cho biết số lượng đề án của công ty.
SELECT COUNT(DEAN.TENDA) AS N'Số lượng đề án của công ty'
FROM DEAN
GO

--53.Cho biết số lượng đề án do phòng 'Nghiên Cứu' chủ trì.
SELECT COUNT(DEAN.TENDA) AS N'Số lượng đề án của công ty'
FROM DEAN,PHONGBAN
WHERE PHONGBAN.TENPHG = N'Nghiên Cứu' AND
	   PHONGBAN.MAPHG = DEAN.PHONG
GO

--54.Cho biết lương trung bình của các nữ nhân viên.
SELECT AVG(NHANVIEN.LUONG) AS N'Lương trung bình của các nữ nhân viên'
FROM NHANVIEN
WHERE NHANVIEN.PHAI = N'Nữ'
GO

--55.Cho biết số thân nhân của nhân viên 'Đinh Bá Tiến'.
SELECT COUNT(THANNHAN.MA_NVIEN) AS N'Số thân nhân của nhân viên Đinh Bá Tiến'
FROM NHANVIEN,THANNHAN
WHERE THANNHAN.MA_NVIEN = NHANVIEN.MANV AND 
	  NHANVIEN.TENNV = N'Tiến'
GO

--56.Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc [một tuần] của tất cả các nhân viên tham dự đề án đó.
SELECT DEAN.TENDA, DEAN.MADA, SUM(PHANCONG.THOIGIAN)AS N'Tổng số giờ làm việc [một tuần]'
FROM PHANCONG,DEAN
WHERE PHANCONG.MADA = DEAN.MADA
GROUP BY DEAN.TENDA, DEAN.MADA
GO
--57.Với mỗi đề án, cho biết có bao nhiêu nhân viên tham gia đề án đó.
SELECT DEAN.TENDA AS N'Tên Đề Án', DEAN.MADA AS N'Mã Đề Án', COUNT(PHANCONG.MA_NVIEN) AS N'Số nhân viên tham gia đề án'
FROM PHANCONG,DEAN
WHERE DEAN.MADA = PHANCONG.MADA
GROUP BY DEAN.TENDA, DEAN.MADA
GO

--58.Với mỗi nhân viên, cho biết họ và tên nhân viên và số lượng thân nhân của nhân viên đó.
SELECT (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV) AS N'Tên nhân viên',
		COUNT (THANNHAN.MA_NVIEN) AS N'Số Lượng Thân Nhân'
FROM THANNHAN, NHANVIEN
WHERE THANNHAN.MA_NVIEN = NHANVIEN.MANV 
GROUP BY (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV)
GO

--59.Với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đề án mà nhân viên đó đã tham gia.
SELECT (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV) AS N'Tên nhân viên',
	      COUNT(PHANCONG.MADA) AS N'Số lượng đề án mà nhân viên đó đã tham gia'
FROM NHANVIEN, PHANCONG
WHERE PHANCONG.MA_NVIEN = NHANVIEN.MANV
GROUP BY (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV)
GO

--60.Với mỗi nhân viên, cho biết số lượng nhân viên mà nhân viên đó quản lý trực tiếp.
SELECT (NV.HONV+' '+ NV.TENLOT+' '+ NV.TENNV) AS N'Tên Quản Lý',
         COUNT(QL.MANV) AS N'Số lượng nhân viên'
FROM  NHANVIEN AS QL, NHANVIEN AS NV
WHERE QL.MA_NQL= NV.MANV
GROUP BY (NV.HONV+' '+ NV.TENLOT+' '+ NV.TENNV)
GO

--61.Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó.
SELECT PHONGBAN.TENPHG,AVG (NHANVIEN.LUONG)AS N'Lương trung bình của những nhân viên làm việc cho phòng ban'
FROM NHANVIEN,PHONGBAN
WHERE PHONGBAN.MAPHG = NHANVIEN.PHG
GROUP BY PHONGBAN.TENPHG
GO

--62.Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.
SELECT PHONGBAN.TENPHG, COUNT (NHANVIEN.MANV) AS N'Số lượng nhân viên ', AVG (NHANVIEN.LUONG)AS N'Lương trung bình của phòng ban'
FROM NHANVIEN, PHONGBAN
WHERE  PHONGBAN.MAPHG = NHANVIEN.PHG
GROUP BY PHONGBAN.TENPHG
HAVING AVG (NHANVIEN.LUONG) > 30000 
GO

--63.Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì.
SELECT  PHONGBAN.TENPHG, COUNT(DEAN.MADA) AS N'Số lượng đề án mà phòng ban đó chủ trì'
FROM    DEAN, PHONGBAN
WHERE   DEAN.PHONG = PHONGBAN.MAPHG
GROUP BY PHONGBAN.TENPHG
GO

--64.Với mỗi phòng ban, cho biết tên phòng ban, họ tên người trưởng phòng và số lượng đề án mà phòng ban đó chủ trì.
SELECT (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV) AS N'Họ tên người trưởng phòng', PHONGBAN.TENPHG, 
       COUNT(DEAN.PHONG) AS N'Số lượng đề án mà phòng ban đó chủ trì'
FROM  DEAN, PHONGBAN, NHANVIEN 
WHERE DEAN.PHONG = PHONGBAN.MAPHG AND
	   PHONGBAN.TRPHG = NHANVIEN.MANV
GROUP BY PHONGBAN.TENPHG,(NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV)
GO

--65.Với mỗi phòng ban có mức lương trung bình lớn hơn 40,000, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì.
SELECT PHONGBAN.TENPHG, COUNT(DEAN.PHONG) AS N'Số lượng đề án mà phòng ban đó chủ trì', AVG (NHANVIEN.LUONG)AS N'Lương trung bình của phòng ban'
FROM NHANVIEN, PHONGBAN,DEAN
WHERE DEAN.PHONG = PHONGBAN.MAPHG AND
	   PHONGBAN.TRPHG = NHANVIEN.MANV
GROUP BY PHONGBAN.TENPHG
HAVING AVG (NHANVIEN.LUONG) > 40000 
GO

--66.Cho biết số đề án diễn ra tại từng địa điểm.
 SELECT DEAN.DDIEM_DA, COUNT(DEAN.DDIEM_DA) AS 'So Luong De An'
 FROM DEAN
 GROUP BY DEAN.DDIEM_DA
 GO

--67.Với mỗi đề án, cho biết tên đề án và số lượng công việc của đề án này.
 SELECT DEAN.MADA, DEAN.TENDA, COUNT(CONGVIEC.TEN_CONG_VIEC) AS N'Số lượng công việc của đề án này'
 FROM DEAN, CONGVIEC
 WHERE DEAN.MADA = CONGVIEC.MADA 
 GROUP BY DEAN.MADA, DEAN.TENDA
 GO

--68.Với mỗi công việc trong đề án có mã đề án là 30, cho biết số lượng nhân viên được phân công.
 SELECT CONGVIEC.TEN_CONG_VIEC, COUNT(NHANVIEN.PHG) AS N'Số lượng nhân viên được phân công'
 FROM NHANVIEN, DEAN, CONGVIEC
 WHERE DEAN.MADA = 30 AND
       DEAN.PHONG = NHANVIEN.PHG AND
	   DEAN.MADA = CONGVIEC.MADA
 GROUP BY CONGVIEC.TEN_CONG_VIEC
 GO

 --69.Với mỗi công việc trong đề án có mã đề án là 'Đào Tạo', cho biết số lượng nhân viên được phân công.
 SELECT CONGVIEC.TEN_CONG_VIEC, COUNT(NHANVIEN.PHG) AS N'Số lượng nhân viên được phân công'
 FROM NHANVIEN, DEAN, CONGVIEC
 WHERE DEAN.TENDA = N'DAO TAO' AND 
       DEAN.PHONG = NHANVIEN.PHG AND
	   DEAN.MADA = CONGVIEC.MADA
 GROUP BY CONGVIEC.TEN_CONG_VIEC
 GO

 --70.Cho biết danh sách các đề  án (MADA) có: nhân công với họ  (HONV) là 'Đinh'  hoặc  có  người  trưởng  phòng  chủ  trì  đề  án  với  họ  (HONV)  là 'Đinh'.
 SELECT DEAN.MADA,COUNT(DEAN.MADA)
 FROM DEAN,NHANVIEN, PHONGBAN
 WHERE NHANVIEN.HONV = N'Đinh' OR
 (NHANVIEN.HONV = N'Đinh' AND  NHANVIEN.MANV = PHONGBAN.TRPHG)
 GROUP BY DEAN.MADA
 GO

 --71.Danh  sách  những  nhân  viên  (HONV,  TENLOT,  TENNV)  có  trên  2  thân nhân.
 SELECT (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV) AS N'Họ tên nhân viên', COUNT(THANNHAN.MA_NVIEN) AS N'Số lượng thân nhân'
 FROM NHANVIEN,THANNHAN
 WHERE THANNHAN.MA_NVIEN = NHANVIEN.MANV
 GROUP BY (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV)
 HAVING COUNT(THANNHAN.MA_NVIEN) > 2
 GO

--72.Danh  sách  những  nhân  viên  (HONV,  TENLOT,  TENNV)  không  có  thân nhân nào.
 SELECT (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV) AS N'Họ tên nhân viên không có thân nhân'
 FROM NHANVIEN,THANNHAN
 WHERE THANNHAN.MA_NVIEN = NHANVIEN.MANV
 GROUP BY (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV)
 HAVING COUNT(THANNHAN.MA_NVIEN) = 0
 GO

--73. Danh  sách  những  trưởng  phòng  (HONV,  TENLOT,  TENNV)  có  tối  thiểu một thân nhân.
 SELECT (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV) AS N'Họ tên nhân viên có tối thiểu 1 thân nhân', COUNT (THANNHAN.MA_NVIEN) AS N'Số Lượng'
 FROM NHANVIEN, THANNHAN, PHONGBAN
 WHERE NHANVIEN.MANV = THANNHAN.MA_NVIEN AND
       PHONGBAN.TRPHG = NHANVIEN.MANV
 GROUP BY (NHANVIEN.HONV+' '+ NHANVIEN.TENLOT+' '+ NHANVIEN.TENNV) 
 HAVING COUNT (THANNHAN.MA_NVIEN)>0 AND COUNT(THANNHAN.MA_NVIEN) >= 1
 GO
