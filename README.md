#  Java_JDBC_Example_MySQL
> Accessing a relational database with Java and JDBC
 
This example shows how to connect to a (MySQL) DBMS in Java using the JDBC libraries and drivers. It also shows how to submit different SQL statemennts to the DBMS, including data insertion and update queries, selection queries, procedure and function calls, with and without transaction support.

## Usage

This is a *sample application* developed during the lectures of the  [**Laboratorio di Basi di Dati course**](https://laboratoriobasididati-univaq.github.io). The code is organized to best match the lecture topics and examples. It is not intended for production use and is not optimized in any way. 

*This example code will be shown and described approximately during the 22nd lecture of the course, so wait to download it, since it may get updated in the meanwhile.*

## Installation

This is a Maven-based project. Simply download the code and open it in any Maven-enabled IDE such as Netbeans or Eclipse. 
Since this example uses a MySQL database, you need a working instance of **MySQL version 8 or above**. The application is able to create and
populate/reset the database before running the example queries. The creation and population scripts are in the resources folder. 
However, you always need to manually create the database schema and the database user as indicated in the code. The main application
class contains three boolean switches that can be used to control this behaviour.

 
---

![University of L'Aquila](https://www.disim.univaq.it/skins/aqua/img/logo2021-2.png)

 
