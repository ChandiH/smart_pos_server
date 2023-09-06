INSERT INTO user_role (role_ID,role_name, role_desc)
VALUES
    (1,'Owner', 'Responsible for overall management and ownership of the supermarket.'),
    (2,'Finance Manager', 'Responsible for financial reporting and analysis.'),
    (3,'Branch Manager', 'Manages the day-to-day operations of a specific branch.'),
    (4,'Cashier', 'Handles customer transactions at the checkout counter.');

INSERT INTO access_type (access_type_ID,access_name)
VALUES
    (1,'Sales Access'),
    (2,'Inventory Access'),
    (3,'Employee Access'),
    (4,'Customer Access'),
    (5,'Reports Access'),
    (6,'Product Pricing Access'),
    (7,'Customer Database Access'),
    (8,'Promotions and Discounts Access'),
    (9,'Add Product Access'),
    (10,'Edit Product Access'),
    (11,'Delete Product Access'),
    (12,'View Product Access'),
    (13,'Add Customer Access'),
    (14,'Edit Customer Access'),
    (15,'Delete Customer Access'),
    (16,'View Customer Access'),
    (17,'Add Employee Access'),
    (18,'Edit Employee Access'),
    (19,'Delete Employee Access'),
    (20,'View Employee Access');

INSERT INTO user_access (user_access_ID,role_ID, access_type_ID)
VALUES
(1, 1, 1),   -- Role 1 has Access Type 1
(2, 1, 2),   -- Role 1 has Access Type 2
(3, 1, 3),   -- Role 1 has Access Type 3
(4, 1, 4),   -- Role 1 has Access Type 4
(5, 1, 5),   -- Role 1 has Access Type 5
(6, 1, 6),   -- Role 1 has Access Type 6
(7, 1, 7),   -- Role 1 has Access Type 7
(8, 1, 8),   -- Role 1 has Access Type 8
(9, 1, 9),   -- Role 1 has Access Type 9
(10, 1, 10), -- Role 1 has Access Type 10
(11, 1, 11), -- Role 1 has Access Type 11
(12, 1, 12), -- Role 1 has Access Type 12
(13, 1, 13), -- Role 1 has Access Type 13
(14, 1, 14), -- Role 1 has Access Type 14
(15, 1, 15), -- Role 1 has Access Type 15
(16, 1, 16), -- Role 1 has Access Type 16
(17, 1, 17), -- Role 1 has Access Type 17
(18, 1, 18), -- Role 1 has Access Type 18
(19, 2, 1),  -- Role 2 has Access Type 1
(20, 2, 3),  -- Role 2 has Access Type 3
(21, 2, 5),  -- Role 2 has Access Type 5
(22, 2, 7),  -- Role 2 has Access Type 7
(23, 2, 9),  -- Role 2 has Access Type 9
(24, 2, 11), -- Role 2 has Access Type 11
(25, 2, 13), -- Role 2 has Access Type 13
(26, 2, 15), -- Role 2 has Access Type 15
(27, 2, 17), -- Role 2 has Access Type 17
(28, 3, 2),  -- Role 3 has Access Type 2
(29, 3, 4),  -- Role 3 has Access Type 4
(30, 3, 6),  -- Role 3 has Access Type 6
(31, 3, 8),  -- Role 3 has Access Type 8
(32, 3, 10), -- Role 3 has Access Type 10
(33, 3, 12), -- Role 3 has Access Type 12
(34, 3, 14), -- Role 3 has Access Type 14
(35, 3, 16), -- Role 3 has Access Type 16
(36, 4, 1),  -- Role 4 has Access Type 1
(37, 4, 4),  -- Role 4 has Access Type 4
(38, 4, 7),  -- Role 4 has Access Type 7
(39, 4, 10), -- Role 4 has Access Type 10
(40, 4, 13), -- Role 4 has Access Type 13
(41, 4, 16); -- Role 4 has Access Type 16


INSERT INTO category (category_ID,name)
VALUES
    (1, 'Fruits'),
(2, 'Vegetables'),
(3, 'Dairy'),
(4, 'Meat'),
(5, 'Bakery'),
(6, 'Beverages'),
(7, 'Snacks'),
(8, 'Cleaning Supplies'),
(9, 'Frozen Foods'),
(10, 'Canned Goods'),
(11, 'Health and Beauty'),
(12, 'Household Essentials'),
(13, 'Pet Supplies'),
(14, 'Office Supplies'),
(15, 'Electronics'),
(16, 'Clothing'),
(17, 'Footwear'),
(18, 'Home Decor'),
(19, 'Books and Magazines'),
(20, 'Toys and Games'),
(21, 'Sporting Goods'),
(22, 'Automotive'),
(23, 'Jewelry and Accessories'),
(24, 'Stationery'),
(25, 'Art and Craft Supplies');


INSERT INTO units_of_measure (uom_ID,uom_name, abbreviations)
VALUES
(1, 'Kilogram', 'kg'),
    (2, 'Gram', 'g'),
    (3, 'Liter', 'L'),
    (4, 'Milliliter', 'mL'),
    (5, 'Pound', 'lb'),
    (6, 'Ounce', 'oz'),
    (7, 'Dozen', 'doz'),
    (8, 'Each', 'ea'),
    (9, 'Gallon', 'gal'),
    (10, 'Quart', 'qt'),
    (11, 'Pint', 'pt'),
    (12, 'Piece', 'pc'),
    (13, 'Pack', 'pk'),
    (14, 'Can', 'can'),
    (15, 'Bag', 'bag'),
    (16, 'Meter', 'm'),
    (17, 'Centimeter', 'cm'),
    (18, 'Millimeter', 'mm'),
    (19, 'Foot', 'ft'),
    (20, 'Inch', 'in'),
    (21, 'Bottle', 'bottle');

INSERT INTO payment_method (ID,name)
VALUES 
    (1,'Cash'),
    (2,'Credit Card'),
    (3,'Debit Card'),
    (4,'Mobile Money'),
    (5,'Gift Card'),
    (6,'Voucher');

INSERT INTO discounts_and_promotions (ID,name, description, discount_percentage)
VALUES
    (1,'Summer Sale', 'Get discounts on various summer products', 15.00),
    (2,'Back to School', 'Special discounts on school supplies', 10.50),
    (3,'Holiday Season', 'Festive discounts for holiday shoppers', 20.00),
    (4,'Weekend Special', 'Limited-time weekend discounts', 12.75),
    (5,'New Year Clearance', 'Clearance sale for old inventory', 30.25),
    (6,'Valentine''s Day', 'Discounts on gifts for your loved ones', 14.00),
    (7,'Spring Cleaning', 'Save on cleaning supplies', 18.50),
    (8,'Easter Sale', 'Special offers for Easter weekend', 10.00),
    (9,'Black Friday', 'Biggest discounts of the year on Black Friday', 35.00),
    (10,'Cyber Monday', 'Online-only deals for Cyber Monday', 25.50);

