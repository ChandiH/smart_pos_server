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

INSERT INTO user_access (role_id, access_type_id) --change access type id into array
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



INSERT INTO payment_method (payment_method_name)
VALUES 
    ('Cash'),
    ('Credit Card'),
    ('Debit Card'),
    ('Mobile Money');

INSERT INTO discount (discount_name , discount_desc , discount_percentage)
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

INSERT INTO branch ( branch_city, branch_address ,branch_phone,branch_email )
VALUES
    ('Colombo', '123 Main St, Colombo 01', '112233445', 'colombobranch@example.com'),
    ('Kandy', '456 Elm St, Kandy 20000', '814325678', 'kandybranch@example.com'),
    ('Galle', '789 Oak St, Galle 80000', '912345678',  'gallebranch@example.com'),
    ( 'Anuradhapura', '789 Pine St, Anuradhapura 50000', '762345678', 'anuradhapurabranch@example.com');


INSERT INTO supplier ( supplier_name ,supplier_email ,supplier_phone ,supplier_address )
VALUES
    ('Mega Suppliers Inc.', 'mega@suppliers.lk', '666765678', '345 Cinnamon St, Colombo 02'),
    ('Global Imports Co.', 'info@globalico.lk', '911234567', '789 Ruby St, Ratnapura 70000'),
    ('Superior Distributors Ltd.','info@sdistributors.lk', '444555666', '567 Timber St, Baduraliya 80200'),
    ('Prime Wholesale Supplies', 'sales@prime.lk', '333444555', '432 Cocoa St, Matale 80050'),
    ('Best Buy Traders', 'info@bestbuyt.lk', '888999000', '876 Tea Gardens, Nuwara Eliya 22250'),
    ( 'Quality Goods Exporters', 'info@qgexporters.lk', '777999888', '654 Timber St, Kalutara 12000')
    ;



INSERT INTO employee (employee_name, role_id, hired_date, employee_email, employee_phone, branch_id)
VALUES
    ('Somesh Chandimal', 1, '2022-01-15', 'somesh@example.com', '112233445', 1),
    ('John Doe',  2, '2022-05-15', 'johndoe@example.com', '112233445', 1),
    ('Jane Smith',  2, '2021-12-10', 'janesmith@example.com', '998877665', 2),
    ('Robert Johnson',  2, '2023-02-28', 'robertjohnson@example.com', '777766655', 3),
    ('Mary Wilson', 2, '2022-09-30', 'marywilson@example.com', '333444555', 4),
    ('Michael Lee',  3, '2020-07-05', 'michaellee@example.com', '222555444', 1),
    ('Lisa Garcia', 3, '2021-10-20', 'lisagarcia@example.com', '666555444', 2),
    ('David Martinez',  3, '2022-04-15', 'davidmartinez@example.com', '777444555', 3),
    ('Sarah Brown', 3, '2021-03-25', 'sarahbrown@example.com', '555444333', 4),
    ('William Smith',  4, '2022-01-05', 'williamsmith@example.com', '777888999', 1),
    ('Karen Davis',  4, '2023-06-30', 'karendavis@example.com', '444555666', 1),
    ('James Taylor',  4, '2022-08-15', 'jamestaylor@example.com', '555747888', 1),
    ('Jennifer Clark',  4, '2021-11-10', 'jenniferclark@example.com', '999888777', 2),
    ('Joseph Johnson', 4, '2023-01-15', 'josephjohnson@example.com', '555666777', 2),
    ('Nancy Moore',  4, '2021-04-20', 'nancymoore@example.com', '444666555', 2),
    ('Robert White',  4, '2020-11-05', 'robertwhite@example.com', '333777666', 3),
    ('Linda Harris', 4, '2022-02-28', 'lindaharris@example.com', '222777888', 3),
    ('John Miller',  4, '2023-03-10', 'johnmiller@example.com', '444555444', 3),
    ('Patricia Garcia',  4, '2022-07-01', 'patriciagarcia@example.com', '777555444', 4),
    ('Robert Brown',  4, '2020-12-25', 'robertbrown@example.com', '666444555', 4);



