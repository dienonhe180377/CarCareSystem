-- 1. Tạo database nếu chưa tồn tại
IF DB_ID('CarCareSystem') IS NULL
BEGIN
    CREATE DATABASE CarCareSystem;
END;
GO

USE CarCareSystem;
GO

-- 2. Bảng User
CREATE TABLE [User] (
    id           INT           IDENTITY(1,1) PRIMARY KEY,
    username     NVARCHAR(50)  NOT NULL,
    password     NVARCHAR(255) NOT NULL,
    email        NVARCHAR(100) NOT NULL,
    phone        NVARCHAR(20)  NULL,
    address      NVARCHAR(255) NULL,
    createDate   DATETIME      NOT NULL DEFAULT GETDATE(),
    role         NVARCHAR(50)  NOT NULL
);
GO

-- 3. Bảng CarType
CREATE TABLE CarType (
    id     INT           IDENTITY(1,1) PRIMARY KEY,
    name   NVARCHAR(100) NOT NULL,
    status BIT           NOT NULL DEFAULT 1,
    description NVARCHAR(255) NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NULL
);
GO

-- 4. Bảng Category
CREATE TABLE Category (
    id     INT           IDENTITY(1,1) PRIMARY KEY,
    name   NVARCHAR(100) NOT NULL UNIQUE,
    status BIT           NOT NULL DEFAULT 1,
    description nvarchar(255)
);
GO

-- 5. Bảng Supplier
CREATE TABLE Supplier (
    id          INT           IDENTITY(1,1) PRIMARY KEY,
    [name]      NVARCHAR(150) NOT NULL,
    logo NVARCHAR(255),
    [description] NVARCHAR(255),
    email NVARCHAR(150) not null UNIQUE,
    phone NVARCHAR(20) not null,
    [address] NVARCHAR(255)
);
GO

-- 6. Bảng Service (tạo trước, FK partId sẽ thêm sau)
CREATE TABLE Service (
    id           INT           IDENTITY(1,1) PRIMARY KEY,
    name         NVARCHAR(150) NOT NULL,
    description NVARCHAR(500) NULL,
    price        FLOAT NOT NULL,
    img NVARCHAR(255) NOT NULL DEFAULT N'default.jpg'
);  
GO

-- 7. Bảng Attendance
CREATE TABLE Attendance (
    id       INT      IDENTITY(1,1) PRIMARY KEY,
    userId   INT      NOT NULL,
    date     DATE     NOT NULL,
    status   NVARCHAR(50) NOT NULL,

    CONSTRAINT FK_Attendance_User FOREIGN KEY(userId) REFERENCES [User](id)
);
GO

-- 8. Bảng InsuranceType
CREATE TABLE InsuranceType (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(500) NULL,
    price FLOAT NOT NULL
);
GO

-- 9. Bảng Insurance
CREATE TABLE Insurance (
    id               INT      IDENTITY(1,1) PRIMARY KEY,
    userId           INT      NOT NULL,
    carTypeId        INT      NOT NULL,
    startDate        DATE     NOT NULL,
    endDate          DATE     NOT NULL,
    insuranceTypeId INT NOT NULL,

    CONSTRAINT FK_Insurance_User     FOREIGN KEY(userId)     REFERENCES [User](id),
    CONSTRAINT FK_Insurance_CarType FOREIGN KEY(carTypeId) REFERENCES CarType(id),
    CONSTRAINT FK_Insurance_InsuranceType FOREIGN KEY (insuranceTypeId) REFERENCES InsuranceType(id)
);
GO

-- 10. Bảng [Order]
CREATE TABLE [Order] (
    id                 INT      IDENTITY(1,1) PRIMARY KEY,
    userId             INT      NULL,
    carTypeId          INT      NOT NULL,
    createDate         DATETIME NOT NULL DEFAULT GETDATE(),
    appointmentDate DATETIME      NOT NULL,
    price              FLOAT           NOT NULL,
    [name] NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20) NOT NULL,
    [address] NVARCHAR(255) NOT NULL,
    paymentStatus NVARCHAR(50) NOT NULL,
    orderStatus NVARCHAR(50) NOT NULL,
    paymentMethod NVARCHAR(50) NOT NULL,

    CONSTRAINT FK_Order_CarType FOREIGN KEY(carTypeId) REFERENCES CarType(id),
    CONSTRAINT FK_Order_User FOREIGN KEY(userId) REFERENCES [User](id)
);
GO

-- 11. Bảng Feedback
CREATE TABLE Feedback (
    id           INT      IDENTITY(1,1) PRIMARY KEY,
    userId       INT      NOT NULL,
    description NVARCHAR(1000) NOT NULL,
    createDate   DATETIME NOT NULL DEFAULT GETDATE(),
    serviceId INT NOT NULL,
    rating INT NOT NULL,

    CONSTRAINT FK_Feedback_User FOREIGN KEY(userId) REFERENCES [User](id),
    CONSTRAINT FK_Feedback_Service FOREIGN KEY(serviceId) REFERENCES Service(id)
);
GO

-- 12. Bảng Parts
CREATE TABLE Parts (
    id         INT           IDENTITY(1,1) PRIMARY KEY,
    name       NVARCHAR(150) NOT NULL UNIQUE,
    image      NVARCHAR(150),
    categoryId INT           NOT NULL,
    price      FLOAT NOT NULL,

    CONSTRAINT FK_Parts_Category FOREIGN KEY(categoryId) REFERENCES Category(id)
);
GO