INSERT INTO branch (ID,city, address, phone, email)
VALUES
    (1, 'Colombo', '123 Main St, Colombo 01', '112233445', 'colombobranch@example.com'),
    (2, 'Kandy', '456 Elm St, Kandy 20000', '814325678', 'kandybranch@example.com'),
    (3, 'Galle', '789 Oak St, Galle 80000', '912345678', 'gallebranch@example.com'),
    (4, 'Jaffna', '101 Pine St, Jaffna 40000', '771234567', 'jaffnabranch@example.com'),
    (5, 'Negombo', '543 Cedar St, Negombo 11500', '312345678', 'negombobranch@example.com'),
    (6, 'Matara', '876 Birch St, Matara 81000', '414325678', 'matarabranch@example.com'),
    (7, 'Kurunegala', '654 Maple St, Kurunegala 60000', '372345678', 'kurunegalabranch@example.com'),
    (8, 'Anuradhapura', '789 Pine St, Anuradhapura 50000', '762345678', 'anuradhapurabranch@example.com'),
    (9, 'Polonnaruwa', '234 Walnut St, Polonnaruwa 51000', '562345678', 'polonnaruwabranch@example.com'),
    (10, 'Trincomalee', '987 Cedar St, Trincomalee 31000', '762345678', 'trincomaleebranch@example.com'),
    (11, 'Batticaloa', '567 Birch St, Batticaloa 30000', '573245678', 'batticaloabranch@example.com'),
    (12, 'Nuwara Eliya', '876 Oak St, Nuwara Eliya 22200', '526345678', 'nuwaraeliyabranch@example.com'),
    (13, 'Badulla', '321 Elm St, Badulla 90000', '777865678', 'badullabranch@example.com'),
    (14, 'Hambantota', '123 Pine St, Hambantota 82000', '778765678', 'hambantotabranch@example.com'),
	(15, 'Kalutara', '123 Pine St, Kalutara 82000', '778745678', 'kalutarabranch@example.com')
    ;


INSERT INTO gift_cards (card_number, card_value, expired_date)
VALUES
    ('GC001', 1000.00, '2022-12-31'),
    ('GC002', 500.00, '2022-11-30'),
    ('GC003', 2000.00, '2023-02-28'),
    ('GC004', 5000.00, '2023-04-30'),
    ('GC005', 1000.00, '2022-10-31'),
    ('GC006', 500.00, '2022-09-30'),
    ('GC007', 2000.00, '2023-01-31'),
    ('GC008', 5000.00, '2023-03-31'),
    ('GC009', 1000.00, '2022-08-31'),
    ('GC010', 500.00, '2022-07-31'),
    ('GC011', 2000.00, '2023-01-15'),
    ('GC012', 5000.00, '2023-04-15'),
    ('GC013', 1000.00, '2022-09-15'),
    ('GC014', 500.00, '2022-08-15'),
    ('GC015', 2000.00, '2023-02-15'),
    ('GC016', 5000.00, '2023-03-15'),
    ('GC017', 1000.00, '2022-10-15'),
    ('GC018', 500.00, '2022-11-15'),
    ('GC019', 2000.00, '2023-01-01'),
    ('GC020', 5000.00, '2023-04-01');


INSERT INTO supplier (supplier_ID,name, email, phone, address)
VALUES
    (1, 'Sri Lanka Spice Exporters', 'sales@slspices.lk', '666765678', '345 Cinnamon St, Colombo 02'),
    (2, 'Gem Paradise', 'info@gemparadise.lk', '911234567', '789 Ruby St, Ratnapura 70000'),
    (3, 'Ceylon Timber Industries', 'info@ctimber.lk', '444555666', '567 Timber St, Baduraliya 80200'),
    (4, 'Lanka Cocoa Exporters', 'sales@cocoaexports.lk', '333444555', '432 Cocoa St, Matale 80050'),
    (5, 'Exotic Ceylon Tea', 'info@exotictea.lk', '888999000', '876 Tea Gardens, Nuwara Eliya 22250'),
    (6, 'Tropical Woodworks', 'sales@woodworks.lk', '777999888', '654 Timber St, Kalutara 12000'),
    (7, 'Sri Lankan Textiles', 'info@sltextiles.lk', '123987654', '321 Fabric St, Negombo 11550'),
    (8, 'Ceylon Gems & Jewelry', 'sales@ceylongems.lk', '567123456', '543 Gem St, Ratnapura 70050'),
    (9, 'Ocean Fresh Seafoods', 'info@oceanfresh.lk', '890123456', '456 Seafood St, Negombo 11560'),
    (10, 'Ceylon Electronics', 'sales@electronics.lk', '123890123', '789 Circuit St, Colombo 03'),
    (11, 'Lanka Pharmaceuticals', 'info@lankapharma.lk', '333555777', '987 Medicine St, Colombo 04'),
    (12, 'Sri Lankan Ceramics', 'sales@slceramics.lk', '789555789', '876 Pottery St, Colombo 05'),
    (13, 'Exotic Sri Lankan Spices', 'info@slspices.lk', '345678345', '567 Spice St, Colombo 06'),
    (14, 'Ceylon Auto Parts', 'sales@autoparts.lk', '890678678', '432 Auto St, Colombo 07'),
    (15, 'Island Craftsmen', 'info@islandcrafts.lk', '567890567', '543 Craft St, Colombo 08'),
    (16, 'Lanka Agricultural Supplies', 'sales@agrisupplies.lk', '123567890', '321 Agri St, Colombo 09'),
    (17, 'Sri Lanka Hardware', 'info@slhardware.lk', '456789123', '987 Hardware St, Galle 80010'),
    (18, 'Ceylon Fashion House', 'sales@fashionhouse.lk', '890123789', '345 Fashion St, Colombo 10'),
    (19, 'Lanka Auto Repairs', 'info@autorepairs.lk', '123456789', '654 Repair St, Kandy 70020'),
    (20, 'Sri Lankan Stationers', 'sales@slstationers.lk', '567890123', '432 Stationery St, Colombo 11')

;