INSERT INTO user_credentials (user_id,username, password) 
VALUES
(1, 'somesh', crypt('1111',gen_salt('bf'))),
(2,'johndoe', crypt('password1',gen_salt('bf'))),
(3,'janesmith', crypt('password2',gen_salt('bf'))),
(4,'robertjohnson', crypt('password3',gen_salt('bf'))),
(5,'marywilson', crypt('password4',gen_salt('bf'))),
(6,'michaellee', crypt('password5',gen_salt('bf'))),
(7,'lisagarcia', crypt('password6',gen_salt('bf'))),
(8,'davidmartinez', crypt('password7',gen_salt('bf'))),
(9,'sarahbrown', crypt('password8',gen_salt('bf'))),
(10,'williamsmith', crypt('password9',gen_salt('bf'))),
(11,'karendavis', crypt('password10',gen_salt('bf'))),
(12,'jamestaylor', crypt('password11',gen_salt('bf'))),
(13,'jenniferclark', crypt('password12',gen_salt('bf'))),
(14,'josephjohnson', crypt('password13',gen_salt('bf'))),
(15,'nancymoore', crypt('password14',gen_salt('bf'))),
(16,'robertwhite', crypt('password15',gen_salt('bf'))),
(17,'lindaharris', crypt('password16',gen_salt('bf'))),
(18,'johnmiller', crypt('password17',gen_salt('bf'))),
(19,'patriciagarcia', crypt('password18',gen_salt('bf'))),
(20,'robertbrown', crypt('password19',gen_salt('bf')))
;




INSERT INTO category (category_name)
VALUES
   ('Biscuits'),
   ('Snacks'),
   ('Beverages'),
   ('Rice and Grains'),
   ('Cooking Ingrediants'),
   ('Dental Care'),
   ('Stationary/Books');


INSERT INTO product (product_name, product_desc, category_id,
 product_image, buying_price, retail_price, discount, supplier_id, product_barcode, created_at)
VALUES
    ('Munchee Cream Cracker 100g', 'Delicious cream cracker biscuits from Munchee. Ideal for snacking.', 1,
     '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}',50.00, 70.00,1.00, 1, '1234-5678', '2022-03-10'),
    ('Maliban Potato Cracker 110g','Delcios cracker in potatoe falvour',1,
    '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}', 60.00, 70.00, 1.00,2, '2341-5678', '2022-03-10'),
    ('Maliban Lemon Puff 200g', 'Delicious lemon puff biscuits from Maliban. Ideal for snacking.', 1,
    '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}', 100.00, 120.00, 1.00, 2, '3456-1812', '2022-03-10'),
    ('Doritos Cool Ranch Tortilla Chips','Delicious tortilla chips from Doritos. Ideal for snacking.', 2,  
    '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}', 150.00, 200.00, 1.00, 3, '4567-8123', '2022-03-10'),
    ( 'Pringles Original Potato Crisps ','Delicious potato crisps from Pringles. Ideal for snacking.', 2,
    '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}', 240.00, 210.00, 1.00, 4, '5678-1235', '2022-03-10'),
    ( 'Coca-Cola 1.5L',  'Refreshing cola drink from Coca-Cola. Ideal for quenching your thirst.', 3,
        '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}', 200.00, 220.00, 1.00, 5, '6781-2346', '2022-03-10'),
    ('Sprite 1.5L', 'Refreshing lemon-lime drink from Sprite. Ideal for quenching your thirst.', 3,
        '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}', 150.00, 230.00, 2.00, 6, '7812-3446', '2022-03-10'),
    ('Fanta 1.5L', 'Refreshing orange drink from Fanta. Ideal for quenching your thirst.', 3,
        '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}', 200.00, 250.00, 1.00, 1, '8123-4561', '2022-03-10'),
    ('Carl White Rice 1kg', 'High-quality white rice from Carl. Ideal for cooking.', 4,
        '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}', 180.00, 180.00, 1.00, 2, '1234-5644', '2022-03-10'),
    ('Red Rice 1kg', 'High-quality red rice from Carl. Ideal for cooking.', 4,
        '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}', 200.00, 300.00, 1.00, 3, '1345-6781', '2022-03-10'),
    (' Basmati Rice 1kg', 'High-quality basmati rice from Carl. Ideal for cooking.', 4,
        '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}', 510.00, 600.00, 1.00, 6, '3456-2812', '2022-03-10'),
    (' Milk 400ml', 'High-quality coconut milk . Ideal for cooking.', 5,
        '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}',360.00, 475.00, 1.00, 5, '8812-3456', '2022-03-10'),
    ('Coconut Oil 500ml', 'High-quality coconut oil from Carl. Ideal for cooking.', 5,
        '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}',220.00, 360.00, 1.00, 6, '8123-4567', '2022-03-10'),
    ('Carl Coconut Vinegar 500ml', 'High-quality coconut vinegar from Carl. Ideal for cooking.', 5,
        '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}',200.00, 225.00, 1.00, 4, '1234-1678', '2022-03-10'),
    ('Colgate Toothpaste 100g', 'Colgate toothpaste for healthy teeth and gums.', 6,
        '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}', 180.00, 190.00, 1.00, 1, '2345-6781', '2022-03-10'),
    ('Colgate one Toothbrush packet ', 'Colgate toothbrush for healthy teeth and gums.', 6,
        '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}',120.00, 200.00, 1.00, 3, '3456-7812', '2022-03-10'),
    ('Colgate Mouthwash 500ml', 'Colgate mouthwash for healthy teeth and gums.', 6,
        '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}',160.00, 320.00, 1.00, 4, '4567-9123', '2022-03-10'),
    ('Parker Pen 12 set', 'Parker pen for writing.', 7,
        '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}',700.00, 850.00, 1.00, 5, '5678-1234', '2022-03-10'),
    ('A4 Paper 400 Packet', 'A4 paper for writing.', 7,
        '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}',800.00, 1250.00, 1.00, 6, '6781-2345', '2022-03-10'),
    ('Pencil 24 set', 'Pencil for writing.', 7,
        '{"https://placehold.co/600x400.png","https://placehold.co/300x400.png","https://placehold.co/200x200.png"}',100.00, 450.00, 1.00, 5, '7812-3456', '2022-03-10') ;

    
