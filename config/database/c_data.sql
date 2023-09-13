INSERT INTO user_role (role_name, role_desc)
VALUES
    ( 'Owner', 'Responsible for overall management and ownership of the supermarket.'),
    ('Finance Manager', 'Responsible for financial reporting and analysis.'),
    ('Branch Manager', 'Manages the day-to-day operations of a specific branch.'),
    ('Cashier', 'Handles customer transactions at the checkout counter.');

INSERT INTO access_type (access_name)
VALUES
    ('Sales Access'),
    ('Inventory Access'),
    ('Employee Access'),
    ('Customer Access'),
    ('Reports Access'),
    ('Product Pricing Access'),
    ('Customer Database Access'),
    ('Promotions and Discounts Access'),
    ('Add Product Access'),
    ('Edit Product Access'),
    ('Delete Product Access'),
    ('View Product Access'),
    ('Add Customer Access'),
    ('Edit Customer Access'),
    ('Delete Customer Access'),
    ('View Customer Access'),
    ('Add Employee Access'),
    ('Edit Employee Access'),
    ('Delete Employee Access'),
    ('View Employee Access');

INSERT INTO user_access (role_ID, access_type_ID)
VALUES
    (1, 1),   -- Role 1 has Access Type 1
    (1, 2),   -- Role 1 has Access Type 2
    (1, 3),   -- Role 1 has Access Type 3
    (1, 4),   -- Role 1 has Access Type 4
    (1, 5),   -- Role 1 has Access Type 5
    (1, 6),   -- Role 1 has Access Type 6
    (1, 7),   -- Role 1 has Access Type 7
    (1, 8),   -- Role 1 has Access Type 8
    (1, 9),   -- Role 1 has Access Type 9
    (1, 10),  -- Role 1 has Access Type 10
    (1, 11),  -- Role 1 has Access Type 11
    (1, 12),  -- Role 1 has Access Type 12
    (1, 13),  -- Role 1 has Access Type 13
    (1, 14),  -- Role 1 has Access Type 14
    (1, 15),  -- Role 1 has Access Type 15
    (1, 16),  -- Role 1 has Access Type 16
    (1, 17),  -- Role 1 has Access Type 17
    (1, 18),  -- Role 1 has Access Type 18
    (2, 1),   -- Role 2 has Access Type 1
    (2, 3),   -- Role 2 has Access Type 3
    (2, 5),   -- Role 2 has Access Type 5
    (2, 7),   -- Role 2 has Access Type 7
    (2, 9),   -- Role 2 has Access Type 9
    (2, 11),  -- Role 2 has Access Type 11
    (2, 13),  -- Role 2 has Access Type 13
    (2, 15),  -- Role 2 has Access Type 15
    (2, 17),  -- Role 2 has Access Type 17
    (3, 2),   -- Role 3 has Access Type 2
    (3, 4),   -- Role 3 has Access Type 4
    (3, 6),   -- Role 3 has Access Type 6
    (3, 8),   -- Role 3 has Access Type 8
    (3, 10),  -- Role 3 has Access Type 10
    (3, 12),  -- Role 3 has Access Type 12
    (3, 14),  -- Role 3 has Access Type 14
    (3, 16),  -- Role 3 has Access Type 16
    (3, 18),  -- Role 3 has Access Type 18
    (4, 1),   -- Role 4 has Access Type 1
    (4, 4),   -- Role 4 has Access Type 4
    (4, 7),   -- Role 4 has Access Type 7
    (4, 10),  -- Role 4 has Access Type 10
    (4, 13),  -- Role 4 has Access Type 13
    (4, 16);  -- Role 4 has Access Type 16


INSERT INTO category (name)
VALUES
     ('Fruits'),
    ('Vegetables'),
    ('Dairy'),
    ('Meat'),
    ('Bakery'),
    ('Beverages'),
    ('Snacks'),
    ('Cleaning Supplies'),
    ('Frozen Foods'),
    ('Canned Goods'),
    ('Health and Beauty'),
    ('Household Essentials'),
    ('Pet Supplies'),
    ('Office Supplies'),
    ('Electronics'),
    ('Clothing'),
    ('Footwear'),
    ('Home Decor'),
    ('Books and Magazines'),
    ('Toys and Games'),
    ('Sporting Goods'),
    ('Automotive'),
    ('Jewelry and Accessories'),
    ('Stationery'),
    ('Art and Craft Supplies');


INSERT INTO units_of_measure (uom_name, abbreviations)
VALUES
    ( 'Kilogram', 'kg'),
    ('Gram', 'g'),
    ('Liter', 'L'),
    ('Milliliter', 'mL'),
    ('Pound', 'lb'),
    ( 'Ounce', 'oz'),
    ('Dozen', 'doz'),
    ('Each', 'ea'),
    ('Gallon', 'gal'),
    ('Quart', 'qt'),
    ('Pint', 'pt'),
    ('Piece', 'pc'),
    ('Pack', 'pk'),
    ('Can', 'can'),
    ('Bag', 'bag'),
    ('Meter', 'm'),
    ('Centimeter', 'cm'),
    ('Millimeter', 'mm'),
    ('Foot', 'ft'),
    ('Inch', 'in'),
    ('Bottle', 'bottle');


INSERT INTO payment_method (name)
VALUES 
    ('Cash'),
    ('Credit Card'),
    ('Debit Card'),
    ('Mobile Money'),
    ('Gift Card'),
    ('Voucher');

INSERT INTO discounts_and_promotions (name, description, discount_percentage)
VALUES
    ('Summer Sale', 'Get discounts on various summer products', 15.00),
    ('Back to School', 'Special discounts on school supplies', 10.50),
    ('Holiday Season', 'Festive discounts for holiday shoppers', 20.00),
    ('Weekend Special', 'Limited-time weekend discounts', 12.75),
    ('New Year Clearance', 'Clearance sale for old inventory', 30.25),
    ('Valentine''s Day', 'Discounts on gifts for your loved ones', 14.00),
    ('Spring Cleaning', 'Save on cleaning supplies', 18.50),
    ('Easter Sale', 'Special offers for Easter weekend', 10.00),
    ('Black Friday', 'Biggest discounts of the year on Black Friday', 35.00),
    ('Cyber Monday', 'Online-only deals for Cyber Monday', 25.50);

INSERT INTO branch (city, address, phone, email)
VALUES
    ('Colombo', '123 Main St, Colombo 01', '112233445', 'colombobranch@example.com'),
    ('Kandy', '456 Elm St, Kandy 20000', '814325678', 'kandybranch@example.com'),
    ('Galle', '789 Oak St, Galle 80000', '912345678',  'gallebranch@example.com'),
    ( 'Anuradhapura', '789 Pine St, Anuradhapura 50000', '762345678', 'anuradhapurabranch@example.com');