INSERT INTO employee (employee_ID,name, username, password, role_id, hired_date, email, phone, branch_id)
VALUES
    (1, 'John Doe', 'johndoe', 'hashed_password', 3, '2022-05-15', 'johndoe@example.com', '112233445', 1),
    (2, 'Jane Smith', 'janesmith', 'hashed_password', 2, '2021-12-10', 'janesmith@example.com', '998877665', 2),
    (3, 'Robert Johnson', 'robertjohnson', 'hashed_password', 2, '2023-02-28', 'robertjohnson@example.com', '777766655', 3),
    (4, 'Mary Wilson', 'marywilson', 'hashed_password', 2, '2022-09-30', 'marywilson@example.com', '333444555', 4),
    (5, 'Michael Lee', 'michaellee', 'hashed_password', 1, '2020-07-05', 'michaellee@example.com', '222555444', 5),
    (6, 'Lisa Garcia', 'lisagarcia', 'hashed_password', 4, '2021-10-20', 'lisagarcia@example.com', '666555444', 6),
    (7, 'David Martinez', 'davidmartinez', 'hashed_password', 2, '2022-04-15', 'davidmartinez@example.com', '777444555', 7),
    (8, 'Sarah Brown', 'sarahbrown', 'hashed_password', 4, '2021-03-25', 'sarahbrown@example.com', '555444333', 8),
    (9, 'William Smith', 'williamsmith', 'hashed_password', 4, '2022-01-05', 'williamsmith@example.com', '777888999', 9),
    (10, 'Karen Davis', 'karendavis', 'hashed_password', 4, '2023-06-30', 'karendavis@example.com', '444555666', 10),
    (11, 'James Taylor', 'jamestaylor', 'hashed_password', 2, '2022-08-15', 'jamestaylor@example.com', '555777888', 11),
    (12, 'Jennifer Clark', 'jenniferclark', 'hashed_password', 4, '2021-11-10', 'jenniferclark@example.com', '999888777', 12),
    (13, 'Joseph Johnson', 'josephjohnson', 'hashed_password', 4, '2023-01-15', 'josephjohnson@example.com', '555666777', 13),
    (14, 'Nancy Moore', 'nancymoore', 'hashed_password', 4, '2021-04-20', 'nancymoore@example.com', '444666555', 14),
    (15, 'Robert White', 'robertwhite', 'hashed_password', 4, '2020-11-05', 'robertwhite@example.com', '333777666', 10),
    (16, 'Linda Harris', 'lindaharris', 'hashed_password', 2, '2022-02-28', 'lindaharris@example.com', '222777888', 1),
    (17, 'John Miller', 'johnmiller', 'hashed_password', 4, '2023-03-10', 'johnmiller@example.com', '444555444', 2),
    (18, 'Patricia Garcia', 'patriciagarcia', 'hashed_password', 2, '2022-07-01', 'patriciagarcia@example.com', '777555444', 3),
    (19, 'Robert Brown', 'robertbrown', 'hashed_password', 2, '2020-12-25', 'robertbrown@example.com', '666444555', 4),
    (20, 'Susan Lee', 'susanlee', 'hashed_password', 2, '2022-10-15', 'susanlee@example.com', '555444555', 5),
    (21, 'Charles Johnson', 'charlesjohnson', 'hashed_password', 2, '2023-04-05', 'charlesjohnson@example.com', '555666444', 6),
    (22, 'Karen Davis', 'karendavis', 'hashed_password', 2, '2021-05-20', 'karendavis@example.com', '555444333', 7),
    (23, 'Daniel Taylor', 'danieltaylor', 'hashed_password', 2, '2022-11-10', 'danieltaylor@example.com', '555444666', 8),
    (24, 'Linda Anderson', 'lindaanderson', 'hashed_password', 2, '2022-06-15', 'lindaanderson@example.com', '555777999', 9),
    (25, 'James Smith', 'jamessmith', 'hashed_password', 4, '2021-08-30', 'jamessmith@example.com', '666777999', 10),
    (26, 'Elizabeth Wilson', 'elizabethwilson', 'hashed_password', 2, '2022-03-10', 'elizabethwilson@example.com', '555777888', 11),
    (27, 'Michael Brown', 'michaelbrown', 'hashed_password', 4, '2022-02-01', 'michaelbrown@example.com', '777666555', 12),
    (28, 'Patricia Clark', 'patriciaclark', 'hashed_password', 4, '2021-07-15', 'patriciaclark@example.com', '444777888', 13),
    (29, 'Richard White', 'richardwhite', 'hashed_password', 4, '2023-05-20', 'richardwhite@example.com', '555666777', 14),
    (30, 'Karen Thomas', 'karenthomas', 'hashed_password', 4, '2022-09-01', 'karenthomas@example.com', '333777999', 6),
    (31, 'David Hall', 'davidhall', 'hashed_password', 2, '2022-01-25', 'davidhall@example.com', '222777666', 1),
    (32, 'Susan Young', 'susanyoung', 'hashed_password', 4, '2021-02-15', 'susanyoung@example.com', '555444777', 2),
    (33, 'Michael Hernandez', 'michaelhernandez', 'hashed_password', 4, '2021-12-01', 'michaelhernandez@example.com', '777555666', 3),
    (34, 'Sarah Davis', 'sarahdavis', 'hashed_password', 4, '2022-03-05', 'sarahdavis@example.com', '444555777', 4),
    (35, 'James Williams', 'jameswilliams', 'hashed_password', 4, '2023-04-10', 'jameswilliams@example.com', '555444777', 5),
    (36, 'Linda Smith', 'lindasmith', 'hashed_password', 2, '2022-08-20', 'lindasmith@example.com', '555555555', 6),
    (37, 'Richard Johnson', 'richardjohnson', 'hashed_password', 4, '2021-06-30', 'richardjohnson@example.com', '555555555', 7),
    (38, 'Nancy Taylor', 'nancytaylor', 'hashed_password', 4, '2023-01-05', 'nancytaylor@example.com', '555555555', 8),
    (39, 'William Harris', 'williamharris', 'hashed_password', 4, '2022-07-20', 'williamharris@example.com', '555555555', 9),
    (40, 'Elizabeth Davis', 'elizabethdavis', 'hashed_password', 4, '2022-05-15', 'elizabethdavis@example.com', '555555555', 10),
    (41, 'David Taylor', 'davidtaylor', 'hashed_password', 4, '2022-11-30', 'davidtaylor@example.com', '555555555', 11),
    (42, 'Mary Anderson', 'maryanderson', 'hashed_password', 4, '2022-06-10', 'maryanderson@example.com', '555555555', 12),
    (43, 'Richard Smith', 'richardsmith', 'hashed_password', 4, '2021-09-15', 'richardsmith@example.com', '555555555', 13),
    (44, 'Jennifer Anderson', 'jenniferanderson', 'hashed_password', 4, '2022-01-10', 'jenniferanderson@example.com', '555555555', 14),
    (45, 'Christopher Davis', 'christopherdavis', 'hashed_password', 4, '2023-03-20', 'christopherdavis@example.com', '555555555', 4)
    ;