-- 13. Bảng Size
CREATE TABLE Size (
    id       INT      IDENTITY(1,1) PRIMARY KEY,
    name     NVARCHAR(50) NOT NULL,
    partId   INT      NOT NULL,
    status   BIT      NOT NULL DEFAULT 1,
    quantity INT      NOT NULL,

    CONSTRAINT FK_Size_Parts FOREIGN KEY(partId) REFERENCES Parts(id)
);
GO

-- 14. Bảng Campaign (CẬP NHẬT MỚI)
CREATE TABLE [dbo].[Campaign] (
    [id] [int] IDENTITY(1,1) NOT NULL,
    [name] [nvarchar](255) NULL,
    [status] [bit] NOT NULL DEFAULT 1,
    [description] [nvarchar](max) NULL,
    [startDate] [date] NOT NULL,
    [endDate] [date] NOT NULL,
    [img] [nvarchar](500) NULL,
    [thumbnail] [nvarchar](500) NULL,
    [createdDate] [datetime] NULL DEFAULT GETDATE(),
    
    PRIMARY KEY CLUSTERED ([id] ASC)
);
GO

-- 15. Bảng Blog
CREATE TABLE Blog (
    id           INT           IDENTITY(1,1) PRIMARY KEY,
    title        NVARCHAR(200) NOT NULL,
    campaignId   INT           NULL,
    content      NVARCHAR(MAX) NOT NULL,
    createDate   DATETIME NOT NULL DEFAULT GETDATE(),
    updatedDate DATETIME NULL,
    status       BIT      NOT NULL DEFAULT 1,

    CONSTRAINT FK_Blog_Campaign FOREIGN KEY(campaignId) REFERENCES Campaign(id)
);
GO

-- 16. Bảng Voucher (CẬP NHẬT MỚI)
CREATE TABLE [dbo].[Voucher](
    [id] [int] IDENTITY(1,1) NOT NULL,
    [name] [nvarchar](255) NULL,
    [description] [nvarchar](max) NULL,
    [discount] [float] NOT NULL,
    [discountType] [nvarchar](20) NOT NULL DEFAULT 'PERCENTAGE',
    [maxDiscountAmount] [float] NULL,
    [minOrderAmount] [float] NULL,
    [startDate] [datetime] NOT NULL,
    [endDate] [datetime] NOT NULL,
    [serviceId] [int] NULL,
    [campaignId] [int] NULL,
    [status] [nvarchar](20) NOT NULL DEFAULT 'ACTIVE',
    [createdDate] [datetime] NOT NULL DEFAULT (getdate()),
    [voucherCode] [nvarchar](50) NOT NULL,
    [totalVoucherCount] [int] NOT NULL DEFAULT 0,
    
    PRIMARY KEY CLUSTERED ([id] ASC),
    UNIQUE NONCLUSTERED ([voucherCode] ASC),
    
    CONSTRAINT [CK_Voucher_DiscountType] CHECK ([discountType] IN ('PERCENTAGE', 'FIXED_AMOUNT')),
    CONSTRAINT [CK_Voucher_Status] CHECK ([status] IN ('ACTIVE', 'INACTIVE', 'EXPIRED')),
    CONSTRAINT FK_Voucher_Campaign FOREIGN KEY(campaignId) REFERENCES Campaign(id),
    CONSTRAINT FK_Voucher_Service  FOREIGN KEY(serviceId)  REFERENCES Service(id)
) ON [PRIMARY]
GO

-- 17. Bảng UserVoucher (CẤU TRÚC MỚI)
CREATE TABLE [dbo].[UserVoucher](
    [id] [int] IDENTITY(1,1) NOT NULL,
    [userId] [int] NOT NULL,
    [voucherId] [int] NOT NULL,
    [isUsed] [bit] NOT NULL DEFAULT ((0)),
    [voucherCode] [nvarchar](50) NOT NULL,
    [usedDate] [datetime] NULL,
    [orderId] [int] NULL,
    
    PRIMARY KEY CLUSTERED ([id] ASC),
    
    CONSTRAINT FK_UserVoucher_User    FOREIGN KEY(userId)    REFERENCES [User](id),
    CONSTRAINT FK_UserVoucher_Voucher FOREIGN KEY(voucherId) REFERENCES Voucher(id),
    CONSTRAINT FK_UserVoucher_Order   FOREIGN KEY(orderId)   REFERENCES [Order](id)
) ON [PRIMARY]
GO

-- 18. Bảng PartsSupplier
CREATE TABLE PartsSupplier (
    id         INT      IDENTITY(1,1) PRIMARY KEY,
    partId     INT      NOT NULL,
    supplierId INT      NOT NULL,

    CONSTRAINT FK_PartsSupplier_Part     FOREIGN KEY(partId)     REFERENCES Parts(id),
    CONSTRAINT FK_PartsSupplier_Supplier FOREIGN KEY(supplierId) REFERENCES Supplier(id)
);
GO

-- 19. Bảng PartsService
CREATE TABLE PartsService (
    id        INT IDENTITY(1,1) PRIMARY KEY,
    serviceId INT NOT NULL,
    partId    INT NOT NULL,

    CONSTRAINT FK_PartsService_Service FOREIGN KEY(serviceId) REFERENCES Service(id),
    CONSTRAINT FK_PartsService_Part FOREIGN KEY(partId) REFERENCES Parts(id)
);
GO

-- 20. Bảng OrderService
CREATE TABLE OrderService (
    id        INT IDENTITY(1,1) PRIMARY KEY,
    orderId   INT NOT NULL,
    serviceId INT NOT NULL,

    CONSTRAINT FK_OrderService_Order   FOREIGN KEY(orderId) REFERENCES [Order](id),
    CONSTRAINT FK_OrderService_Service FOREIGN KEY(serviceId) REFERENCES Service(id)
);
GO