INSERT INTO gift_cards (card_value, expired_date, barcode)
VALUES
    (500.00, '2023-12-31', 'GC123456789500'),
    (1000.00, '2024-01-15', 'GC2345678901000'),
    (2000.00, '2024-02-28', 'GC3456789012000'),
    (5000.00, '2024-03-20', 'GC4567890125000'),
    (500.00, '2024-04-10', 'GC567890123500'),
    (1000.00, '2024-05-05', 'GC6789012341000'),
    (2000.00, '2024-06-30', 'GC7890123452000'),
    (5000.00, '2024-07-15', 'GC8901234565000'),
    (500.00, '2024-08-20', 'GC901234567500'),
    (1000.00, '2024-09-10', 'GC0123456781000'),
    (2000.00, '2024-10-05', 'GC1234567892000'),
    (5000.00, '2024-11-15', 'GC2345678905000'),
    (500.00, '2024-12-25', 'GC345678901500'),
    (1000.00, '2025-01-10', 'GC4567890121000'),
    (2000.00, '2025-02-28', 'GC5678901232000'),
    (5000.00, '2025-03-20', 'GC6789012345000'),
    (500.00, '2025-04-15', 'GC789012345500'),
    (1000.00, '2025-05-31', 'GC8901234561000'),
    (2000.00, '2025-06-15', 'GC9012345672000'),
    (5000.00, '2025-07-20', 'GC0123456785000');


INSERT INTO supplier (name, email, phone, address)
VALUES
    ('Sri Lanka Spice Exporters', 'sales@slspices.lk', '666765678', '345 Cinnamon St, Colombo 02'),
    ('Gem Paradise', 'info@gemparadise.lk', '911234567', '789 Ruby St, Ratnapura 70000'),
    ('Ceylon Timber Industries','info@ctimber.lk', '444555666', '567 Timber St, Baduraliya 80200'),
    ('Lanka Cocoa Exporters', 'sales@cocoaexports.lk', '333444555', '432 Cocoa St, Matale 80050'),
    ('Exotic Ceylon Tea', 'info@exotictea.lk', '888999000', '876 Tea Gardens, Nuwara Eliya 22250'),
    ( 'Tropical Woodworks', 'sales@woodworks.lk', '777999888', '654 Timber St, Kalutara 12000'),
    ( 'Sri Lankan Textiles', 'info@sltextiles.lk', '123987654', '321 Fabric St, Negombo 11550'),
    ( 'Ceylon Gems & Jewelry', 'sales@ceylongems.lk', '567123456', '543 Gem St, Ratnapura 70050'),
    ( 'Ocean Fresh Seafoods', 'info@oceanfresh.lk', '890123456', '456 Seafood St, Negombo 11560'),
    ( 'Ceylon Electronics', 'sales@electronics.lk', '123890123', '789 Circuit St, Colombo 03'),
    ( 'Lanka Pharmaceuticals', 'info@lankapharma.lk', '333555777', '987 Medicine St, Colombo 04'),
    ( 'Sri Lankan Ceramics', 'sales@slceramics.lk', '789555789', '876 Pottery St, Colombo 05'),
    ( 'Exotic Sri Lankan Spices', 'info@slspices.lk', '345678345', '567 Spice St, Colombo 06'),
    ( 'Ceylon Auto Parts', 'sales@autoparts.lk', '890678678', '432 Auto St, Colombo 07'),
    ( 'Island Craftsmen', 'info@islandcrafts.lk', '567890567', '543 Craft St, Colombo 08'),
    ( 'Lanka Agricultural Supplies', 'sales@agrisupplies.lk', '123567890', '321 Agri St, Colombo 09'),
    ( 'Sri Lanka Hardware', 'info@slhardware.lk', '456789123', '987 Hardware St, Galle 80010'),
    ( 'Ceylon Fashion House', 'sales@fashionhouse.lk', '890123789', '345 Fashion St, Colombo 10'),
    ( 'Lanka Auto Repairs', 'info@autorepairs.lk', '123456789', '654 Repair St, Kandy 70020'),
    ( 'Sri Lankan Stationers', 'sales@slstationers.lk', '567890123', '432 Stationery St, Colombo 11');