INSERT INTO product (product_ID,product_name, products_desc, category_ID, product_image, measure_of_unit_id, buying_ppu, retail_ppu, supplier_ID, barcode, quantity, created_on, updated_on)
VALUES
    (1, 'Munchee Cream Cracker 100g', 'Delicious cream cracker biscuits from Munchee. Ideal for snacking.', 5, 'https://example.com/munchee-cream-cracker.jpg', 15, 50.00, 70.00, 1, '1234567890123', 500, '2022-03-10', '2023-07-05'),
    (2, 'Ceylon Tea Leaves 250g', 'Premium Ceylon tea leaves for a perfect cup of tea. Made by Ceylon Tea Company.', 6, 'https://example.com/ceylon-tea.jpg', 15, 200.00, 250.00, 2, '9876543210987', 300, '2022-04-20', '2023-07-10'),
    (3, 'Samba Rice 5kg', 'High-quality Samba rice for traditional Sri Lankan dishes. Rice King brand.', 6, 'https://example.com/rice.jpg', 15, 350.00, 400.00, 3, '2345678901234', 200, '2022-05-15', '2023-08-01'),
    (4, 'CocoLife Coconut Oil 1L', 'Pure coconut oil for cooking and skincare. CocoLife brand.', 7, 'https://example.com/coconut-oil.jpg', 15, 300.00, 400.00, 4, '3456789012345', 100, '2022-06-10', '2023-09-05'),
    (5, 'Lucky Canned Fish 400g', 'Canned fish in brine, a convenient source of protein. Lucky brand.', 8, 'https://example.com/canned-fish.jpg', 15, 150.00, 180.00, 5, '4567890123456', 400, '2022-07-05', '2023-07-15'),
    (6, 'Sunsilk Shampoo 250ml', 'Gentle shampoo for clean and healthy hair. Sunsilk brand.', 9, 'https://example.com/shampoo.jpg', 15, 150.00, 200.00, 6, '5678901234567', 250, '2022-08-20', '2023-08-25'),
    (7, 'Nescafe Instant Coffee 100g', 'Instant coffee for a quick caffeine boost. Nescafe brand.', 6, 'https://example.com/nescafe-coffee.jpg', 15, 180.00, 220.00, 7, '6789012345678', 300, '2022-09-15', '2023-09-10'),
    (8, 'Lipton Yellow Label Tea 100 bags', 'Lipton Yellow Label tea bags for a refreshing brew. Lipton brand.', 6, 'https://example.com/lipton-tea.jpg', 15, 150.00, 180.00, 8, '7890123456789', 500, '2022-10-20', '2023-07-01'),
    (9, 'Maggi Instant Noodles 75g', 'Quick and tasty Maggi instant noodles. Maggi brand.', 7, 'https://example.com/maggi-noodles.jpg', 15, 30.00, 40.00, 9, '8901234567890', 1000, '2022-11-25', '2023-08-20'),
    (10, 'Colgate Toothpaste 150g', 'Colgate toothpaste for healthy teeth. Colgate brand.', 10, 'https://example.com/colgate-toothpaste.jpg', 14, 120.00, 150.00, 10, '9012345678901', 400, '2022-12-10', '2023-09-01'),
    (11, 'Dettol Liquid Hand Wash 250ml', 'Dettol liquid hand wash for germ protection. Dettol brand.', 10, 'https://example.com/dettol-hand-wash.jpg', 14, 50.00, 60.00, 11, '0123456789012', 300, '2023-01-15', '2023-07-10'),
    (12, 'Sunlight Dishwashing Liquid 500ml', 'Sunlight dishwashing liquid for clean dishes. Sunlight brand.', 7, 'https://example.com/sunlight-dishwash.jpg', 14, 80.00, 100.00, 12, '1234567890123', 250, '2023-02-20', '2023-08-15'),
    (13, 'Palmolive Shower Gel 250ml', 'Palmolive shower gel for a refreshing shower. Palmolive brand.', 10, 'https://example.com/palmolive-shower-gel.jpg', 14, 60.00, 80.00, 13, '2345678901234', 300, '2023-03-10', '2023-09-20'),
    (14, 'Whisper Ultra Thin Sanitary Pads 10s', 'Whisper Ultra Thin sanitary pads for comfortable protection. Whisper brand.', 11, 'https://example.com/whisper-sanitary-pads.jpg', 14, 100.00, 120.00, 14, '3456789012345', 600, '2023-04-15', '2023-08-25'),
    (15, 'Kotex Maxi Pads 16s', 'Kotex Maxi pads for reliable menstrual protection. Kotex brand.', 11, 'https://example.com/kotex-maxi-pads.jpg', 14, 80.00, 100.00, 15, '4567890123456', 500, '2023-05-20', '2023-07-05'),
    (16, 'Ariel Laundry Detergent 2kg', 'Ariel laundry detergent for clean and fresh clothes. Ariel brand.', 12, 'https://example.com/ariel-detergent.jpg', 14, 250.00, 300.00, 16, '5678901234567', 200, '2023-06-25', '2023-09-10'),
    (17, 'Pears Baby Soap', 'Gentle and mild baby soap from Pears. Suitable for delicate skin.', 11, 'https://example.com/pears-baby-soap.jpg', 13, 75.00, 100.00, 1, '1234567890124', 500,  '2023-07-30', '2023-08-15'),
    (18, 'Duracell AA Batteries 4-pack', 'Duracell AA batteries for long-lasting power. Duracell brand.', 13, 'https://example.com/duracell-batteries.jpg', 13, 80.00, 100.00, 18, '7890123456789', 800, '2023-08-05', '2023-08-20'),
    (19, 'Sony Earphones', 'High-quality Sony earphones for music lovers. Sony brand.', 14, 'https://example.com/sony-earphones.jpg', 12, 350.00, 400.00, 19, '8901234567890', 200, '2023-09-10', '2023-09-25'),
    (20, 'Nike Running Shoes', 'Nike running shoes for active lifestyles. Nike brand.', 15, 'https://example.com/nike-running-shoes.jpg', 17, 500.00, 600.00, 20, '9012345678901', 150, '2023-09-25', '2023-09-30'),
    (21, 'IKEA Table Lamp', 'IKEA table lamp for stylish illumination. IKEA brand.', 16, 'https://example.com/ikea-table-lamp.jpg', 17, 120.00, 150.00, 1, '0123456789012', 100, '2023-10-05', '2023-10-10'),
    (22, 'Harry Potter and the Sorcerer''s Stone', 'A classic novel by J.K. Rowling. Genre: Fantasy. Author: J.K. Rowling.', 19, 'https://example.com/harry-potter-book.jpg', 20, 20.00, 25.00, 2, '1234567890123', 50, '2023-10-15', '2023-10-20'),
    (23, 'Lego Star Wars Millennium Falcon', 'Build the iconic Millennium Falcon with LEGO. Theme: Star Wars. Brand: LEGO.', 19, 'https://example.com/lego-millennium-falcon.jpg', 20, 300.00, 350.00, 3, '2345678901234', 30, '2023-10-25', '2023-10-30'),
    (24, 'Wilson Tennis Racket', 'Wilson tennis racket for tennis enthusiasts. Brand: Wilson. Sport: Tennis.', 20, 'https://example.com/wilson-tennis-racket.jpg', 1, 100.00, 120.00, 4, '3456789012345', 20, '2023-11-05', '2023-11-10'),
    (25, 'Castrol Engine Oil 1L', 'Castrol engine oil for smooth performance. Castrol brand. Vehicle: Car.', 21, 'https://example.com/castrol-engine-oil.jpg', 20, 80.00, 100.00, 5, '4567890123456', 40, '2023-11-15', '2023-11-20'),
    (26, 'Gold Necklace', 'Elegant gold necklace for special occasions. Jewelry Type: Necklace. Material: Gold.', 22, 'https://example.com/gold-necklace.jpg', 2, 1000.00, 1200.00, 6, '5678901234567', 10, '2023-11-25', '2023-11-30'),
    (27, 'Staedtler Colored Pencils 24-pack', 'Staedtler colored pencils for creative art projects. Brand: Staedtler. Quantity: 24.', 24, 'https://example.com/staedtler-colored-pencils.jpg', 3, 50.00, 60.00, 7, '6789012345678', 100, '2023-12-05', '2023-12-10'),
    (28, 'Acrylic Paint Set 12 Colors', 'Acrylic paint set for painting enthusiasts. Quantity: 12 colors.', 24, 'https://example.com/acrylic-paint-set.jpg', 3, 40.00, 50.00, 8, '7890123456789', 80, '2023-12-15', '2023-12-20'),
    (29, 'Ford Mustang Model Car Kit', 'Build your own Ford Mustang model car kit. Brand: Ford. Scale: 1:24.', 25, 'https://example.com/ford-mustang-model-kit.jpg', 4, 60.00, 80.00, 10, '8901234567890', 15, '2023-12-25', '2023-12-30'),
    (30, 'Yamaha Acoustic Guitar', 'Yamaha acoustic guitar for musicians. Brand: Yamaha. Type: Acoustic.', 25, 'https://example.com/yamaha-acoustic-guitar.jpg', 4, 200.00, 250.00, 1, '9012345678901', 10, '2024-01-05', '2024-01-10'),
    (31, 'Adidas Sports Shoes', 'Adidas sports shoes for active lifestyles. Brand: Adidas. Sport: Running.', 6, 'https://example.com/adidas-sports-shoes.jpg', 7, 400.00, 500.00, 2, '0123456789012', 25, '2024-01-15', '2024-01-20'),
    (32, 'Samsung 55-inch 4K Smart TV', 'Samsung 55-inch 4K Smart TV for immersive entertainment. Brand: Samsung. Screen Size: 55 inches.', 8, 'https://example.com/samsung-4k-smart-tv.jpg', 5, 900.00, 1100.00, 13, '1234567890123', 5, '2024-01-25', '2024-01-30'),
    (33, 'Levi''s Denim Jeans', 'Levi''s denim jeans for classic style. Brand: Levi''s. Type: Jeans.', 9, 'https://example.com/levis-jeans.jpg', 5, 150.00, 180.00, 14, '2345678901234', 20, '2024-02-05', '2024-02-10'),
    (34, 'Home Decor Wall Clock', 'Elegant wall clock for home decor. Type: Wall Clock. Style: Elegant.', 7, 'https://example.com/home-decor-wall-clock.jpg', 6, 40.00, 50.00, 15, '3456789012345', 30, '2024-02-15', '2024-02-20'),
    (35, 'Cooking for Dummies Book', 'Cooking for Dummies book for aspiring chefs. Genre: Cooking. Author: John Doe.', 19, 'https://example.com/cooking-for-dummies-book.jpg', 8, 15.00, 20.00, 16, '4567890123456', 50, '2024-02-25', '2024-02-28'),
    (36, 'LEGO Creator Expert Roller Coaster', 'Build the LEGO Creator Expert Roller Coaster for fun and excitement. Theme: Amusement Park. Brand: LEGO.', 19, 'https://example.com/lego-roller-coaster.jpg', 2, 400.00, 500.00, 17, '5678901234567', 10, '2024-03-05', '2024-03-10'),
    (37, 'Wilson Tennis Balls 3-pack', 'Wilson tennis balls for tennis practice and matches. Brand: Wilson. Quantity: 3.', 20, 'https://example.com/wilson-tennis-balls.jpg', 9, 20.00, 25.00, 18, '6789012345678', 100, '2024-03-15', '2024-03-20'),
    (38, 'Castrol Motorcycle Oil 1L', 'Castrol motorcycle oil for smooth engine performance. Castrol brand. Vehicle: Motorcycle.', 21, 'https://example.com/castrol-motorcycle-oil.jpg', 4, 60.00, 80.00, 19, '7890123456789', 30, '2024-03-25', '2024-03-30'),
    (39, 'Gold Earrings', 'Elegant gold earrings for special occasions. Jewelry Type: Earrings. Material: Gold.', 22, 'https://example.com/gold-earrings.jpg', 1, 800.00, 1000.00, 20, '8901234567890', 5, '2024-04-05', '2024-04-10'),
    (40, 'Faber-Castell Watercolor Paint Set 12 Colors', 'Faber-Castell watercolor paint set for creative artists. Brand: Faber-Castell. Quantity: 12 colors.', 24, 'https://example.com/faber-castell-watercolor-paint.jpg', 13, 30.00, 40.00, 15, '9012345678901', 50, '2024-04-15', '2024-04-20'),
    (41, 'Electric Guitar Kit', 'Electric guitar kit for budding musicians. Includes guitar, amp, and accessories.', 25, 'https://example.com/electric-guitar-kit.jpg', 14, 250.00, 300.00, 12, '0123456789012', 10, '2024-04-25', '2024-04-30'),
    (42, 'Nike Basketball Shoes', 'Nike basketball shoes for basketball enthusiasts. Brand: Nike. Sport: Basketball.', 6, 'https://example.com/nike-basketball-shoes.jpg', 17, 350.00, 400.00, 13, '1234567890123', 15, '2024-05-05', '2024-05-10'),
    (43, 'Sony 65-inch 4K Smart TV', 'Sony 65-inch 4K Smart TV for cinematic viewing. Brand: Sony. Screen Size: 65 inches.', 8, 'https://example.com/sony-65-inch-4k-tv.jpg', 15, 1200.00, 1500.00, 14, '2345678901234', 5, '2024-05-15', '2024-05-20'),
    (44, 'Wrangler Denim Jeans', 'Wrangler denim jeans for rugged style. Brand: Wrangler. Type: Jeans.', 9, 'https://example.com/wrangler-jeans.jpg', 15, 180.00, 220.00, 15, '3456789012345', 20, '2024-05-25', '2024-05-30'),
    (45, 'Modern Wall Art', 'Modern wall art for contemporary home decor. Type: Wall Art. Style: Modern.', 7, 'https://example.com/modern-wall-art.jpg', 16, 60.00, 80.00, 16, '4567890123456', 10, '2024-06-05', '2024-06-10'),
    (46, 'The Great Gatsby Book', 'The Great Gatsby book for classic literature enthusiasts. Genre: Literature. Author: F. Scott Fitzgerald.', 19, 'https://example.com/great-gatsby-book.jpg', 18, 10.00, 15.00, 17, '5678901234567', 30, '2024-06-15', '2024-06-20'),
    (47, 'LEGO Technic Porsche 911 GT3 RS', 'Build the LEGO Technic Porsche 911 GT3 RS for a thrilling experience. Theme: Sports Car. Brand: LEGO.', 19, 'https://example.com/lego-porsche-911.jpg', 12, 600.00, 700.00, 18, '6789012345678', 5, '2024-06-25', '2024-06-30'),
    (48, 'Wilson Golf Balls 12-pack', 'Wilson golf balls for golf practice and games. Brand: Wilson. Quantity: 12.', 20, 'https://example.com/wilson-golf-balls.jpg', 12, 25.00, 30.00, 19, '7890123456789', 100, '2024-07-05', '2024-07-10'),
    (49, 'Shell Engine Oil 4L', 'Shell engine oil for optimal engine performance. Shell brand. Vehicle: Car.', 21, 'https://example.com/shell-engine-oil.jpg', 10, 100.00, 120.00, 20, '8901234567890', 20, '2024-07-15', '2024-07-20'),
    (50, 'Sapphire Ring', 'Elegant sapphire ring for special occasions. Jewelry Type: Ring. Material: Sapphire.', 22, 'https://example.com/sapphire-ring.jpg', 8, 600.00, 700.00, 1, '9012345678901', 5, '2024-07-25', '2024-07-30'),
    (51, 'Copic Sketch Markers 72-set', 'Copic Sketch markers for professional artists. Brand: Copic. Quantity: 72 colors.', 24, 'https://example.com/copic-sketch-markers.jpg', 11, 300.00, 350.00, 2, '0123456789012', 10, '2024-08-05', '2024-08-10'),
    (52, 'Fender Stratocaster Electric Guitar', 'Fender Stratocaster electric guitar for musicians. Brand: Fender. Type: Electric.', 25, 'https://example.com/fender-stratocaster-guitar.jpg', 11, 800.00, 1000.00, 3, '1234567890123', 5, '2024-08-15', '2024-08-20'),
    (53, 'LG 75-inch OLED 4K Smart TV', 'LG 75-inch OLED 4K Smart TV for immersive entertainment. Brand: LG. Screen Size: 75 inches.', 8, 'https://example.com/lg-oled-4k-tv.jpg', 16, 1500.00, 1800.00, 4, '2345678901234', 2, '2024-08-25', '2024-08-30'),
    (54, 'Levi''s Denim Jacket', 'Levi''s denim jacket for classic style. Brand: Levi''s. Type: Jacket.', 9, 'https://example.com/levis-denim-jacket.jpg', 16, 200.00, 250.00, 5, '3456789012345', 5, '2024-09-05', '2024-09-10'),
    (55, 'Abstract Canvas Painting', 'Abstract canvas painting for modern home decor. Type: Wall Art. Style: Abstract.', 7, 'https://example.com/abstract-canvas-painting.jpg', 17, 100.00, 120.00, 6, '4567890123456', 10, '2024-09-15', '2024-09-20'),
    (56, 'To Kill a Mockingbird Book', 'To Kill a Mockingbird book for classic literature enthusiasts. Genre: Literature. Author: Harper Lee.', 19, 'https://example.com/to-kill-a-mockingbird-book.jpg', 20, 12.00, 15.00, 7, '5678901234567', 20, '2024-09-25', '2024-09-30'),
    (57, 'LEGO Architecture Statue of Liberty', 'Build the LEGO Architecture Statue of Liberty for a patriotic experience. Theme: Landmark. Brand: LEGO.', 19, 'https://example.com/lego-statue-of-liberty.jpg', 20, 100.00, 120.00, 8, '6789012345678', 5, '2024-10-05', '2024-10-10'),
    (58, 'Titleist Golf Clubs Set', 'Titleist golf clubs set for golf enthusiasts. Brand: Titleist. Set includes various clubs.', 20, 'https://example.com/titleist-golf-clubs.jpg', 1, 800.00, 1000.00, 9, '7890123456789', 2, '2024-10-15', '2024-10-20'),
    (59, 'Mobil 1 Synthetic Motor Oil 5L', 'Mobil 1 synthetic motor oil for high-performance engines. Mobil 1 brand. Vehicle: Car.', 21, 'https://example.com/mobil-1-synthetic-oil.jpg', 2, 120.00, 150.00, 20, '8901234567890', 5, '2024-10-25', '2024-10-30'),
    (60, 'Diamond Engagement Ring', 'Elegant diamond engagement ring for special occasions. Jewelry Type: Ring. Material: Diamond.', 22, 'https://example.com/diamond-engagement-ring.jpg', 3, 3000.00, 3500.00, 1, '9012345678901', 1, '2024-11-05', '2024-11-10')
   ; 