-- 21. Bảng OrderParts
CREATE TABLE OrderParts (
    id      INT IDENTITY(1,1) PRIMARY KEY,
    orderId INT NOT NULL,
    partId  INT NOT NULL,
    FOREIGN KEY (orderId) REFERENCES [Order](id),
    FOREIGN KEY (partId) REFERENCES Parts(id)
);
GO

-- 22. Bảng Setting
CREATE TABLE [Setting] (
    [id] INT IDENTITY(1,1) PRIMARY KEY,
    [name] VARCHAR(100) NOT NULL,
    [value] NVARCHAR(MAX) NOT NULL
);
GO

-- 23. Bảng Notification
CREATE TABLE [Notification](
    id int identity(1,1) primary key,
    [message] nvarchar(100) not null,
    status bit not null,
    createDate date not null DEFAULT GETDATE(),
    recieverId int not null,
    notification_type nvarchar(50) not null,
    CONSTRAINT FK_Notification_User    FOREIGN KEY(recieverId)    REFERENCES [User](id)
)
GO

-- 24. Bảng NotificationSetting
CREATE TABLE [NotificationSetting](
    id int identity(1,1) primary key,
    recieverId int not null UNIQUE,
    [notification_time] bit,
    [notification_status] bit,
    [profile] bit,
    [order_change] bit,
    attendance bit,
    email bit,
    [service] bit,
    insurance bit,
    category bit,
    supplier bit,
    parts bit,
    [setting_change] bit,
    car_type bit,
    campaign bit,
    blog bit,
    voucher bit,
    CONSTRAINT FK_NotificationSetting_User FOREIGN KEY(recieverId) REFERENCES [User](id)
)
GO

-- INSERT DỮ LIỆU MẪU
INSERT INTO [dbo].[User]
           ([username], [password], [email], [phone], [address], [createDate], [role])
VALUES
           (N'admin01', N'123', N'admin@example.com', N'0900000001', N'Hà Nội', GETDATE(), N'admin'),
           (N'manager01', N'123', N'manager@example.com', N'0900000002', N'Hồ Chí Minh', GETDATE(), N'manager'),
           (N'repairer01', N'123', N'repairer@example.com', N'0900000003', N'Đà Nẵng', GETDATE(), N'repairer'),
           (N'customer01', N'123', N'customer@example.com', N'0900000004', N'Cần Thơ', GETDATE(), N'customer'),
           (N'warehouse01', N'123', N'warehouse@gmail.com', N'0900000005', N'Bình Dương', GETDATE(), N'warehouse manager'),
           (N'marketing01', N'123', N'marketing@example.com', N'0900000006', N'Nha Trang', GETDATE(), N'marketing');
GO

INSERT INTO Category (name, description, status) VALUES
('Engine',           N'Động cơ ô tô chịu trách nhiệm tạo lực đẩy',                    1),
('Transmission',     N'Hộp số và cơ cấu truyền động',                                1),
('Brakes',           N'Hệ thống phanh đảm bảo an toàn khi giảm tốc và dừng xe',      1),
('Suspension',       N'Hệ thống treo giảm chấn, giữ ổn định khung xe',               1),
('Electrical',       N'Hệ thống điện, bao gồm ắc-quy, máy phát và khởi động',        1),
('Cooling',          N'Hệ thống làm mát động cơ, két nước và quạt giải nhiệt',       1),
('Fuel System',      N'Hệ thống nhiên liệu: bơm, bình chứa và kim phun',             1),
('Exhaust System',   N'Hệ thống xả khí thải, ống pô và bộ lọc khí thải',             1),
('Steering',         N'Hệ thống lái gồm tay lái, trục lái và trợ lực lái',           1),
('Tires & Wheels',   N'Vỏ, mâm và van xe đảm bảo bám đường và chịu tải trọng',      1);
GO