INSERT INTO employee (name, username, password, role_id, hired_date, email, phone, branch_id)
VALUES
    ('Somesh Chandimal', 'somesh', crypt('1111',gen_salt('bf')), 1, '2022-01-15', 'somesh@example.com', '112233445', 1),
    ('John Doe', 'johndoe', crypt('password1',gen_salt('bf')), 3, '2022-05-15', 'johndoe@example.com', '112233445', 1),
    ('Jane Smith', 'janesmith', crypt('password2',gen_salt('bf')), 2, '2021-12-10', 'janesmith@example.com', '998877665', 2),
    ('Robert Johnson', 'robertjohnson', crypt('password3',gen_salt('bf')), 2, '2023-02-28', 'robertjohnson@example.com', '777766655', 3),
    ('Mary Wilson', 'marywilson', crypt('password4',gen_salt('bf')), 2, '2022-09-30', 'marywilson@example.com', '333444555', 4),
    ('Michael Lee', 'michaellee', crypt('password5',gen_salt('bf')), 3, '2020-07-05', 'michaellee@example.com', '222555444', 1),
    ('Lisa Garcia', 'lisagarcia', crypt('password6',gen_salt('bf')), 4, '2021-10-20', 'lisagarcia@example.com', '666555444', 2),
    ('David Martinez', 'davidmartinez', crypt('password7',gen_salt('bf')), 2, '2022-04-15', 'davidmartinez@example.com', '777444555', 3),
    ('Sarah Brown', 'sarahbrown', crypt('password8',gen_salt('bf')), 4, '2021-03-25', 'sarahbrown@example.com', '555444333', 4),
    ('William Smith', 'williamsmith', crypt('password9',gen_salt('bf')), 4, '2022-01-05', 'williamsmith@example.com', '777888999', 1),
    ('Karen Davis', 'karendavis', crypt('password10',gen_salt('bf')), 4, '2023-06-30', 'karendavis@example.com', '444555666', 2),
    ('James Taylor', 'jamestaylor', crypt('password11',gen_salt('bf')), 2, '2022-08-15', 'jamestaylor@example.com', '555747888', 3),
    ('Jennifer Clark', 'jenniferclark', crypt('password12',gen_salt('bf')), 4, '2021-11-10', 'jenniferclark@example.com', '999888777', 4),
    ('Joseph Johnson', 'josephjohnson', crypt('password13',gen_salt('bf')), 4, '2023-01-15', 'josephjohnson@example.com', '555666777', 1),
    ('Nancy Moore', 'nancymoore', crypt('password14',gen_salt('bf')), 4, '2021-04-20', 'nancymoore@example.com', '444666555', 1),
    ('Robert White', 'robertwhite', crypt('password15',gen_salt('bf')), 4, '2020-11-05', 'robertwhite@example.com', '333777666', 2),
    ('Linda Harris', 'lindaharris', crypt('password16',gen_salt('bf')), 2, '2022-02-28', 'lindaharris@example.com', '222777888', 3),
    ('John Miller', 'johnmiller', crypt('password17',gen_salt('bf')), 4, '2023-03-10', 'johnmiller@example.com', '444555444', 4),
    ('Patricia Garcia', 'patriciagarcia', crypt('password18',gen_salt('bf')), 2, '2022-07-01', 'patriciagarcia@example.com', '777555444', 1),
    ('Robert Brown', 'robertbrown', crypt('password19',gen_salt('bf')), 2, '2020-12-25', 'robertbrown@example.com', '666444555', 2),
    ('Susan Lee', 'susanlee', crypt('password20',gen_salt('bf')), 2, '2022-10-15', 'susanlee@example.com', '555444555', 3),
    ('Charles Johnson', 'charlesjohnson', crypt('password21',gen_salt('bf')), 2, '2023-04-05', 'charlesjohnson@example.com', '555666444', 4),
    ('Kareen Davis', 'kareendavis', crypt('password22',gen_salt('bf')), 2, '2021-05-20', 'kareendavis@example.com', '555444333', 1),
    ('Daniel Taylor', 'danieltaylor', crypt('password23',gen_salt('bf')), 2, '2022-11-10', 'danieltaylor@example.com', '555444666',2),
    ('Linda Anderson', 'lindaanderson', crypt('password24',gen_salt('bf')), 2, '2022-06-15', 'lindaanderson@example.com', '555777999', 3),
    ('James Smith', 'jamessmith', crypt('password25',gen_salt('bf')), 4, '2021-08-30', 'jamessmith@example.com', '666777999', 4),
    ('Elizabeth Wilson', 'elizabethwilson', crypt('password26',gen_salt('bf')), 2, '2022-03-10', 'elizabethwilson@example.com', '555777888', 1),
    ('Michael Brown', 'michaelbrown', crypt('password27',gen_salt('bf')), 4, '2022-02-01', 'michaelbrown@example.com', '777666555', 2),
    ('Patricia Clark', 'patriciaclark', crypt('password28',gen_salt('bf')), 4, '2021-07-15', 'patriciaclark@example.com', '444777888', 3),
    ('Richard White', 'richardwhite', crypt('password29',gen_salt('bf')), 4, '2023-05-20', 'richardwhite@example.com', '515666777', 4),
    ('Karen Thomas', 'karenthomas', crypt('password30',gen_salt('bf')), 4, '2022-09-01', 'karenthomas@example.com', '337777999', 1),
    ('David Hall', 'davidhall', crypt('password31',gen_salt('bf')), 2, '2022-01-25', 'davidhall@example.com', '222777666', 2),
    ('Susan Young', 'susanyoung', crypt('password32',gen_salt('bf')), 4, '2021-02-15', 'susanyoung@example.com', '555444777', 2),
    ('Michael Hernandez', 'michaelhernandez', crypt('password33',gen_salt('bf')), 4, '2021-12-01', 'michaelhernandez@example.com', '777555666', 3),
    ('Sarah Davis', 'sarahdavis', crypt('password34',gen_salt('bf')), 4, '2022-03-05', 'sarahdavis@example.com', '444555777', 4),
    ('James Williams', 'jameswilliams', crypt('password35',gen_salt('bf')), 4, '2023-04-10', 'jameswilliams@example.com', '555444777', 1),
    ('Linda Smith', 'lindasmith', crypt('password36',gen_salt('bf')), 2, '2022-08-20', 'lindasmith@example.com', '555555555', 2),
    ('Richard Johnson', 'richardjohnson', crypt('password37',gen_salt('bf')), 4, '2021-06-30', 'richardjohnson@example.com', '555555555', 3),
    ('Nancy Taylor', 'nancytaylor', crypt('password38',gen_salt('bf')), 4, '2023-01-05', 'nancytaylor@example.com', '555555555', 4),
    ('William Harris', 'williamharris', crypt('password39',gen_salt('bf')), 4, '2022-07-20', 'williamharris@example.com', '555555555', 1),
    ('Elizabeth Davis', 'elizabethdavis', crypt('password40',gen_salt('bf')), 4, '2022-05-15', 'elizabethdavis@example.com', '555555555', 2),
    ('David Taylor', 'davidtaylor', crypt('password41',gen_salt('bf')), 4, '2022-11-30', 'davidtaylor@example.com', '555555555', 3),
    ('Mary Anderson', 'maryanderson', crypt('password42',gen_salt('bf')), 4, '2022-06-10', 'maryanderson@example.com', '555555555', 4),
    ('Richard Smith', 'richardsmith', crypt('password43',gen_salt('bf')), 4, '2021-09-15', 'richardsmith@example.com', '555555555', 1),
    ('Jennifer Anderson', 'jenniferanderson', crypt('password44',gen_salt('bf')), 4, '2022-01-10', 'jenniferanderson@example.com', '555555555', 2),
    ('Christopher Davis', 'christopherdavis', crypt('password45',gen_salt('bf')), 4, '2023-03-20', 'christopherdavis@example.com', '555555555', 3);

