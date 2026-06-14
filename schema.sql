-- BookMyShow DB schema (MySQL)
-- Data Modelling assignment

-- Normalization notes:
-- 1NF: no repeating groups, each column holds one value
-- 2NF: BookingSeat table for seat mapping (avoids partial dependency)
-- 3NF: City and Language split out instead of storing names in every row
-- BCNF: unique (screen_id, show_date, show_time) so one screen can't have two shows at same slot

CREATE DATABASE IF NOT EXISTS bookmyshow;
USE bookmyshow;

-- 1. Language
CREATE TABLE Language (
    language_id   INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL UNIQUE
);

-- 2. Movie
CREATE TABLE Movie (
    movie_id         INT AUTO_INCREMENT PRIMARY KEY,
    title            VARCHAR(200) NOT NULL,
    language_id      INT NOT NULL,
    format           ENUM('2D', '3D', 'IMAX', '4DX') NOT NULL,
    duration_minutes INT,
    genre            VARCHAR(100),
    rating           ENUM('U', 'UA', 'A', 'S'),
    release_date     DATE,
    FOREIGN KEY (language_id) REFERENCES Language(language_id)
);

-- 3. City
CREATE TABLE City (
    city_id   INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL UNIQUE
);

-- 4. Theatre
CREATE TABLE Theatre (
    theatre_id INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(200) NOT NULL,
    address    TEXT,
    city_id    INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES City(city_id)
);

-- 5. Screen
CREATE TABLE Screen (
    screen_id     INT AUTO_INCREMENT PRIMARY KEY,
    theatre_id    INT NOT NULL,
    screen_name   VARCHAR(50) NOT NULL,
    total_seats   INT NOT NULL,
    screen_format ENUM('2D', '3D', 'IMAX', '4DX') NOT NULL,
    FOREIGN KEY (theatre_id) REFERENCES Theatre(theatre_id)
);

-- 6. Show
CREATE TABLE `Show` (
    show_id         INT AUTO_INCREMENT PRIMARY KEY,
    movie_id        INT NOT NULL,
    screen_id       INT NOT NULL,
    show_date       DATE NOT NULL,
    show_time       TIME NOT NULL,
    available_seats INT,
    price           DECIMAL(8, 2),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
    FOREIGN KEY (screen_id) REFERENCES Screen(screen_id),
    UNIQUE KEY uk_screen_datetime (screen_id, show_date, show_time)
);

-- 7. User
CREATE TABLE `User` (
    user_id    INT AUTO_INCREMENT PRIMARY KEY,
    full_name  VARCHAR(100),
    email      VARCHAR(150) UNIQUE,
    phone      VARCHAR(15),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 8. Booking
CREATE TABLE Booking (
    booking_id     INT AUTO_INCREMENT PRIMARY KEY,
    user_id        INT NOT NULL,
    show_id        INT NOT NULL,
    num_seats      INT NOT NULL,
    total_amount   DECIMAL(10, 2),
    booking_status ENUM('CONFIRMED', 'CANCELLED', 'PENDING') DEFAULT 'PENDING',
    booked_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES `User`(user_id),
    FOREIGN KEY (show_id) REFERENCES `Show`(show_id)
);

-- 9. Seat
CREATE TABLE Seat (
    seat_id     INT AUTO_INCREMENT PRIMARY KEY,
    screen_id   INT NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    seat_type   ENUM('RECLINER', 'PREMIUM', 'EXECUTIVE', 'NORMAL') DEFAULT 'NORMAL',
    FOREIGN KEY (screen_id) REFERENCES Screen(screen_id),
    UNIQUE KEY uk_screen_seat (screen_id, seat_number)
);

-- 10. BookingSeat (junction table)
CREATE TABLE BookingSeat (
    booking_seat_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id      INT NOT NULL,
    seat_id         INT NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (seat_id) REFERENCES Seat(seat_id),
    UNIQUE KEY uk_booking_seat (booking_id, seat_id)
);
