# はじめに

# MySQL と PostgreSQL の起動

## Docker を起動する方法
1. Docker イメージを作成して起動
```shell script
$ cd ./src/docker
$ docker build -t customer-db:v1 -f Dockerfile.postgresql .
$ docker build -t address-db:v1 -f Dockerfile.mysql .
$ docker run -it -p 5432:5432 --rm customer-db:v1
$ docker run -it -p 3306:3306 --rm address-db:v1
```

2. DockerHub にあるイメージ使って起動
```shell script
$ docker run -it -p 5432:5432 --rm kkosugiredhat/customer-db:v1
$ docker run -it -p 3306:3306 --rm kkosugiredhat/address-db:v1
```

## Teiid SpringBoot の起動
1. Teiid SpringBoot のビルドと jar 
```shell script
$ ./mvnw clean package
```
1. Teiid SpringBoot の起動
```shell script
$ ./mvnw spring-boot:run
```

## OData へのアクセス
1. ブラウザの起動
2. 以下のアドレスへアクセス
  - OData の MetaData
    - http://localhost:8080/odata/$metadata
  - Postgresql から取り込んだスキーマ
    - http://localhost:8080/odata/postgresql_schema/CUSTOMER
  - MySLQL から取り込んだスキーマ
    - http://localhost:8080/odata/mysql_schema/ADDRESS
　- 上記二つを結合した新しい portfolio スキーマ
    - http://localhost:8080/odata/portfolio/CustomerZip
    - http://localhost:8080/odata/portfolio/CustomerZip(10)

## JDBC でアクセス
1. Data Gip (あれば)で以下の url にアクセス
```shell script
jdbc:teiid:customer.1@mm://<ip>:31000
```
1. 以下のようなスキーマが見えること
[](./image/1.png)
1. テーブルの中身は Customer(Postgresql) と Address(MySQL) の結合したもの
[](./image/2.png)