INSERT INTO product (name, description, category_ID, discount, image, unit_id, buying_ppu, retail_ppu, supplier_ID, barcode, created_on, updated_on)
VALUES
    ('Munchee Cream Cracker 100g', 'Delicious cream cracker biscuits from Munchee. Ideal for snacking1,.', 5,1, 'https://example.com/munchee-cream-cracker.jpg', 15, 50.00, 70.00, 1, '1234567890123',  '2022-03-10', '2023-07-05'),
    ('Ceylon Tea Leaves 250g', 'Premium Ceylon tea leaves for a perfect cup of tea. Made by Ceylon Tea Company.', 6, 1,'https://example.com/ceylon-tea.jpg', 15, 200.00, 250.00, 2, '9876543210987',  '2022-04-20', '2023-07-10'),
    ('Samba Rice 5kg', 'High-quality Samba rice for traditional Sri Lankan dishes. Rice King brand.', 6, 1,'https://example.com/rice.jpg', 15, 350.00, 400.00, 3, '2345678901234', '2022-05-15', '2023-08-01'),
    ('CocoLife Coconut Oil 1L', 'Pure coconut oil for cooking and skincare. CocoLife brand.', 7, 1,'https://example.com/coconut-oil.jpg', 15, 300.00, 400.00, 4, '3456789012345',  '2022-06-10', '2023-09-05'),
    ('Lucky Canned Fish 400g', 'Canned fish in brine, a convenient source of protein. Lucky brand.', 8, 1,'https://example.com/canned-fish.jpg', 15, 150.00, 180.00, 5, '4567890123456',  '2022-07-05', '2023-07-15'),
    ('Sunsilk Shampoo 250ml', 'Gentle shampoo for clean and healthy hair. Sunsilk brand.', 9, 1,'https://example.com/shampoo.jpg', 15, 150.00, 200.00, 6, '5678901234567',  '2022-08-20', '2023-08-25'),
    ('Nescafe Instant Coffee 100g', 'Instant coffee for a quick caffeine boost. Nescafe brand.', 6, 1,'https://example.com/nescafe-coffee.jpg', 15, 180.00, 220.00, 7, '6789012345678',  '2022-09-15', '2023-09-10'),
    ('Lipton Yellow Label Tea 100 bags', 'Lipton Yellow Label tea bags for a refreshing brew. Lipton brand.', 6, 1,'https://example.com/lipton-tea.jpg', 15, 150.00, 180.00, 8, '7890123456789',  '2022-10-20', '2023-07-01'),
    ('Maggi Instant Noodles 75g', 'Quick and tasty Maggi instant noodles. Maggi brand.', 7, 1,'https://example.com/maggi-noodles.jpg', 15, 30.00, 40.00, 9, '8901234567890', '2022-11-25', '2023-08-20'),
    ('Colgate Toothpaste 150g', 'Colgate toothpaste for healthy teeth. Colgate brand.', 10, 1,'https://example.com/colgate-toothpaste.jpg', 14, 120.00, 150.00, 10, '9012345670901', '2022-12-10', '2023-09-01'),
    ('Dettol Liquid Hand Wash 250ml', 'Dettol liquid hand wash for germ protection. Dettol brand.', 10, 1,'https://example.com/dettol-hand-wash.jpg', 14, 50.00, 60.00, 11, '1123456789012',  '2023-01-15', '2023-07-10'),
    ('Sunlight Dishwashing Liquid 500ml', 'Sunlight dishwashing liquid for clean dishes. Sunlight brand.', 7, 1,'https://example.com/sunlight-dishwash.jpg', 14, 80.00, 100.00, 12, '1234567891123',  '2023-02-20', '2023-08-15'),
    ('Palmolive Shower Gel 250ml', 'Palmolive shower gel for a refreshing shower. Palmolive brand.', 10, 1,'https://example.com/palmolive-shower-gel.jpg', 14, 60.00, 80.00, 13, '2341678901234', '2023-03-10', '2023-09-20'),
    ('Whisper Ultra Thin Sanitary Pads 10s', 'Whisper Ultra Thin sanitary pads for comfortable protection. Whisper brand.', 11, 1,'https://example.com/whisper-sanitary-pads.jpg', 14, 100.00, 120.00, 14, '1456789012345', '2023-04-15', '2023-08-25'),
    ('Kotex Maxi Pads 16s', 'Kotex Maxi pads for reliable menstrual protection. Kotex brand.', 11, 1,'https://example.com/kotex-maxi-pads.jpg', 14, 80.00, 100.00, 15, '4567891123456',  '2023-05-20', '2023-07-05'),
    ('Ariel Laundry Detergent 2kg', 'Ariel laundry detergent for clean and fresh clothes. Ariel brand.', 12, 1,'https://example.com/ariel-detergent.jpg', 14, 250.00, 300.00, 16, '5678911234567', '2023-06-25', '2023-09-10'),
    ('Pears Baby Soap', 'Gentle and mild baby soap from Pears. Suitable for delicate skin.', 11, 1,'https://example.com/pears-baby-soap.jpg', 13, 75.00, 100.00, 1, '1234567890124',  '2023-07-30', '2023-08-15'),
    ('Duracell AA Batteries 4-pack', 'Duracell AA batteries for long-lasting power. Duracell brand.', 13, 1,'https://example.com/duracell-batteries.jpg', 13, 80.00, 100.00, 18, '7895123456789', '2023-08-05', '2023-08-20'),
    ('Sony Earphones', 'High-quality Sony earphones for music lovers. Sony brand.', 14, 1,'https://example.com/sony-earphones.jpg', 12, 350.00, 400.00, 19, '8911234567890',  '2023-09-10', '2023-09-25'),
    ('Nike Running Shoes', 'Nike running shoes for active lifestyles. Nike brand.', 15, 1,'https://example.com/nike-running-shoes.jpg', 17, 500.00, 600.00, 20, '9012345671901',  '2023-09-25', '2023-09-30'),
    ('IKEA Table Lamp', 'IKEA table lamp for stylish illumination. IKEA brand.', 16, 1,'https://example.com/ikea-table-lamp.jpg', 17, 120.00, 150.00, 1, '2123456789012', '2023-10-05', '2023-10-10'),
    ('Harry Potter and the Sorcerer''s Stone', 'A classic novel by J.K. Rowling. Genre: Fantasy. Author: J.K. Rowling.', 19, 1,'https://example.com/harry-potter-book.jpg', 20, 20.00, 25.00, 2, '1234567890193',  '2023-10-15', '2023-10-20'),
    ('Lego Star Wars Millennium Falcon', 'Build the iconic Millennium Falcon with LEGO. Theme: Star Wars. Brand: LEGO.', 19, 1,'https://example.com/lego-millennium-falcon.jpg', 20, 300.00, 350.00, 3, '2342678901234',  '2023-10-25', '2023-10-30'),
    ('Wilson Tennis Racket', 'Wilson tennis racket for tennis enthusiasts. Brand: Wilson. Sport: Tennis.', 20, 1,'https://example.com/wilson-tennis-racket.jpg', 1, 100.00, 120.00, 4, '2456789012345',  '2023-11-05', '2023-11-10'),
    ('Castrol Engine Oil 1L', 'Castrol engine oil for smooth performance. Castrol brand. Vehicle: Car.', 21, 1,'https://example.com/castrol-engine-oil.jpg', 20, 80.00, 100.00, 5, '1567892123456', '2023-11-15', '2023-11-20'),
    ('Gold Necklace', 'Elegant gold necklace for special occasions. Jewelry Type: Necklace. Material: Gold.', 22, 1,'https://example.com/gold-necklace.jpg', 2, 1000.00, 1200.00, 6, '2678921234567', '2023-11-25', '2023-11-30'),
    ('Staedtler Colored Pencils 24-pack', 'Staedtler colored pencils for creative art projects. Brand: Staedtler. Quantity: 24.', 24, 1,'https://example.com/staedtler-colored-pencils.jpg', 3, 50.00, 60.00, 7, '3789112345678',  '2023-12-05', '2023-12-10'),
    ('Acrylic Paint Set 12 Colors', 'Acrylic paint set for painting enthusiasts. Quantity: 12 colors.', 24, 1,'https://example.com/acrylic-paint-set.jpg', 3, 40.00, 50.00, 8, '4894123456789',  '2023-12-15', '2023-12-20'),
    ('Ford Mustang Model Car Kit', 'Build your own Ford Mustang model car kit. Brand: Ford. Scale: 1:24.', 25, 1,'https://example.com/ford-mustang-model-kit.jpg', 4, 60.00, 80.00, 10, '5921234567890',  '2023-12-25', '2023-12-30'),
    ('Yamaha Acoustic Guitar', 'Yamaha acoustic guitar for musicians. Brand: Yamaha. Type: Acoustic.', 25, 1,'https://example.com/yamaha-acoustic-guitar.jpg', 4, 200.00, 250.00, 1, '9012345672901', '2024-01-05', '2024-01-10'),
    ('Adidas Sports Shoes', 'Adidas sports shoes for active lifestyles. Brand: Adidas. Sport: Running.', 6, 1,'https://example.com/adidas-sports-shoes.jpg', 7, 400.00, 500.00, 2, '3123456789012', '2024-01-15', '2024-01-20'),
    ('Samsung 55-inch 4K Smart TV', 'Samsung 55-inch 4K Smart TV for immersive entertainment. Brand: Samsung. Screen Size: 55 inches.', 8, 1,'https://example.com/samsung-4k-smart-tv.jpg', 5, 900.00, 1100.00, 13, '1234567890122', '2024-01-25', '2024-01-30'),
    ('Levi''s Denim Jeans', 'Levi''s denim jeans for classic style. Brand: Levi''s. Type: Jeans.', 9, 1,'https://example.com/levis-jeans.jpg', 5, 150.00, 180.00, 14, '2345878901234', '2024-02-05', '2024-02-10'),
    ('Home Decor Wall Clock', 'Elegant wall clock for home decor. Type: Wall Clock. Style: Elegant.', 7, 1,'https://example.com/home-decor-wall-clock.jpg', 6, 40.00, 50.00, 15, '4456789012345',  '2024-02-15', '2024-02-20'),
    ('Cooking for Dummies Book', 'Cooking for Dummies book for aspiring chefs. Genre: Cooking. Author: John Doe.', 19, 1,'https://example.com/cooking-for-dummies-book.jpg', 8, 15.00, 20.00, 16, '3567892123456', '2024-02-25', '2024-02-28'),
    ('LEGO Creator Expert Roller Coaster', 'Build the LEGO Creator Expert Roller Coaster for fun and excitement. Theme: Amusement Park. Brand: LEGO.', 19, 1,'https://example.com/lego-roller-coaster.jpg', 2, 400.00, 500.00, 17, '4678901234567',  '2024-03-05', '2024-03-10'),
    ('Wilson Tennis Balls 3-pack', 'Wilson tennis balls for tennis practice and matches. Brand: Wilson. Quantity: 3.', 20, 1,'https://example.com/wilson-tennis-balls.jpg', 9, 20.00, 25.00, 18, '5789212345678', '2024-03-15', '2024-03-20'),
    ('Castrol Motorcycle Oil 1L', 'Castrol motorcycle oil for smooth engine performance. Castrol brand. Vehicle: Motorcycle.', 21, 1,'https://example.com/castrol-motorcycle-oil.jpg', 4, 60.00, 80.00, 19, '7893123456789',  '2024-03-25', '2024-03-30'),
    ('Gold Earrings', 'Elegant gold earrings for special occasions. Jewelry Type: Earrings. Material: Gold.', 22, 1,'https://example.com/gold-earrings.jpg', 1, 800.00, 1000.00, 20, '8931234567890', '2024-04-05', '2024-04-10'),
    ('Faber-Castell Watercolor Paint Set 12 Colors', 'Faber-Castell watercolor paint set for creative artists. Brand: Faber-Castell. Quantity: 12 colors.', 24, 1,'https://example.com/faber-castell-watercolor-paint.jpg', 13, 30.00, 40.00, 15, '9012345673901',  '2024-04-15', '2024-04-20'),
    ('Electric Guitar Kit', 'Electric guitar kit for budding musicians. Includes guitar, amp, and accessories.', 25, 1,'https://example.com/electric-guitar-kit.jpg', 14, 250.00, 300.00, 12, '0123456789012', '2024-04-25', '2024-04-30'),
    ('Nike Basketball Shoes', 'Nike basketball shoes for basketball enthusiasts. Brand: Nike. Sport: Basketball.', 6, 1,'https://example.com/nike-basketball-shoes.jpg', 17, 350.00, 400.00, 13, '1234567890113',  '2024-05-05', '2024-05-10'),
    ('Sony 65-inch 4K Smart TV', 'Sony 65-inch 4K Smart TV for cinematic viewing. Brand: Sony. Screen Size: 65 inches.', 8, 1,'https://example.com/sony-65-inch-4k-tv.jpg', 15, 1200.00, 1500.00, 14, '2349678901234', '2024-05-15', '2024-05-20'),
    ('Wrangler Denim Jeans', 'Wrangler denim jeans for rugged style. Brand: Wrangler. Type: Jeans.', 9, 1,'https://example.com/wrangler-jeans.jpg', 15, 180.00, 220.00, 15, '5456789012345', '2024-05-25', '2024-05-30'),
    ('Modern Wall Art', 'Modern wall art for contemporary home decor. Type: Wall Art. Style: Modern.', 7, 1,'https://example.com/modern-wall-art.jpg', 16, 80.00, 100.00, 16, '4567895123456',  '2024-06-05', '2024-06-10'),
    ('The Great Gatsby', 'A classic novel by F. Scott Fitzgerald. Genre: Fiction. Author: F. Scott Fitzgerald.', 19, 1,'https://example.com/the-great-gatsby-book.jpg', 18, 10.00, 15.00, 17, '5678991234567',  '2024-06-15', '2024-06-20'),
    ('LEGO Technic Porsche 911 GT3 RS', 'Build the LEGO Technic Porsche 911 GT3 RS for an authentic building experience. Theme: Sports Car. Brand: LEGO.', 19, 1,'https://example.com/lego-porsche-911.jpg', 18, 500.00, 600.00, 18, '6789312345678', '2024-06-25', '2024-06-30'),
    ('Wilson Golf Balls 12-pack', 'Wilson golf balls for golf practice and games. Brand: Wilson. Quantity: 12.', 20, 1,'https://example.com/wilson-golf-balls.jpg', 12, 25.00, 30.00, 19, '7892123456789', '2024-07-05', '2024-07-10'),
    ( 'Shell Engine Oil 4L', 'Shell engine oil for optimal engine performance. Shell brand. Vehicle: Car.', 21, 1,'https://example.com/shell-engine-oil.jpg', 10, 100.00, 120.00, 20, '8941234567890',  '2024-07-15', '2024-07-20'),
    ( 'Sapphire Ring', 'Elegant sapphire ring for special occasions. Jewelry Type: Ring. Material: Sapphire.', 22, 1,'https://example.com/sapphire-ring.jpg', 8, 600.00, 700.00, 1, '9012345678901',  '2024-07-25', '2024-07-30'),
    ( 'Copic Sketch Markers 72-set', 'Copic Sketch markers for professional artists. Brand: Copic. Quantity: 72 colors.', 24, 1,'https://example.com/copic-sketch-markers.jpg', 11, 300.00, 350.00, 2, '4123456789012', '2024-08-05', '2024-08-10'),
    ( 'Fender Stratocaster Electric Guitar', 'Fender Stratocaster electric guitar for musicians. Brand: Fender. Type: Electric.', 25, 1,'https://example.com/fender-stratocaster-guitar.jpg', 11, 800.00, 1000.00, 3, '1234567890133',  '2024-08-15', '2024-08-20'),
    ( 'LG 75-inch OLED 4K Smart TV', 'LG 75-inch OLED 4K Smart TV for immersive entertainment. Brand: LG. Screen Size: 75 inches.', 8, 1,'https://example.com/lg-oled-4k-tv.jpg', 16, 1500.00, 1800.00, 4, '2347678901234',  '2024-08-25', '2024-08-30'),
    ( 'Levi''s Denim Jacket', 'Levi''s denim jacket for classic style. Brand: Levi''s. Type: Jacket.', 9, 1,'https://example.com/levis-denim-jacket.jpg', 16, 200.00, 250.00, 5, '6456789012345', '2024-09-05', '2024-09-10'),
    ( 'Abstract Canvas Painting', 'Abstract canvas painting for modern home decor. Type: Wall Art. Style: Abstract.', 7, 1,'https://example.com/abstract-canvas-painting.jpg', 17, 100.00, 120.00, 6, '4567898123456',  '2024-09-15', '2024-09-20'),
    ( 'To Kill a Mockingbird Book', 'To Kill a Mockingbird book for classic literature enthusiasts. Genre: Literature. Author: Harper Lee.', 19, 1,'https://example.com/to-kill-a-mockingbird-book.jpg', 20, 12.00, 15.00, 7, '5678941234567', '2024-09-25', '2024-09-30'),
    ( 'LEGO Architecture Statue of Liberty', 'Build the LEGO Architecture Statue of Liberty for a patriotic experience. Theme: Landmark. Brand: LEGO.', 19, 1,'https://example.com/lego-statue-of-liberty.jpg', 20, 100.00, 120.00, 8, '6789412345678',  '2024-10-05', '2024-10-10'),
    ( 'Titleist Golf Clubs Set', 'Titleist golf clubs set for golf enthusiasts. Brand: Titleist. Set includes various clubs.', 20, 1,'https://example.com/titleist-golf-clubs.jpg', 1, 800.00, 1000.00, 9, '7891123456789', '2024-10-15', '2024-10-20'),
    ( 'Mobil 1 Synthetic Motor Oil 5L', 'Mobil 1 synthetic motor oil for high-performance engines. Mobil 1 brand. Vehicle: Car.', 21, 1,'https://example.com/mobil-1-synthetic-oil.jpg', 2, 120.00, 150.00, 20, '8951234567890', '2024-10-25', '2024-10-30'),
    ( 'Diamond Engagement Ring', 'Elegant diamond engagement ring for special occasions. Jewelry Type: Ring. Material: Diamond.', 22, 1,'https://example.com/diamond-engagement-ring.jpg', 3, 3000.00, 3500.00, 1, '9012345678101' , '2024-11-05', '2024-11-10')
   ; 
    