INSERT INTO inventory (product_id, branch_id, quantity, updated_on, reorder_level)
VALUES
    (1, 1, 500, '2023-07-05', 100),
    (2, 2, 300, '2023-07-10', 50),
    (3, 3, 200, '2023-08-01', 30),
    (4, 4, 100, '2023-09-05', 20),
    (5, 5, 400, '2023-07-15', 80),
    (6, 6, 250, '2023-08-25', 40),
    (7, 7, 300, '2023-09-10', 60),
    (8, 8, 500, '2023-07-01', 100),
    (9, 9, 1000, '2023-08-20', 200),
    (10, 10, 400, '2023-09-01', 80),
    (11, 11, 300, '2023-07-10', 60),
    (12, 12, 250, '2023-08-15', 50),
    (13, 3, 300, '2023-09-20', 60),
    (14, 4, 600, '2023-07-05', 120),
    (15, 5, 500, '2023-07-15', 100),
    (16, 13, 200, '2023-08-10', 40),
    (17, 1, 800, '2023-08-20', 160),
    (18, 2, 200, '2023-09-10', 40),
    (19, 3, 30, '2023-07-15', 6),
    (20, 4, 10, '2023-07-30', 2),
    (21, 5, 40, '2023-08-05', 8),
    (22, 6, 5, '2023-08-20', 1),
    (23, 7, 100, '2023-08-25', 20),
    (24, 8, 10, '2023-09-05', 2),
    (25, 9, 30, '2023-09-10', 6),
    (26, 10, 15, '2023-07-10', 3),
    (27, 11, 10, '2023-08-15', 2),
    (28, 12, 50, '2023-09-20', 10),
    (29, 13, 20, '2023-07-01', 4),
    (30, 14, 10, '2023-08-20', 2),
    (31, 15, 25, '2023-09-05', 5),
    (32, 1, 5, '2023-07-15', 1),
    (33, 2, 100, '2023-08-25', 20),
    (34, 3, 20, '2023-09-01', 4),
    (35, 4, 30, '2023-07-10', 6),
    (36, 5, 50, '2023-08-20', 10),
    (37, 6, 10, '2023-09-05', 2),
    (38, 7, 30, '2023-07-05', 6),
    (39, 8, 10, '2023-07-15', 2),
    (40, 9, 5, '2023-08-10', 1),
    (41, 10, 20, '2023-08-20', 4),
    (42, 11, 10, '2023-08-25', 2),
    (43, 12, 15, '2023-09-05', 3),
    (44, 13, 5, '2023-09-10', 1),
    (45, 10, 80, '2023-07-01', 16),
    (46, 8, 20, '2023-07-10', 4),
    (47, 11, 10, '2023-08-15', 2),
    (48, 1, 50, '2023-09-20', 10),
    (49, 2, 5, '2023-07-05', 1),
    (50, 3, 30, '2023-07-15', 6);