-- Insert bảng Parts (liên kết với Service, Category, Supplier)
INSERT INTO Parts (name, image, categoryId, price) VALUES
  -- Engine (categoryId = 1)
  (N'Timing Belt', 'iStock-1080119374.jpg' , 1, 120.00),
  (N'Spark Plug', 'blog-17.5.jpg',  1,  15.00),
  (N'Air Filter', '71SRS5E+NfL.jpg' , 1,  25.00),

  -- Transmission (categoryId = 2)
  (N'Clutch Plate',  'Diagram-to-explain-how-does-a-clutch-work.jpg' ,        2, 150.00),
  (N'Gearbox Oil',    'delo-gear-ep-5.png'      ,        2,  40.00),
  (N'Shift Lever', '619s8In8SZL._UF1000,1000_QL80_.jpg' ,     2,  80.00),

  -- Brakes (categoryId = 3)
  (N'Brake Pad Front',  'zimmermann-default-title-brake-pads-front-420538156977729.jpg'    ,             3,  60.00),
  (N'Brake Disc Rear',   'BDVOLK012-01-1.jpg'    ,         3,  75.00),
  (N'Brake Caliper',  'BDVOLK012-01-1.jpg'    ,            3, 150.00),

  -- Suspension (categoryId = 4)
  (N'Shock Absorber Front Left', 'BDVOLK012-01-1.jpg'    ,      4, 200.00),
  (N'Coil Spring Rear',  'BDVOLK012-01-1.jpg'    ,             4, 120.00),
  (N'Strut Mount',    'BDVOLK012-01-1.jpg'    ,                4,  90.00),

  -- Electrical (categoryId = 5)
  (N'Car Battery 12V',  'BDVOLK012-01-1.jpg'    ,              5, 110.00),
  (N'Alternator',   'BDVOLK012-01-1.jpg'    ,                  5, 250.00),
  (N'Starter Motor',  'BDVOLK012-01-1.jpg'    ,                5, 180.00),

  -- Cooling (categoryId = 6)
  (N'Radiator',    'BDVOLK012-01-1.jpg'    ,                   6, 300.00),
  (N'Water Pump',   'BDVOLK012-01-1.jpg'    ,                  6,  75.00),
  (N'Cooling Fan',   'BDVOLK012-01-1.jpg'    ,                 6,  65.00),

  -- Fuel System (categoryId = 7)
  (N'Fuel Pump',    'BDVOLK012-01-1.jpg'    ,                  7, 130.00),
  (N'Fuel Injector',   'BDVOLK012-01-1.jpg'    ,               7,  45.00),
  (N'Fuel Filter',   'BDVOLK012-01-1.jpg'    ,                 7,  35.00),

  -- Exhaust System (categoryId = 8)
  (N'Muffler',    'BDVOLK012-01-1.jpg'    ,                    8, 200.00),
  (N'Catalytic Converter',  'BDVOLK012-01-1.jpg'    ,          8, 500.00),
  (N'Exhaust Pipe',  'BDVOLK012-01-1.jpg'    ,                 8, 120.00),

  -- Steering (categoryId = 9)
  (N'Power Steering Pump',  'BDVOLK012-01-1.jpg'    ,          9, 180.00),
  (N'Steering Rack',   'BDVOLK012-01-1.jpg'    ,               9, 400.00),
  (N'Tie Rod End',   'BDVOLK012-01-1.jpg'    ,                 9,  45.00),

  -- Tires & Wheels (categoryId = 10)
  (N'Alloy Wheel 17\"',  'BDVOLK012-01-1.jpg'    ,            10, 120.00),
  (N'Tire 225/45R17',   'BDVOLK012-01-1.jpg'    ,             10,  90.00),
  (N'Valve Stem',    'BDVOLK012-01-1.jpg'    ,                10,   5.00);

GO

INSERT INTO CarType (name, status, description, created_at, updated_at) VALUES 
(N'Toyota Vios', 1, NULL, GETDATE(), NULL),
(N'Honda Civic', 1, NULL, GETDATE(), NULL),
(N'Hyundai Accent', 1, NULL, GETDATE(), NULL),
(N'Ford Ranger', 1, NULL, GETDATE(), NULL),
(N'Kia Seltos', 1, NULL, GETDATE(), NULL),
(N'Mazda CX-5', 1, NULL, GETDATE(), NULL),
(N'VinFast Lux A2.0', 1, NULL, GETDATE(), NULL),
(N'Toyota Camry', 1, NULL, GETDATE(), NULL),
(N'Mercedes C-Class', 1, NULL, GETDATE(), NULL),
(N'BMW X5', 1, NULL, GETDATE(), NULL);
GO

INSERT INTO [Setting] (name, value) VALUES 
('site_name', 'Car Care Centre'),
('logo_url', 'img/logo.png'),
('working_hours', 'Mon-Sat: 08:00 - 18:00'),
('footer_text', '© 2025 Garage Pro. All rights reserved.'),
('contact_email', 'support@carcarecentre.com'),
('more_services', 'Click here for more...'),
('service_exp1', 'Professional Maintenance'),
('service_exp2', 'Authentic Products'),
('service_exp3', 'Numerous Vouchers'),
('hotline', '0123 456 789'),
('header_color', 'lightblue'),
('footer_color', 'lightblue');
GO

INSERT INTO Supplier ([name], logo, [description], email, phone, [address]) VALUES
('AutoPlus Co., Ltd.', 'Auto_Care.jpg', N'Nhà cung cấp phụ tùng ô tô chính hãng', 'contact@autoplus.vn', '0912345678', N'123 Đường Lớn, Quận 1, TP. HCM'),
('CarCare Vietnam', '1600w-B1MIRD2ZskY.webp', N'Dịch vụ chăm sóc xe chuyên nghiệp', 'support@carcare.vn', '0987654321', N'456 Phố Xe Hơi, Quận 7, TP. HCM'),
('Speedy Parts', 'car-logo-automotive-wash-sign-600nw-2289579553.webp', N'Cung cấp phụ tùng thay thế nhanh chóng', 'sales@speedyparts.vn', '0909123456', N'789 Lê Lợi, Quận 3, TP. HCM'),
('ProDetailer', 'automotive-auto-care-logo-template-modern-sport-car-automotive-auto-care-logo-template-modern-sport-car-vector-illustration-191268375.webp', N'Sản phẩm chăm sóc xe cao cấp', 'info@prodetailer.vn', '0911222333', N'12 Nguyễn Huệ, Quận 1, TP. HCM'),
('VietAuto Supplies', 'Auto_Care.jpg', N'Đại lý phụ tùng và phụ kiện ô tô', 'order@vietautosupplies.vn', '0988777666', N'34 Trần Hưng Đạo, Quận 5, TP. HCM'),
('PremiumCar Care', '1600w-B1MIRD2ZskY.webp', N'Chăm sóc xe hạng sang', 'hello@premiumcar.vn', '0900765432', N'56 Nguyễn Trãi, Quận 5, TP. HCM'),
('Quality Garage', 'car-logo-automotive-wash-sign-600nw-2289579553.webp', N'Nhà phân phối phụ tùng chính hãng', 'contact@qualitygarage.vn', '0911333444', N'78 Tôn Đức Thắng, Quận 1, TP. HCM'),
('Express Wash', 'Auto_Care.jpg', N'Dịch vụ rửa xe nhanh – gọn – lẹ', 'service@expresswash.vn', '0977888999', N'90 Bạch Đằng, Quận Bình Thạnh, TP. HCM'),
('EliteParts', 'Auto_Care.jpg', N'Phụ tùng xe hơi cao cấp nhập khẩu', 'support@eliteparts.vn', '0933555777', N'101 Nguyễn Văn Trỗi, Quận Phú Nhuận, TP. HCM'),
('SafeDrive Supplies', 'Auto_Care.jpg', N'Phụ kiện an toàn và đồ bảo hộ lái xe', 'info@safedrive.vn', '0922666888', N'202 Hoàng Văn Thụ, Quận Tân Bình, TP. HCM');