INSERT INTO inventory (product_id, branch_id, quantity, lastUpdate_at, reorder_level)
VALUES
    (1, 1, 500, '2023-07-05', 100),
    (1, 2, 500, '2023-07-05', 100),
    (2, 2, 300, '2023-07-10', 50),
    (3, 3, 200, '2023-08-01', 30),
    (4, 4, 100, '2023-09-05', 20),
    (5, 1, 400, '2023-07-15', 80),
    (6, 2, 250, '2023-08-25', 40),
    (7, 3, 300, '2023-09-10', 60),
    (8, 4, 500, '2023-07-01', 100),
    (9, 1, 1000, '2023-08-20', 200),
    (10, 1, 400, '2023-09-01', 80),
    (11, 1, 300, '2023-07-10', 60),
    (12, 2, 250, '2023-08-15', 50),
    (13, 3, 300, '2023-09-20', 60),
    (14, 4, 600, '2023-07-05', 120),
    (15, 2, 500, '2023-07-15', 100),
    (16, 1, 200, '2023-08-10', 40),
    (17, 1, 800, '2023-08-20', 160),
    (18, 2, 200, '2023-09-10', 40),
    (19, 3, 30, '2023-07-15', 6),
    (20, 4, 10, '2023-07-30', 2),
    (21, 4, 40, '2023-08-05', 8),
    (22, 2, 5, '2023-08-20', 1),
    (23, 3, 100, '2023-08-25', 20),
    (24, 4, 10, '2023-09-05', 2),
    (25, 1, 30, '2023-09-10', 6),
    (26, 1, 15, '2023-07-10', 3),
    (27, 1, 10, '2023-08-15', 2),
    (28, 2, 50, '2023-09-20', 10),
    (29, 3, 20, '2023-07-01', 4),
    (30, 4, 10, '2023-08-20', 2),
    (31, 1, 25, '2023-09-05', 5),
    (32, 1, 5, '2023-07-15', 1),
    (33, 2, 100, '2023-08-25', 20),
    (34, 3, 20, '2023-09-01', 4),
    (35, 4, 30, '2023-07-10', 6),
    (36, 1, 50, '2023-08-20', 10),
    (37, 2, 10, '2023-09-05', 2),
    (38, 3, 30, '2023-07-05', 6),
    (39, 4, 10, '2023-07-15', 2),
    (40, 1, 5, '2023-08-10', 1),
    (41, 1, 20, '2023-08-20', 4),
    (42, 1, 10, '2023-08-25', 2),
    (43, 2, 15, '2023-09-05', 3),
    (44, 3, 5, '2023-09-10', 1),
    (45, 4, 80, '2023-07-01', 16),
    (46, 1, 20, '2023-07-10', 4),
    (47, 2, 10, '2023-08-15', 2),
    (48, 1, 50, '2023-09-20', 10),
    (49, 2, 5, '2023-07-05', 1),
    (50, 3, 30, '2023-07-15', 6);

