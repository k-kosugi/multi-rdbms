CREATE TABLE ADDRESS
(
  ID int PRIMARY KEY,
  STREET char(25),
  ZIP char(10),
  CUSTOMER_ID int
);

INSERT INTO ADDRESS (ID, STREET, ZIP, CUSTOMER_ID) VALUES (10, 'Main St', '12345', 10);