GO

INSERT INTO PartsSupplier (partId, supplierId) VALUES
  -- partId 1–10 chia đều cho supplierId 1–10
  ( 1,  1),
  ( 2,  2),
  ( 3,  3),
  ( 4,  4),
  ( 5,  5),
  ( 6,  6),
  ( 7,  7),
  ( 8,  8),
  ( 9,  9),
  (10, 10),

  -- partId 11–20 lặp lại supplierId 1–10
  (11,  1),
  (12,  2),
  (13,  3),
  (14,  4),
  (15,  5),
  (16,  6),
  (17,  7),
  (18,  8),
  (19,  9),
  (20, 10),

  -- partId 21–30 tiếp tục chia tuần tự
  (21,  1),
  (22,  2),
  (23,  3),
  (24,  4),
  (25,  5),
  (26,  6),
  (27,  7),
  (28,  8),
  (29,  9),
  (30, 10);

GO

INSERT INTO Size (name, partId, quantity) VALUES
  ('S',  1,   0), ('M',  1,   0),
  ('S',  2,   0), ('M',  2,   0),
  ('S',  3,   0), ('M',  3, 300),
  ('S',  4, 300), ('M',  4, 300),
  ('S',  5, 300), ('M',  5, 300),
  ('S',  6, 300), ('M',  6, 300),
  ('S',  7, 300), ('M',  7, 300),
  ('S',  8, 300), ('M',  8, 300),
  ('S',  9, 300), ('M',  9, 300),
  ('S', 10, 300), ('M', 10, 300),
  ('S', 11, 300), ('M', 11, 300),
  ('S', 12, 300), ('M', 12, 300),
  ('S', 13, 300), ('M', 13, 300),
  ('S', 14, 300), ('M', 14, 300),
  ('S', 15, 300), ('M', 15, 300);
GO

-- PART 16–30 (3 size mỗi part): tất cả quantity = 300
INSERT INTO Size (name, partId, quantity) VALUES
  ('S', 16, 300), ('M', 16, 300), ('L', 16, 300),
  ('S', 17, 300), ('M', 17, 300), ('L', 17, 300),
  ('S', 18, 300), ('M', 18, 300), ('L', 18, 300),
  ('S', 19, 300), ('M', 19, 300), ('L', 19, 300),
  ('S', 20, 300), ('M', 20, 300), ('L', 20, 300),
  ('S', 21, 300), ('M', 21, 300), ('L', 21, 300),
  ('S', 22, 300), ('M', 22, 300), ('L', 22, 300),
  ('S', 23, 300), ('M', 23, 300), ('L', 23, 300),
  ('S', 24, 300), ('M', 24, 300), ('L', 24, 300),
  ('S', 25, 300), ('M', 25, 300), ('L', 25, 300),
  ('S', 26, 300), ('M', 26, 300), ('L', 26, 300),
  ('S', 27, 300), ('M', 27, 300), ('L', 27, 300),
  ('S', 28, 300), ('M', 28, 300), ('L', 28, 300),
  ('S', 29, 300), ('M', 29, 300), ('L', 29, 300),
  ('S', 30, 300), ('M', 30, 300), ('L', 30, 300);

GO

INSERT INTO [Notification] ([message], status, recieverId, notification_type)
VALUES 
(N'Linh Kiện Tank vừa được sửa', 1, 5, N'Part'),
(N'Nhà cung cấp Auto vừa bị xóa', 0, 5, N'Supplier'),
(N'Tài khoản của bạn đã được cập nhật', 1, 5, N'Part'),
(N'Có lỗi mới kết bạn mới', 0, 5, N'Profile'),
(N'Sự kiện mới sắp diễn ra', 0, 5, N'Part');

GO

INSERT INTO [NotificationSetting] (
    recieverId,
    notification_time,
    notification_status,
    profile,
    order_change,
    attendance,
    email,
    service,
    insurance,
    category,
    supplier,
    parts,
    setting_change,
    car_type,
    campaign,
    blog,
    voucher
)
VALUES (
    5, -- recieverId
    1, -- notification_time
    1, -- notification_status
    0, -- profile
    0, -- order_change
    0, -- attendance
    1, -- email
    0, -- service
    0, -- insurance
    1, -- category
    1, -- supplier
    1, -- parts
    0, -- setting_change
    0, -- car_type
    0, -- campaign
    0, -- blog
    0  -- voucher
);

GO

INSERT INTO [NotificationSetting] (
    recieverId,
    notification_time,
    notification_status,
    profile,
    order_change,
    attendance,
    email,
    service,
    insurance,
    category,
    supplier,
    parts,
    setting_change,
    car_type,
    campaign,
    blog,
    voucher
)
VALUES (
    4, -- recieverId
    1, -- notification_time
    1, -- notification_status
    1, -- profile
    1, -- order_change
    0, -- attendance
    1, -- email
    0, -- service
    0, -- insurance
    0, -- category
    0, -- supplier
    0, -- parts
    0, -- setting_change
    0, -- car_type
    0, -- campaign
    1, -- blog
    0  -- voucher
);