insert into customer (name, email, phone, address, visit_count, rewards_points) values 
 ('Ruth Lawles', 'rlawles0@seattletimes.com', '5921508750', '1693 Atwood Trail', 1, 44.9),
 ('Mersey Roller', 'mroller1@wikispaces.com', '4985745753', '21472 Fisk Crossing', 2, 108.06),
 ('Hildegaard Fawdry', 'hfawdry2@yolasite.com', '5268053265', '9 Riverside Parkway', 3, 62.65),
 ('Tades Solly', 'tsolly3@gravatar.com', '2719821318', '68418 American Lane', 4, 12.86),
 ('Rycca Banaszewski', 'rbanaszewski4@reddit.com', '9029815205', '8502 Clyde Gallagher Park', 5, 39.14),
 ('Karee Cummine', 'kcummine5@mapy.cz', '9995455220', '155 Birchwood Hill', 6, 68.18),
 ('Bondy Eggleson', 'beggleson6@sciencedaily.com', '3941144811', '6095 Forster Drive', 7, 143.18),
 ('Natalie Allardyce', 'nallardyce7@fastcompany.com', '6187581464', '8894 Moulton Alley', 8, 16.68),
 ('Levi Aleksidze', 'laleksidze8@slashdot.org', '4756678751', '12 Tony Park', 9, 139.59),
 ('Louisa Saffin', 'lsaffin9@time.com', '5941946586', '7 Warbler Way', 10, 91.55),
 ('Brigitta Corder', 'bcordera@google.es', '4468475060', '71 Delaware Place', 11, 59.1),
 ('Ryan Sawley', 'rsawleyb@canalblog.com', '6492502987', '2 Moose Lane', 12, 134.98),
 ('Letisha Pedden', 'lpeddenc@devhub.com', '7912229080', '1 Holy Cross Road', 13, 57.52),
 ('Sky Jannaway', 'sjannawayd@moonfruit.com', '8963624803', '2570 Golf View Trail', 14, 34.71),
 ('Pepi Ealam', 'pealame@google.co.jp', '9202071354', '6097 Erie Alley', 15, 26.32),
 ('Almeda Sowle', 'asowlef@ocn.ne.jp', '8352786190', '35 Forest Run Junction', 16, 72.48),
 ('Bride McParland', 'bmcparlandg@hatena.ne.jp', '9772622371', '2775 Stephen Hill', 17, 95.77),
 ('Mick Legate', 'mlegateh@tripadvisor.com', '3131136306', '5 Mesta Avenue', 18, 113.22),
 ('Brade Ferrino', 'bferrinoi@opensource.org', '3195673062', '8126 Lighthouse Bay Way', 19, 3.32),
 ('Richmound Guillford', 'rguillfordj@trellian.com', '2199275143', '34956 Graedel Terrace', 20, 38.58),
 ('Griz Karsh', 'gkarshk@oracle.com', '2264651162', '5453 Manufacturers Street', 21, 28.49),
 ('Allyce Halsall', 'ahalsalll@jalbum.net', '9934037108', '6 Lighthouse Bay Road', 22, 126.54),
 ('Danyelle Mico', 'dmicom@cdc.gov', '3937996317', '94509 Oneill Hill', 23, 148.89),
 ('Ariana Hengoed', 'ahengoedn@dion.ne.jp', '5079190954', '0 Hoard Court', 24, 31.03),
 ('Nichols Candey', 'ncandeyo@reuters.com', '3083019477', '00 Duke Street', 25, 98.57),
 ('Sutherland Juste', 'sjustep@tumblr.com', '1962699631', '9 Huxley Junction', 26, 138.61),
 ('Craig Flecknoe', 'cflecknoeq@disqus.com', '1113654214', '36332 Linden Place', 27, 138.82),
 ('Bell McGillecole', 'bmcgillecoler@infoseek.co.jp', '9194662963', '9907 North Plaza', 28, 4.8),
 ('Bartram D''Alessandro', 'bdalessandros@dailymotion.com', '5594993159', '3 Eagan Center', 29, 2.98),
 ('Tye Brookbank', 'tbrookbankt@oaic.gov.au', '3973885329', '3 5th Park', 30, 24.49),
 ('Durante Cable', 'dcableu@deliciousdays.com', '7715263186', '2 Holmberg Court', 31, 40.97),
 ('Delly Bobasch', 'dbobaschv@irs.gov', '4681849719', '426 Muir Court', 32, 20.08),
 ('Katey Maddison', 'kmaddisonw@goo.ne.jp', '9533359639', '43 Annamark Alley', 33, 22.31),
 ('Lotta Bigrigg', 'lbigriggx@wunderground.com', '3189193913', '0796 Sachs Circle', 34, 61.17),
 ('Rhys Banaszczyk', 'rbanaszczyky@youtube.com', '7798215611', '540 David Trail', 35, 72.54),
 ('Teresina Hill', 'thillz@examiner.com', '1143376907', '3098 Stoughton Trail', 36, 35.45),
 ('Laurent Blann', 'lblann10@google.com.hk', '8651209978', '8769 Messerschmidt Terrace', 37, 134.1),
 ('Garwood Rothman', 'grothman11@wired.com', '5069606418', '6507 Westerfield Pass', 38, 14.81),
 ('Kelley Bend', 'kbend12@digg.com', '6299322810', '28 Memorial Lane', 39, 52.81),
 ('Porty Blitzer', 'pblitzer13@ucoz.ru', '4228422022', '60718 Swallow Center', 40, 47.23),
 ('Ivor Keesman', 'ikeesman14@hugedomains.com', '2325980038', '9499 Sauthoff Lane', 41, 146.84),
 ('Jeremie Yakutin', 'jyakutin15@upenn.edu', '1194535207', '72 Moland Alley', 42, 115.11),
 ('Jessica Robeson', 'jrobeson16@blogger.com', '1497335402', '90 Drewry Court', 43, 7.25),
 ('Corissa Varty', 'cvarty17@stanford.edu', '3918785556', '24060 Continental Drive', 44, 52.83),
 ('Maynord Nafziger', 'mnafziger18@noaa.gov', '3941403854', '84187 Crownhardt Road', 45, 68.69),
 ('Fowler Chantler', 'fchantler19@angelfire.com', '9981381006', '184 Texas Court', 46, 55.48),
 ('Saundra Dalley', 'sdalley1a@storify.com', '2151480487', '092 Becker Court', 47, 4.88),
 ('Emalia Ciraldo', 'eciraldo1b@over-blog.com', '4885673236', '3855 Warrior Circle', 48, 70.64),
 ('Jarrett Jacobsz', 'jjacobsz1c@trellian.com', '9014690516', '203 Katie Place', 49, 88.74),
 ('Isabelita Dellenbrok', 'idellenbrok1d@pen.io', '5874860029', '28 Mcguire Street', 50, 99.39),
 ('Trix Fenge', 'tfenge1e@altervista.org', '7331421287', '88 Vera Terrace', 51, 115.09),
 ('Netty Merrigan', 'nmerrigan1f@guardian.co.uk', '6335843720', '5488 Gina Terrace', 52, 76.09),
 ('Zondra Pummell', 'zpummell1g@ebay.co.uk', '7537427095', '7038 Mesta Road', 53, 110.7),
 ('Rodolph Winwright', 'rwinwright1h@uol.com.br', '2505456297', '9 Springview Circle', 54, 32.28),
 ('Roberta Rimbault', 'rrimbault1i@mapquest.com', '9749216834', '71 Daystar Trail', 55, 38.75),
 ('Lin Cribbins', 'lcribbins1j@webnode.com', '2029129746', '4 Warner Trail', 56, 5.01),
 ('Gerhard Wride', 'gwride1k@w3.org', '7364888664', '0108 Everett Lane', 57, 100.37),
 ('Selestina Shakelade', 'sshakelade1l@forbes.com', '8741186909', '36 Charing Cross Court', 58, 29.0),
 ('Alphonso Float', 'afloat1m@shareasale.com', '1569385197', '17657 Vera Center', 59, 71.12),
 ('Malchy Kubec', 'mkubec1n@ftc.gov', '1957764006', '4 Mccormick Center', 60, 65.93);