INSERT INTO inventory (product_id, branch_id, quantity,updated_on,  reorder_level)
VALUES
    (1, 1, 500, '2023-07-05 10:00:00', 100),
    (1, 2, 500, '2023-07-05 11:00:00', 100),
    (1, 3, 300, '2023-07-10 11:00:00', 50),
    (2, 1, 200, '2023-08-01 10:00:00', 30),
    (2 ,3, 150, '2023-08-01 10:01:00', 20),
    (2, 4, 100, '2023-08-01 10:02:00',15),
    (4, 4, 100, '2023-09-05 10:00:00', 20),
    (5, 1, 400, '2023-07-15 10:00:00', 80),
    (6, 2, 250, '2023-08-25 10:00:00', 40),
    (7, 3, 300, '2023-09-10 10:00:00', 60),
    (8, 4, 500, '2023-07-01 10:00:00', 100),
    (9, 1, 1000, '2023-08-20 10:00:00', 200),
    (10, 1, 400, '2023-09-01 10:00:00', 80),
    (11, 1, 300, '2023-07-10 10:00:00', 60),
    (12, 2, 250, '2023-08-15 10:00:00', 50),
    (13, 3, 300, '2023-09-20 10:00:00', 60),
    (14, 4, 600, '2023-07-05 10:00:00', 120),
    (15, 2, 500, '2023-07-15 10:00:00', 100),
    (16, 1, 200, '2023-08-10 10:00:00', 40),
    (17, 1, 800, '2023-08-20 10:00:00', 160),
    (18, 2, 200, '2023-09-10 10:00:00', 40),
    (19, 3, 30, '2023-07-15 10:00:00', 6),
    (20, 4, 10, '2023-07-30 10:00:00', 2),
     (3, 1, 500, '2023-07-05 10:00:00', 100),
    (3, 2, 500, '2023-07-05 10:00:00', 100),
    (2, 2, 300, '2023-07-10 10:00:00', 50),
    (3, 3, 200, '2023-08-01 10:00:00', 30),
    (4, 1, 100, '2023-09-05 10:00:00', 20),
    (5, 2, 400, '2023-07-15 10:00:00', 80),
    (6, 3, 250, '2023-08-25 10:00:00', 40),
    (7, 4, 300, '2023-09-10 10:00:00', 60),
    (8, 1, 500, '2023-07-01 10:00:00', 100),
    (9, 2, 1000, '2023-08-20 10:00:00', 200),
    (10, 3, 400, '2023-09-01 10:00:00', 80),
    (11, 2, 300, '2023-07-10 10:00:00', 60),
    (12, 4, 250, '2023-08-15 10:00:00', 50),
    (13, 2, 300, '2023-09-20 10:00:00', 60),
    (14, 1, 600, '2023-07-05 10:00:00', 120),
    (15, 1, 500, '2023-07-15 10:00:00', 100),
    (16, 3, 200, '2023-08-10 10:00:00', 40),
    (17, 3, 800, '2023-08-20 10:00:00', 160),
    (18, 3, 200, '2023-09-10 10:00:00', 40),
    (19, 4, 30, '2023-07-15 10:00:00', 6),
    (20, 3, 10, '2023-07-30 10:00:00', 2)
   ;