GO

INSERT INTO [NotificationSetting] (
    recieverId,
    notification_time,
    notification_status,
    profile,
    order_change,
    attendance,
    email,
    service,
    insurance,
    category,
    supplier,
    parts,
    setting_change,
    car_type,
    campaign,
    blog,
    voucher
)
VALUES (
    1, -- recieverId
    1, -- notification_time
    1, -- notification_status
    1, -- profile
    0, -- order_change
    0, -- attendance
    1, -- email
    0, -- service
    0, -- insurance
    0, -- category
    0, -- supplier
    0, -- parts
    1, -- setting_change
    0, -- car_type
    0, -- campaign
    0, -- blog
    0  -- voucher
);

GO

INSERT INTO [NotificationSetting] (
    recieverId,
    notification_time,
    notification_status,
    profile,
    order_change,
    attendance,
    email,
    service,
    insurance,
    category,
    supplier,
    parts,
    setting_change,
    car_type,
    campaign,
    blog,
    voucher
)
VALUES (
    2, -- recieverId
    1, -- notification_time
    1, -- notification_status
    1, -- profile
    1, -- order_change
    1, -- attendance
    1, -- email
    0, -- service
    1, -- insurance
    0, -- category
    0, -- supplier
    0, -- parts
    0, -- setting_change
    0, -- car_type
    0, -- campaign
    0, -- blog
    0  -- voucher
);

GO

INSERT INTO [NotificationSetting] (
    recieverId,
    notification_time,
    notification_status,
    profile,
    order_change,
    attendance,
    email,
    service,
    insurance,
    category,
    supplier,
    parts,
    setting_change,
    car_type,
    campaign,
    blog,
    voucher
)
VALUES (
    3, -- recieverId
    1, -- notification_time
    1, -- notification_status
    1, -- profile
    1, -- order_change
    1, -- attendance
    1, -- email
    1, -- service
    0, -- insurance
    0, -- category
    0, -- supplier
    0, -- parts
    0, -- setting_change
    1, -- car_type
    0, -- campaign
    0, -- blog
    0  -- voucher
);

GO

INSERT INTO [NotificationSetting] (
    recieverId,
    notification_time,
    notification_status,
    profile,
    order_change,
    attendance,
    email,
    service,
    insurance,
    category,
    supplier,
    parts,
    setting_change,
    car_type,
    campaign,
    blog,
    voucher
)
VALUES (
    6, -- recieverId
    1, -- notification_time
    1, -- notification_status
    1, -- profile
    0, -- order_change
    1, -- attendance
    0, -- email
    0, -- service
    0, -- insurance
    0, -- category
    0, -- supplier
    0, -- parts
    0, -- setting_change
    0, -- car_type
    1, -- campaign
    1, -- blog
    1  -- voucher
);
GO

INSERT INTO Service (name, description, price, img) VALUES
(N'Rửa xe', N'Rửa ngoài', 50000, N'rua_xe_oto.jpg'),
(N'Vệ sinh nội thất', N'Nội thất sạch', 90000, N've_sinh_noi_that.jpg'),
(N'Bảo dưỡng tổng thể', N'Bảo dưỡng xe', 200000, N'bao_duong.jpg'),
(N'Kiểm tra động cơ', N'Kiểm tra chi tiết', 150000, N'bao_duong_dong_co.jpg'),
(N'Đánh bóng sơn', N'Làm mới ngoại thất', 120000, N'danh_bong.jpg'),
(N'Thay dầu', N'Dầu nhớt xe', 100000, N'thay_dau.jpg'),
(N'Lắp lốp mới', N'Lốp chất lượng', 800000, N'thay_nop.jpg'),
(N'Sửa điện', N'Sửa chữa điện', 90000, N'sua_dien.jpg'),
(N'Thay ắc quy', N'Ắc quy mới', 350000, N'thay_acquy.jpg'),
(N'Sửa điều hòa', N'Điều hòa mát', 250000, N'sua_dieuhoa.jpg');
GO

INSERT INTO [dbo].[InsuranceType]
           ([name], [description], [price])
     VALUES
           (N'Bảo hiểm cơ bản', N'Bảo hiểm trách nhiệm dân sự bắt buộc cho xe cơ giới.', 500000),
           (N'Bảo hiểm toàn diện', N'Bảo hiểm bao gồm thiết hại xe, tai nạn, cháy nổ và mất cắp.', 2000000),
           (N'Bảo hiểm tai nạn cá nhân', N'Bảo hiểm cho người điều khiển xe trong trường hợp tai nạn.', 750000),
           (N'Bảo hiểm thiên tai', N'Bảo hiểm cho xe trong các trường hợp thiên tai như lũ lụt, bão.', 1000000),
           (N'Bảo hiểm mất cắp', N'Bảo hiểm chuyên biệt cho trường hợp xe bị trộm cắp hoặc cướp.', 1200000);
GO

INSERT INTO Attendance (userId, date, status) VALUES
(3, '2025-07-25', 0),
(6, '2025-07-25', 1),
(3, '2025-07-24', 1),
(6, '2025-07-24', 0),
(3, '2025-07-23', 0),
(6, '2025-07-23', 1);
GO

-- Feedback của userId 4
INSERT INTO [dbo].[Feedback]
           ([userId], [description], [createDate], [serviceId], [rating])
     VALUES
           (4, N'Dịch vụ rất tốt, nhân viên nhiệt tình.', '2025-07-25', 1, 5),
           (4, N'Thời gian chờ hơi lâu nhưng chất lượng ổn.', '2025-07-24', 2, 4);

