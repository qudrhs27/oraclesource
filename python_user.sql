CREATE TABLE author
(
  author_id   NUMBER(10)   NOT NULL,
  author_name VARCHAR2(50) NOT NULL,
  CONSTRAINT PK_author PRIMARY KEY (author_id)
);

CREATE TABLE book
(
  book_id     NUMBER(10) NOT NULL,
  title       VARCHAR2   NOT NULL,
  price       NUMBER(8)  NOT NULL,
  stock_qty   NUMBER(10) NOT NULL,
  category_id NUMBER(10) NOT NULL,
  CONSTRAINT PK_book PRIMARY KEY (book_id)
);

CREATE TABLE book_author
(
  book_id   NUMBER(10) NOT NULL,
  author_id NUMBER(10) NOT NULL,
  CONSTRAINT pk_book_author PRIMARY KEY (book_id,author_id)
);

CREATE TABLE category
(
  category_id   NUMBER(10)   NOT NULL,
  category_name VARCHAR2(50) NOT NULL,
  CONSTRAINT PK_category PRIMARY KEY (category_id)
);

CREATE TABLE Member
(
  member_id VARCHAR2(10)  NOT NULL,
  name      VARCHAR2(50)  NOT NULL,
  email     VARCHAR2(100) NOT NULL,
  phone     VARCHAR2(20) ,
  joined_at DATE          NOT NULL,
  CONSTRAINT PK_Member PRIMARY KEY (member_id)
);

CREATE TABLE order_detail
(
  quantity   NUMBER(10) NOT NULL,
  sale_price NUMBER(10) NOT NULL,
  order_id   NUMBER(10) NOT NULL,
  book_id    NUMBER(10) NOT NULL,
  CONSTRAINT pk_order_book PRIMARY KEY (order_id,book_id)
);

CREATE TABLE orders
(
  order_id   NUMBER(10)   NOT NULL,
  order_date DATE        ,
  status     VARCHAR2(20),
  member_id  NUMBER(10)  ,
  member_id  VARCHAR2(10) NOT NULL,
  CONSTRAINT PK_orders PRIMARY KEY (order_id)
);

ALTER TABLE orders
  ADD CONSTRAINT FK_Member_TO_orders
    FOREIGN KEY (member_id)
    REFERENCES Member (member_id);

ALTER TABLE book
  ADD CONSTRAINT FK_category_TO_book
    FOREIGN KEY (category_id)
    REFERENCES category (category_id);

ALTER TABLE book_author
  ADD CONSTRAINT FK_book_TO_book_author
    FOREIGN KEY (book_id)
    REFERENCES book (book_id);

ALTER TABLE book_author
  ADD CONSTRAINT FK_author_TO_book_author
    FOREIGN KEY (author_id)
    REFERENCES author (author_id);

ALTER TABLE order_detail
  ADD CONSTRAINT FK_orders_TO_order_detail
    FOREIGN KEY (order_id)
    REFERENCES orders (order_id);

ALTER TABLE order_detail
  ADD CONSTRAINT FK_book_TO_order_detail
    FOREIGN KEY (book_id)
    REFERENCES book (book_id);