INSERT INTO customer (customer_id,name, email, phone, address, visit_count, rewards_points)
VALUES
    (1, 'John Doe', 'johndoe@example.com', '112233445', '123 Main St, Anytown, USA', 50, 250.00),
    (2, 'Jane Smith', 'janesmith@example.com', '998877665', '456 Elm St, Another Town, USA', 30, 150.50),
    (3, 'Robert Johnson', 'robertjohnson@example.com', '771234567', '789 Oak St, Somewhere, USA', 80, 400.75),
    (4, 'Mary Wilson', 'marywilson@example.com', '333444555', '101 Pine St, Anytown, USA', 10, 50.25),
    (5, 'Michael Lee', 'michaellee@example.com', '222555444', '543 Cedar St, Another Town, USA', 5, 25.00),
    (6, 'Lisa Garcia', 'lisagarcia@example.com', '666555444', '876 Birch St, Somewhere, USA', 15, 75.75),
    (7,'Sarah Brown', 'sarahbrown@example.com', '555444333', '789 Pine St, Another Town, USA', 40, 200.50),
    (8,'William Smith', 'williamsmith@example.com', '777888999', '234 Walnut St, Somewhere, USA', 20, 100.25),
    (9,'Karen Davis', 'karendavis@example.com', '444555666', '987 Cedar St, Anytown, USA', 75, 375.75),
    (10,'James Taylor', 'jamestaylor@example.com', '555777888', '876 Oak St, Another Town, USA', 90, 450.00),
    (11,'Jennifer Clark', 'jenniferclark@example.com', '999888777', '321 Elm St, Somewhere, USA', 1000, 500.00),
    (12,'Joseph Johnson', 'josephjohnson@example.com', '555666777', '123 Pine St, Anytown, USA', 500, 250.00),
    (13,'Nancy Moore', 'nancymoore@example.com', '444666555', '543 Maple St, Another Town, USA', 200, 100.00),
    (14,'Robert White', 'robertwhite@example.com', '333777666', '987 Oak St, Somewhere, USA', 300, 150.00),
    (15,'Linda Harris', 'lindaharris@example.com', '222777888', '101 Cedar St, Anytown, USA', 700, 350.00),
    (16,'John Miller', 'johnmiller@example.com', '444555444', '876 Pine St, Another Town, USA', 450, 225.00),
    (17,'Patricia Garcia', 'patriciagarcia@example.com', '777555444', '234 Cedar St, Somewhere, USA', 800, 400.00),
    (18,'Robert Brown', 'robertbrown@example.com', '666444555', '543 Oak St, Anytown, USA', 200, 100.00),
    (19,'Susan Lee', 'susanlee@example.com', '555444555', '876 Walnut St, Another Town, USA', 300, 150.00),
    (20,'Charles Johnson', 'charlesjohnson@example.com', '555666444', '987 Elm St, Somewhere, USA', 100, 50.00),
    (21,'Karen Davis', 'karendavis@example.com', '555444333', '321 Cedar St, Anytown, USA', 50, 25.00),
    (22,'Daniel Taylor', 'danieltaylor@example.com', '555444666', '876 Pine St, Another Town, USA', 75, 37.50),
    (23,'Linda Anderson', 'lindaanderson@example.com', '555777999', '234 Oak St, Somewhere, USA', 40, 20.00),
    (24,'James Smith', 'jamessmith@example.com', '666777999', '543 Cedar St, Anytown, USA', 15, 7.50),
    (25,'Elizabeth Wilson', 'elizabethwilson@example.com', '555777888', '876 Birch St, Another Town, USA', 10, 5.00),
    (26,'Michael Brown', 'michaelbrown@example.com', '777666555', '987 Maple St, Somewhere, USA', 90, 45.00),
    (27,'Patricia Clark', 'patriciaclark@example.com', '444777888', '321 Pine St, Anytown, USA', 120, 60.00),
    (28,'Richard White', 'richardwhite@example.com', '555666777', '876 Oak St, Another Town, USA', 35, 17.50),
    (29,'Karen Thomas', 'karenthomas@example.com', '333777999', '234 Walnut St, Somewhere, USA', 200, 100.00),
    (30,'David Hall', 'davidhall@example.com', '222777666', '543 Cedar St, Anytown, USA', 550, 275.00),
    (31,'Susan Young', 'susanyoung@example.com', '555444777', '876 Pine St, Another Town, USA', 430, 215.00),
    (32,'Michael Hernandez', 'michaelhernandez@example.com', '777555666', '234 Cedar St, Somewhere, USA', 280, 140.00),
    (33,'Sarah Davis', 'sarahdavis@example.com', '444555777', '543 Oak St, Anytown, USA', 150, 75.00),
    (34,'James Williams', 'jameswilliams@example.com', '555444777', '876 Elm St, Another Town, USA', 60, 30.00),
    (35,'Linda Smith', 'lindasmith@example.com', '555555555', '234 Pine St, Somewhere, USA', 400, 200.00),
    (36,'Richard Johnson', 'richardjohnson@example.com', '555555555', '543 Maple St, Anytown, USA', 700, 350.00),
    (37,'Nancy Taylor', 'nancytaylor@example.com', '555555555', '876 Oak St, Another Town, USA', 200, 100.00),
    (38,'William Harris', 'williamharris@example.com', '555555555', '234 Cedar St, Somewhere, USA', 100, 50.00),
    (39,'Elizabeth Davis', 'elizabethdavis@example.com', '555555555', '543 Pine St, Anytown, USA', 25, 12.50),
    (40,'David Taylor', 'davidtaylor@example.com', '555555555', '876 Walnut St, Another Town, USA', 300, 150.00),
    (41,'Mary Anderson', 'maryanderson@example.com', '555555555', '234 Elm St, Somewhere, USA', 600, 300.00),
    (42,'Richard Smith', 'richardsmith@example.com', '555555555', '543 Cedar St, Anytown, USA', 750, 375.00),
    (43,'Jennifer Anderson', 'jenniferanderson@example.com', '555555555', '876 Pine St, Another Town, USA', 300, 150.00),
    (44,'Christopher Davis', 'christopherdavis@example.com', '555555555', '234 Oak St, Somewhere, USA', 120, 60.00);