-- Feedback của userId 11
INSERT INTO [dbo].[Feedback]
           ([userId], [description], [createDate], [serviceId], [rating])
     VALUES
           (11, N'Không hài lòng với thái độ phục vụ.', '2025-07-23', 3, 2),
           (11, N'Làm việc nhanh chóng, giá cả hợp lý.', '2025-07-22', 4, 5);
GO

USE [CarCareSystem]
GO

INSERT INTO [dbo].[Insurance]
           ([userId], [carTypeId], [startDate], [endDate], [insuranceTypeId])
VALUES
           (4, 1, '2025-07-22', '2026-07-21', 1),
           (4, 1, '2025-07-22', '2026-07-21', 2),
           (4, 1, '2025-07-21', '2026-07-20', 3),
           (4, 4, '2025-07-18', '2026-07-17', 4),
           (4, 1, '2025-07-18', '2026-07-17', 1),
           (4, 1, '2025-07-09', '2026-07-08', 2),
           (4, 1, '2025-07-09', '2026-07-08', 3),
           (4, 1, '2025-07-24', '2025-07-25', 1),
           (4, 1, '2025-07-25', '2025-07-26', 1),
           (11, 6, '2025-07-18', '2025-08-08', 1);
GO

INSERT INTO PartsService (serviceId, partId) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);

INSERT INTO [dbo].[Campaign] ([name], [status], [description], [startDate], [endDate], [img], [thumbnail], [createdDate])
VALUES 
(N'Ưu đãi Black Friday 2025', 1, N'Giảm giá sốc 30% cho tất cả dịch vụ và phụ tùng trong ngày Black Friday', '2025-11-29', '2025-11-30', N'image/blackfriday_campaign.jpg', N'image/blackfriday_thumb.jpg', GETDATE()),
(N'Khuyến mãi Tết Nguyên Đán', 1, N'Chương trình khuyến mãi đặc biệt mừng Tết Ất Tỵ 2025', '2025-01-25', '2025-02-10', N'image/tet_campaign.jpg', N'image/tet_thumb.jpg', GETDATE()),
(N'Chăm sóc xe mùa mưa', 1, N'Dịch vụ chăm sóc xe chuyên biệt cho mùa mưa bão', '2025-09-01', '2025-11-30', N'image/rainy_season.jpg', N'image/rainy_thumb.jpg', GETDATE()),
(N'Bảo dưỡng định kỳ', 0, N'Chương trình bảo dưỡng định kỳ cho xe cũ', '2025-06-01', '2025-06-30', N'image/maintenance_campaign.jpg', N'image/maintenance_thumb.jpg', GETDATE()),
(N'Khuyến mãi sinh nhật 5 năm', 1, N'Kỷ niệm 5 năm thành lập trung tâm chăm sóc xe', '2025-03-15', '2025-04-15', N'image/anniversary_campaign.jpg', N'image/anniversary_thumb.jpg', GETDATE());
GO

-- THÊM DỮ LIỆU MẪU CHO VOUCHER (bổ sung thêm)
INSERT INTO [dbo].[Voucher] ([name], [description], [discount], [discountType], [maxDiscountAmount], [minOrderAmount], [startDate], [endDate], [serviceId], [campaignId], [status], [createdDate], [voucherCode], [totalVoucherCount])
VALUES 
-- Voucher cho campaign Black Friday
(N'Black Friday 30%', N'Giảm 30% tất cả dịch vụ trong ngày Black Friday', 30, 'PERCENTAGE', 200000, 300000, '2025-11-29', '2025-11-30', NULL, 3, 'ACTIVE', GETDATE(), 'BF30OFF', 200),
(N'Miễn phí rửa xe', N'Voucher miễn phí dịch vụ rửa xe cho khách hàng mới', 100, 'PERCENTAGE', 50000, 0, '2025-11-29', '2025-11-30', 1, 3, 'ACTIVE', GETDATE(), 'FREEWASH', 50),

-- Voucher cho campaign Tết
(N'Lì xì Tết 100k', N'Voucher giảm 100.000đ mừng Tết Nguyên Đán', 100000, 'FIXED_AMOUNT', NULL, 500000, '2025-01-25', '2025-02-10', NULL, 4, 'ACTIVE', GETDATE(), 'TET100K', 100),
(N'Giảm 25% bảo dưỡng Tết', N'Voucher giảm 25% dịch vụ bảo dưỡng dịp Tết', 25, 'PERCENTAGE', 150000, 200000, '2025-01-25', '2025-02-10', 3, 4, 'ACTIVE', GETDATE(), 'TET25', 80),

-- Voucher cho campaign mùa mưa
(N'Chống thấm 20%', N'Giảm 20% dịch vụ chống thấm xe mùa mưa', 20, 'PERCENTAGE', 100000, 150000, '2025-09-01', '2025-11-30', 5, 5, 'ACTIVE', GETDATE(), 'RAIN20', 120),
(N'Kiểm tra điện miễn phí', N'Miễn phí kiểm tra hệ thống điện mùa mưa', 100, 'PERCENTAGE', 90000, 0, '2025-09-01', '2025-11-30', 8, 5, 'ACTIVE', GETDATE(), 'FREECHECK', 60),

-- Voucher cho campaign sinh nhật
(N'Sinh nhật 5 năm - 50%', N'Giảm 50% dịch vụ đánh bóng sơn nhân dịp sinh nhật', 50, 'PERCENTAGE', 60000, 100000, '2025-03-15', '2025-04-15', 5, 7, 'ACTIVE', GETDATE(), 'BDAY50', 150),
(N'Combo sinh nhật 200k', N'Voucher combo giảm 200k cho 2 dịch vụ bất kỳ', 200000, 'FIXED_AMOUNT', NULL, 400000, '2025-03-15', '2025-04-15', NULL, 7, 'ACTIVE', GETDATE(), 'COMBO200K', 75),

