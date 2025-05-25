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
    id     INT          IDENTITY(1,1) PRIMARY KEY,
    name   NVARCHAR(100) NOT NULL,
    status BIT          NOT NULL DEFAULT 1
);
GO

-- 4. Bảng Category
CREATE TABLE Category (
    id     INT          IDENTITY(1,1) PRIMARY KEY,
    name   NVARCHAR(100) NOT NULL,
    status BIT          NOT NULL DEFAULT 1
);
GO

-- 5. Bảng Supplier
CREATE TABLE Supplier (
    id     INT          IDENTITY(1,1) PRIMARY KEY,
    name   NVARCHAR(150) NOT NULL,
    status BIT          NOT NULL DEFAULT 1
);
GO

-- 6. Bảng Service (tạo trước, FK partId sẽ thêm sau)
CREATE TABLE Service (
    id          INT           IDENTITY(1,1) PRIMARY KEY,
    name        NVARCHAR(150) NOT NULL,
    partId      INT           NULL,
    description NVARCHAR(500) NULL,
    price       FLOAT NOT NULL
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

-- 8. Bảng Insurance
CREATE TABLE Insurance (
    id          INT           IDENTITY(1,1) PRIMARY KEY,
    userId      INT           NOT NULL,
    carTypeId   INT           NOT NULL,
    startDate   DATE          NOT NULL,
    endDate     DATE          NOT NULL,
    price       FLOAT NOT NULL,
    description NVARCHAR(500) NULL,

    CONSTRAINT FK_Insurance_User    FOREIGN KEY(userId)    REFERENCES [User](id),
    CONSTRAINT FK_Insurance_CarType FOREIGN KEY(carTypeId) REFERENCES CarType(id)
);
GO

-- 9. Bảng [Order]
CREATE TABLE [Order] (
    id              INT           IDENTITY(1,1) PRIMARY KEY,
    userId          INT           NOT NULL,
    carTypeId       INT           NOT NULL,
    serviceId       INT           NOT NULL,
    createDate      DATETIME      NOT NULL DEFAULT GETDATE(),
    appointmentDate DATETIME      NOT NULL,
    price           FLOAT NOT NULL,

    CONSTRAINT FK_Order_User    FOREIGN KEY(userId)    REFERENCES [User](id),
    CONSTRAINT FK_Order_CarType FOREIGN KEY(carTypeId) REFERENCES CarType(id),
    CONSTRAINT FK_Order_Service FOREIGN KEY(serviceId) REFERENCES Service(id)
);
GO

-- 10. Bảng Feedback
CREATE TABLE Feedback (
    id          INT      IDENTITY(1,1) PRIMARY KEY,
    userId      INT      NOT NULL,
    description NVARCHAR(1000) NOT NULL,
    createDate  DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Feedback_User FOREIGN KEY(userId) REFERENCES [User](id)
);
GO

-- 11. Bảng Parts
CREATE TABLE Parts (
    id         INT           IDENTITY(1,1) PRIMARY KEY,
    name       NVARCHAR(150) NOT NULL,
    serviceId  INT           NOT NULL,
    categoryId INT           NOT NULL,
    supplierId INT           NOT NULL,
    price      FLOAT NOT NULL,

    CONSTRAINT FK_Parts_Service  FOREIGN KEY(serviceId)  REFERENCES Service(id),
    CONSTRAINT FK_Parts_Category FOREIGN KEY(categoryId) REFERENCES Category(id),
    CONSTRAINT FK_Parts_Supplier FOREIGN KEY(supplierId) REFERENCES Supplier(id)
);
GO

-- 12. Thêm FK partId vào Service (circular reference)
ALTER TABLE Service
ADD CONSTRAINT FK_Service_Parts FOREIGN KEY(partId) REFERENCES Parts(id);
GO

-- 13. Bảng Size
CREATE TABLE Size (
    id      INT     IDENTITY(1,1) PRIMARY KEY,
    name    NVARCHAR(50) NOT NULL,
    partId  INT      NOT NULL,
    status  BIT      NOT NULL DEFAULT 1,
    quantity INT     NOT NULL,

    CONSTRAINT FK_Size_Parts FOREIGN KEY(partId) REFERENCES Parts(id)
);
GO

-- 14. Bảng Campaign
CREATE TABLE Campaign (
    id          INT      IDENTITY(1,1) PRIMARY KEY,
    name        NVARCHAR(150) NOT NULL,
    status      BIT      NOT NULL DEFAULT 1,
    description NVARCHAR(500) NULL,
    startDate   DATE     NOT NULL,
    endDate     DATE     NOT NULL
);
GO

-- 15. Bảng Blog
CREATE TABLE Blog (
    id          INT      IDENTITY(1,1) PRIMARY KEY,
    title       NVARCHAR(200) NOT NULL,
    campaignId  INT      NULL,
    content     NVARCHAR(MAX) NOT NULL,
    createDate  DATETIME NOT NULL DEFAULT GETDATE(),
    updatedDate DATETIME NULL,
    status      BIT      NOT NULL DEFAULT 1,

    CONSTRAINT FK_Blog_Campaign FOREIGN KEY(campaignId) REFERENCES Campaign(id)
);
GO

-- 16. Bảng Voucher
CREATE TABLE Voucher (
    id          INT           IDENTITY(1,1) PRIMARY KEY,
    name        NVARCHAR(150) NOT NULL,
    campaignId  INT           NULL,
    serviceId   INT           NULL,
    startDate   DATE          NOT NULL,
    endDate     DATE          NOT NULL,
    description NVARCHAR(500) NULL,
    discount    INT  NOT NULL,
    status      BIT           NOT NULL DEFAULT 1,

    CONSTRAINT FK_Voucher_Campaign FOREIGN KEY(campaignId) REFERENCES Campaign(id),
    CONSTRAINT FK_Voucher_Service  FOREIGN KEY(serviceId)  REFERENCES Service(id)
);
GO

-- 17. Bảng UserVoucher
CREATE TABLE UserVoucher (
    id        INT      IDENTITY(1,1) PRIMARY KEY,
    userId    INT      NOT NULL,
    voucherId INT      NOT NULL,

    CONSTRAINT FK_UserVoucher_User    FOREIGN KEY(userId)    REFERENCES [User](id),
    CONSTRAINT FK_UserVoucher_Voucher FOREIGN KEY(voucherId) REFERENCES Voucher(id)
);
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

-- 19. Kiểm tra toàn bộ
-- SELECT * FROM sys.tables;
