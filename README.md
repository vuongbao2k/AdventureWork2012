# Data-Warehouse-ETL-BI

•	Database nguồn : AdventureWork2012
 https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms
## Yêu cầu chi tiết Project
### I.	Thiết kế Data warehouse và  ETL cho các báo cáo sau:
1.	Báo cáo doanh số theo từng nhân viên
2.	Báo cáo doanh số theo từng khu vực
3.	Báo cáo số đơn hàng theo nhân viên
4.	Báo cáo số đơn theo khu vực
5.	Báo cáo số lượng bán ra theo nhóm sản phẩm 
6.	Báo cáo số lượng bán ra theo sản phẩm và khu vực
### II.	Tạo Dashboard bằng Power BI
## Thực hiện
### I.	Thiết kế Data warehouse và  ETL
#### 1. Thiết kế Data warehouse
**Lựa chọn lược đồ**

Snowflake schema

**Xây dựng các bảng Dimension**

- Báo cáo doanh số theo từng nhân viên => **Nhân viên** 
- Báo cáo doanh số theo từng khu vực => **Khu vực**
- Báo cáo số đơn hàng theo nhân viên => **Nhân viên**
- Báo cáo số đơn theo khu vực => **Khu vực**
- Báo cáo số lượng bán ra theo nhóm sản phẩm  => **Nhóm sản phẩm**
- Báo cáo số lượng bán ra theo sản phẩm và khu vực => **Sản phẩm, Khu vực**

Các dimension cần tạo : **Nhân viên, Khu vực, Sản phẩm,  Nhóm sản phẩm, Thời gian**

**Xây dựng các bảng Fact**


#### 2. ETL
### II.	Tạo Dashboard bằng Power BI