INSERT INTO sales_history (customer_id, cashier_id, datetime, total_payment, payment_method_id)
VALUES
    ( 1, 38, '2022-03-15 10:30:00', 100.00, 1),
    ( 2, 39, '2022-04-20 14:45:00', 75.50, 2),
    ( 3, 40, '2022-05-10 16:20:00', 200.75, 1),
    ( 4, 41, '2022-06-05 11:15:00', 50.25, 3),
    ( 5, 42, '2022-07-12 09:40:00', 25.00, 2),
    ( 6, 43, '2022-08-18 17:05:00', 75.75, 1),
    ( 7, 44, '2022-09-25 13:55:00', 300.00, 4),
    ( 8, 45, '2022-10-30 19:10:00', 200.50, 1),
    ( 9, 38, '2022-11-08 08:00:00', 100.25, 2),
    ( 10, 39, '2022-12-12 12:25:00', 375.75, 4),
    ( 11, 40, '2023-01-05 15:15:00', 450.00, 1),
    ( 12, 41, '2023-02-20 10:50:00', 250.00, 3),
    ( 13, 42, '2023-03-22 14:30:00', 100.00, 2),
    ( 14, 43, '2023-04-15 16:55:00', 200.50, 1),
    ( 15, 44, '2023-05-10 11:45:00', 50.25, 3),
    ( 16, 45, '2023-06-28 09:20:00', 25.00, 2);


