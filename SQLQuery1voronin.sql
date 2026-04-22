CREATE DATABASE CarRental;
GO

USE CarRental;
GO

-- Таблица Roles (роли пользователей)
CREATE TABLE Roles (
    role_id INT PRIMARY KEY IDENTITY(1,1),
    role_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);
GO

-- Таблица Tariff (тарифы)
CREATE TABLE Tariff (
    tariff_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    price_per_minute DECIMAL(10,2),
    price_per_km DECIMAL(10,2),
    included_km INT
);
GO

-- Таблица Model (модели автомобилей)
CREATE TABLE Model (
    model_id INT PRIMARY KEY IDENTITY(1,1),
    brand VARCHAR(50) NOT NULL,
    model_name VARCHAR(100) NOT NULL,
    car_type VARCHAR(50),
    transmission VARCHAR(30),
    tariff_id INT,
    FOREIGN KEY (tariff_id) REFERENCES Tariff(tariff_id)
);
GO

-- Таблица CarStatus (статусы автомобилей)
CREATE TABLE CarStatus (
    status_id INT PRIMARY KEY IDENTITY(1,1),
    status_name VARCHAR(50) NOT NULL
);
GO

-- Таблица Car (автомобили)
CREATE TABLE Car (
    car_id INT PRIMARY KEY IDENTITY(1,1),
    model_id INT NOT NULL,
    license_plate VARCHAR(20) UNIQUE NOT NULL,
    vin_code VARCHAR(50) UNIQUE,
    color VARCHAR(30),
    year INT,
    fuel_level DECIMAL(5,2),
    mileage_km INT,
    current_address VARCHAR(255),
    status_id INT,
    FOREIGN KEY (model_id) REFERENCES Model(model_id),
    FOREIGN KEY (status_id) REFERENCES CarStatus(status_id)
);
GO

-- Таблица Users (пользователи/клиенты)
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    login VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    passport_number VARCHAR(20),
    driver_license VARCHAR(20),
    phone VARCHAR(20),
    email VARCHAR(100),
    role_id INT NOT NULL,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);
GO

-- Таблица Booking (бронирования)
CREATE TABLE Booking (
    booking_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    car_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME,
    start_mileage INT,
    end_mileage INT,
    total_cost DECIMAL(10,2),
    status VARCHAR(50) DEFAULT 'active',
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (car_id) REFERENCES Car(car_id)
);
GO

-- Таблица Payment (платежи)
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_time DATETIME DEFAULT GETDATE(),
    payment_method VARCHAR(50),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);
GO