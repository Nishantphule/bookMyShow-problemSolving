-- test data - PVR Nexus, Mumbai (25 Apr 2023)

USE bookmyshow;

-- City
INSERT INTO City (city_name) VALUES ('Mumbai');

-- Theatre
INSERT INTO Theatre (name, address, city_id)
VALUES (
    'PVR: Nexus (Forum Mall)',
    'Forum Mall, Elgin Road, Bhulabhai Desai Road, Mumbai - 400026',
    1
);

-- Screens
INSERT INTO Screen (theatre_id, screen_name, total_seats, screen_format) VALUES
(1, 'Screen 1', 200, '2D'),
(1, 'Screen 2', 180, '3D');

-- Languages
INSERT INTO Language (language_name) VALUES
('Hindi'),
('Telugu'),
('English');

-- Movies
INSERT INTO Movie (title, language_id, format, duration_minutes, genre, rating, release_date) VALUES
('Dasara', 2, '2D', 156, 'Action/Drama', 'UA', '2023-03-30'),
('Kisi Ka Bhai Kisi Ki Jaan', 1, '2D', 144, 'Action/Comedy', 'UA', '2023-04-21'),
('Tu Jhoothi Main Makkaar', 1, '2D', 164, 'Romance/Comedy', 'UA', '2023-03-08'),
('Avatar: The Way of Water', 3, '3D', 192, 'Sci-Fi/Adventure', 'UA', '2022-12-16');

-- Shows on 2023-04-25 at PVR Nexus
INSERT INTO `Show` (movie_id, screen_id, show_date, show_time, available_seats, price) VALUES
-- Dasara: 12:15 PM
(1, 1, '2023-04-25', '12:15:00', 185, 250.00),
-- Kisi Ka Bhai: 01:00 PM, 04:10 PM, 06:20 PM, 07:00 PM
(2, 1, '2023-04-25', '13:00:00', 190, 280.00),
(2, 1, '2023-04-25', '16:10:00', 175, 280.00),
(2, 1, '2023-04-25', '18:20:00', 160, 320.00),
(2, 1, '2023-04-25', '19:00:00', 155, 320.00),
-- Tu Jhoothi Main Makkaar: 01:15 PM
(3, 1, '2023-04-25', '13:15:00', 192, 260.00),
-- Avatar: 01:20 PM (3D screen)
(4, 2, '2023-04-25', '13:20:00', 170, 350.00);

-- Sample seats for Screen 1
INSERT INTO Seat (screen_id, seat_number, seat_type) VALUES
(1, 'A1', 'PREMIUM'),
(1, 'A2', 'PREMIUM'),
(1, 'B1', 'NORMAL'),
(1, 'B2', 'NORMAL'),
(1, 'C1', 'RECLINER');

-- Sample seats for Screen 2
INSERT INTO Seat (screen_id, seat_number, seat_type) VALUES
(2, 'A1', 'PREMIUM'),
(2, 'A2', 'PREMIUM'),
(2, 'B1', 'NORMAL');

-- Sample users
INSERT INTO `User` (full_name, email, phone) VALUES
('Rahul Sharma', 'rahul.sharma@email.com', '9876543210'),
('Priya Patel', 'priya.patel@email.com', '9876543211'),
('Amit Kumar', 'amit.kumar@email.com', '9876543212');

-- Sample bookings
INSERT INTO Booking (user_id, show_id, num_seats, total_amount, booking_status) VALUES
(1, 1, 2, 500.00, 'CONFIRMED'),   -- Rahul books Dasara 12:15 PM
(2, 2, 3, 840.00, 'CONFIRMED'),   -- Priya books Kisi Ka Bhai 01:00 PM
(3, 7, 2, 700.00, 'CONFIRMED');   -- Amit books Avatar 01:20 PM

-- BookingSeat assignments
INSERT INTO BookingSeat (booking_id, seat_id) VALUES
(1, 1), (1, 2),   -- Rahul: A1, A2 on Screen 1
(2, 3), (2, 4), (2, 5),  -- Priya: B1, B2, C1 on Screen 1
(3, 6), (3, 7);   -- Amit: A1, A2 on Screen 2