INSERT INTO cart (transaction_number, product_id, quantity,  total_amount, date, status)
VALUES
    (1, 1, 3,  90.00, '2022-03-15 10:30:00', 'SOLD'),
    (1, 2, 2,  95.00, '2022-03-15 10:30:30', 'SOLD'),
    (1, 3, 1, 50.00, '2022-03-15 10:31:00', 'SOLD'),
    (2, 4, 2, 64.18, '2022-04-20 14:45:00', 'SOLD'),
    (2, 5, 5,  33.25, '2022-04-20 14:45:20', 'SOLD'),
    (3, 6, 1,  180.72, '2022-05-10 16:20:00', 'SOLD'),
    (3, 7, 3,  300.00, '2022-05-10 16:20:10', 'SOLD'),
    (4, 8, 4,  47.74, '2022-06-05 11:15:00', 'SOLD'),
    (4, 9, 2,90.00, '2022-06-05 11:16:00', 'SOLD'),
    (5, 10, 1,  25.00, '2022-07-12 09:40:00', 'SOLD'),
    (6, 11, 2,  71.96, '2022-08-18 17:05:00', 'SOLD'),
    (6, 12, 3, 75.75, '2022-08-18 17:05:50', 'SOLD'),
    (7, 13, 4,  270.00, '2022-09-25 13:55:00', 'SOLD'),
    (8, 14, 5,  170.42, '2022-10-30 19:10:00', 'SOLD'),
    (9, 15, 1, 100.25, '2022-11-08 08:00:00', 'SOLD'),
    (10, 16, 2,  357.96, '2022-12-12 12:24:00', 'SOLD'),
    (10, 17, 3,  270.00, '2022-12-12 12:25:00', 'SOLD'),
    (11, 18, 4,  450.00, '2023-01-05 15:15:00', 'SOLD'),
    (12, 19, 5,  237.50, '2023-02-20 10:50:00', 'SOLD'),
    (13, 20, 1,  100.00, '2023-03-22 14:30:00', 'SOLD'),
    (14, 21, 2,  200.50, '2023-04-15 16:55:00', 'SOLD'),
    (15, 22, 3,  47.74, '2023-05-10 11:44:00', 'SOLD'),
    (15, 23, 4,  90.00, '2023-05-10 11:45:00', 'SOLD'),
    (16, 24, 5,  25.00, '2023-06-28 09:20:00', 'SOLD');