insert into customer (customer_name ,customer_email ,customer_phone ,customer_address ,
visit_count ,rewards_points ) values 
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
 ('Fowler Chantler', 'fchantler19@angelfire.com', '9981381006', '184 Texas Court', 46, 55.48)
;


INSERT INTO sales_history (customer_id, cashier_id, created_at, total_amount, payment_method_id,reference_ID)
VALUES
    ( 1, 10, '2023-08-15 10:30:00', 100.00, 1,null),
    ( 2, 10, '2023-08-15 14:45:00', 75.50, 2,'12485'),
    ( 3, 11, '2023-08-20 16:20:00', 200.75, 1,null),
    ( 4, 12, '2023-08-25 11:15:00', 50.25, 3,'15485'),
    ( 5, 13, '2023-08-25 09:40:00', 25.00, 1,null),
    ( 6, 13, '2023-08-31 17:05:00', 75.75, 1,null),
    ( 7, 11, '2023-09-01 13:55:00', 300.00, 1,null),
    ( 8, 15, '2023-09-01 19:10:00', 200.50, 1,NULL),
    ( 9, 16, '2023-09-02 08:00:00', 100.25, 2,'55825'),
    ( 10, 19, '2023-09-05 12:25:00', 375.75, 1,null),
    ( 11, 10, '2023-09-05 15:15:00', 450.00, 1,null),
    ( 12, 19, '2023-09-10 10:50:00', 250.00, 1,null),
    ( 13, 17, '2023-09-12 14:30:00', 100.00, 1,null),
    ( 14, 18, '2023-09-15 16:55:00', 200.50, 1,null);


INSERT INTO cart (order_id, product_id, quantity,  sub_total_amount, created_at)
VALUES
    (1, 1, 3,  90.00, '2023-08-15 10:30:00'),
    (1, 2, 2,  95.00, '2023-08-15 10:30:30'),
    (1, 3, 1, 50.00, '2023-08-15 10:31:00'),
    (2, 4, 2, 64.18, '2023-08-15 14:45:00'),
    (2, 5, 5,  33.25, '2023-08-15 14:45:20'),
    (3, 6, 1,  180.72, '2023-08-20 16:20:00'),
    (3, 7, 3,  300.00, '2023-08-20 16:20:10'),
    (4, 8, 4,  47.74, '2023-08-25 11:15:00'),
    (4, 9, 2,90.00, '2023-08-25 11:16:00'),
    (5, 10, 1,  25.00, '2023-08-25 09:40:00'),
    (6, 11, 2,  71.96, '2023-08-31 17:05:00'),
    (6, 12, 3, 75.75, '2023-08-31 17:05:50'),
    (7, 13, 4,  270.00, '2023-09-01 13:55:00'),
    (8, 14, 5,  170.42, '2023-09-01 19:10:00'),
    (9, 15, 1, 100.25, '2023-09-02 08:00:00'),
    (10, 16, 2,  357.96, '2023-09-05 12:24:00'),
    (10, 17, 3,  270.00, '2023-09-05 12:25:00'),
    (11, 18, 4,  450.00, '2023-09-05 15:15:00'),
    (12, 19, 5,  237.50, '2023-09-10 10:50:00'),
    (13, 20, 1,  100.00, '2023-09-12 14:30:00'),
    (14, 11, 2,  200.50, '2023-09-15 16:55:00');