INSERT INTO sales_history (transaction_number, customer_id, cashier_id, datetime, total_payment, payment_method_id)
VALUES
    ('TRX001', 1, 38, '2022-03-15 10:30:00', 100.00, 1),
    ('TRX002', 2, 39, '2022-04-20 14:45:00', 75.50, 2),
    ('TRX003', 3, 40, '2022-05-10 16:20:00', 200.75, 1),
    ('TRX004', 4, 41, '2022-06-05 11:15:00', 50.25, 3),
    ('TRX005', 5, 42, '2022-07-12 09:40:00', 25.00, 2),
    ('TRX006', 6, 43, '2022-08-18 17:05:00', 75.75, 1),
    ('TRX007', 7, 44, '2022-09-25 13:55:00', 300.00, 4),
    ('TRX008', 8, 45, '2022-10-30 19:10:00', 200.50, 1),
    ('TRX009', 9, 38, '2022-11-08 08:00:00', 100.25, 2),
    ('TRX010', 10, 39, '2022-12-12 12:25:00', 375.75, 4),
    ('TRX011', 11, 40, '2023-01-05 15:15:00', 450.00, 1),
    ('TRX012', 12, 41, '2023-02-20 10:50:00', 250.00, 3),
    ('TRX013', 13, 42, '2023-03-22 14:30:00', 100.00, 2),
    ('TRX014', 14, 43, '2023-04-15 16:55:00', 200.50, 1),
    ('TRX015', 15, 44, '2023-05-10 11:45:00', 50.25, 3),
    ('TRX016', 16, 45, '2023-06-28 09:20:00', 25.00, 2);