-- Voucher không thuộc campaign nào
(N'Khách VIP 15%', N'Voucher dành riêng cho khách hàng VIP', 15, 'PERCENTAGE', 100000, 200000, '2025-01-01', '2025-12-31', NULL, NULL, 'ACTIVE', GETDATE(), 'VIP15', 500),
(N'Thay lốp giảm 10%', N'Voucher giảm 10% cho dịch vụ lắp lốp mới', 10, 'PERCENTAGE', 80000, 600000, '2025-01-01', '2025-12-31', 7, NULL, 'ACTIVE', GETDATE(), 'TIRE10', 200);
GO

-- THÊM DỮ LIỆU MẪU CHO BLOG
INSERT INTO [dbo].[Blog] ([title], [campaignId], [content], [createDate], [updatedDate], [status])
VALUES 
-- Blog thuộc campaign
(N'Bí quyết chăm sóc xe mùa hè hiệu quả', 1, N'Mùa hè với nhiệt độ cao và ánh nắng gay gắt có thể ảnh hưởng nghiêm trọng đến xe của bạn. Dưới đây là những bí quyết chăm sóc xe mùa hè: 1. Kiểm tra hệ thống làm mát thường xuyên 2. Bảo vệ sơn xe khỏi tia UV 3. Kiểm tra áp suất lốp xe 4. Vệ sinh nội thất để tránh mùi hôi...', GETDATE(), GETDATE(), 1),

(N'Ưu đãi Black Friday - Tiết kiệm 30% chi phí bảo dưỡng xe', 3, N'Chỉ trong 2 ngày Black Friday, trung tâm chăm sóc xe của chúng tôi mang đến ưu đãi cực khủng với mức giảm giá lên đến 30% cho tất cả dịch vụ. Đây là cơ hội vàng để bạn chăm sóc xe yêu với chi phí tối ưu nhất...', GETDATE(), GETDATE(), 1),

(N'Chuẩn bị xe đón Tết Nguyên Đán 2025', 4, N'Tết Nguyên Đán đang đến gần, đây là thời điểm quan trọng để chuẩn bị xe cho những chuyến đi xa về quê. Hãy cùng chúng tôi tìm hiểu những bước chuẩn bị cần thiết: 1. Kiểm tra toàn diện hệ thống phanh 2. Thay dầu động cơ và các loại dầu khác 3. Kiểm tra lốp xe và áp suất...', GETDATE(), GETDATE(), 1),

(N'Chăm sóc xe mùa mưa - Những điều cần lưu ý', 5, N'Mùa mưa bão đã đến, việc chăm sóc xe trong thời tiết ẩm ướt đòi hỏi sự chú ý đặc biệt. Bài viết này sẽ hướng dẫn bạn cách bảo vệ xe khỏi những tác động xấu của thời tiết: 1. Kiểm tra hệ thống thoát nước 2. Bảo vệ hệ thống điện khỏi ẩm ướt 3. Vệ sinh gầm xe thường xuyên...', GETDATE(), GETDATE(), 1),

(N'5 năm đồng hành - Cảm ơn sự tin tưởng của khách hàng', 7, N'Nhân dịp kỷ niệm 5 năm thành lập, chúng tôi xin gửi lời cảm ơn chân thành nhất đến tất cả khách hàng đã tin tưởng và đồng hành cùng trung tâm chăm sóc xe. Trong 5 năm qua, chúng tôi đã phục vụ hơn 10,000 lượt khách hàng với chất lượng dịch vụ ngày càng hoàn thiện...', GETDATE(), GETDATE(), 1),

-- Blog có trạng thái inactive
(N'Xu hướng công nghệ ô tô 2024', NULL, N'Năm 2024 đánh dấu những bước tiến vượt bậc trong công nghệ ô tô với sự phát triển của xe điện, xe tự lái và các hệ thống hỗ trợ lái xe thông minh. Bài viết này sẽ điểm qua những xu hướng công nghệ nổi bật nhất trong ngành ô tô...', GETDATE(), GETDATE(), 0),

(N'Kinh nghiệm lái xe an toàn trong thành phố', NULL, N'Lái xe trong thành phố với mật độ giao thông cao đòi hỏi kỹ năng và kinh nghiệm đặc biệt. Bài viết này sẽ chia sẻ những kinh nghiệm quý báu giúp bạn lái xe an toàn trong môi trường đô thị phức tạp...', GETDATE(), GETDATE(), 0);
GO

-- THÊM DỮ LIỆU MẪU CHO USERVOUCHER (bổ sung)
INSERT INTO [dbo].[UserVoucher] ([userId], [voucherId], [isUsed], [voucherCode], [usedDate], [orderId])
VALUES 
-- User 4 có thêm voucher
(4, 4, 0, 'BF30OFF', NULL, NULL),
(4, 6, 0, 'TET100K', NULL, NULL),
(4, 11, 0, 'VIP15', NULL, NULL),

-- User 6 có thêm voucher  
(6, 5, 0, 'FREEWASH', NULL, NULL),
(6, 7, 0, 'TET25', NULL, NULL),
(6, 12, 0, 'TIRE10', NULL, NULL),

-- User khác
(1, 8, 0, 'RAIN20', NULL, NULL),
(2, 9, 0, 'FREECHECK', NULL, NULL),
(3, 10, 0, 'BDAY50', NULL, NULL);
GO