INSERT INTO cart (cart_ID,transaction_number, product_id, quantity, discount_percentage, discount, total_amount, date, status)
VALUES
    (1,'TRX001', 1, 3, 0.10, 10.00, 90.00, '2022-03-15 10:30:00', 'SOLD'),
    (2,'TRX001', 2, 2, 0.05, 5.00, 95.00, '2022-03-15 10:30:30', 'SOLD'),
    (3,'TRX001', 3, 1, 0.0, 0.00, 50.00, '2022-03-15 10:31:00', 'SOLD'),
    (4,'TRX002', 4, 2, 0.15, 11.32, 64.18, '2022-04-20 14:45:00', 'SOLD'),
    (5,'TRX002', 5, 5, 0.05, 1.75, 33.25, '2022-04-20 14:45:20', 'SOLD'),
    (6,'TRX003', 6, 1, 0.10, 20.08, 180.72, '2022-05-10 16:20:00', 'SOLD'),
    (7,'TRX003', 7, 3, 0.0, 0.00, 300.00, '2022-05-10 16:20:10', 'SOLD'),
    (8,'TRX004', 8, 4, 0.05, 2.51, 47.74, '2022-06-05 11:15:00', 'SOLD'),
    (9,'TRX004', 9, 2, 0.10, 10.00, 90.00, '2022-06-05 11:16:00', 'SOLD'),
    (10,'TRX005', 10, 1, 0.0, 0.00, 25.00, '2022-07-12 09:40:00', 'SOLD'),
    (11,'TRX006', 11, 2, 0.05, 3.79, 71.96, '2022-08-18 17:05:00', 'SOLD'),
    (12,'TRX006', 12, 3, 0.0, 0.00, 75.75, '2022-08-18 17:05:50', 'SOLD'),
    (13,'TRX007', 13, 4, 0.10, 30.00, 270.00, '2022-09-25 13:55:00', 'SOLD'),
    (14,'TRX008', 14, 5, 0.15, 30.08, 170.42, '2022-10-30 19:10:00', 'SOLD'),
    (15,'TRX009', 15, 1, 0.0, 0.00, 100.25, '2022-11-08 08:00:00', 'SOLD'),
    (16,'TRX010', 16, 2, 0.05, 18.79, 357.96, '2022-12-12 12:24:00', 'SOLD'),
    (17,'TRX010', 17, 3, 0.10, 30.00, 270.00, '2022-12-12 12:25:00', 'SOLD'),
    (18,'TRX011', 18, 4, 0.0, 0.00, 450.00, '2023-01-05 15:15:00', 'SOLD'),
    (19,'TRX012', 19, 5, 0.05, 12.50, 237.50, '2023-02-20 10:50:00', 'SOLD'),
    (20,'TRX013', 20, 1, 0.0, 0.00, 100.00, '2023-03-22 14:30:00', 'SOLD'),
    (21,'TRX014', 21, 2, 0.0, 0.00, 200.50, '2023-04-15 16:55:00', 'SOLD'),
    (22,'TRX015', 22, 3, 0.05, 2.51, 47.74, '2023-05-10 11:44:00', 'SOLD'),
    (23,'TRX015', 23, 4, 0.10, 10.00, 90.00, '2023-05-10 11:45:00', 'SOLD'),
    (24,'TRX016', 24, 5, 0.0, 0.00, 25.00, '2023-06-28 09:20:00', 'SOLD');