# sap_exercise01
This is the SAP exercise which will be written by perl.

# Requirements
```notes
Perl exercises for Perl developers part 1
Please note that you are now a developer if you did the exercises or if you have already experience with Perl programming. In this case we need to start operating with the database. For this, please install Postgres in your local computer.
Create a Perl module which enables you to create, read, update and delete a virtual machine (CRUD operations) in the database. The goal here is to create an object that represents a virtual machine. Of course this is not a real virtual machine, only a Perl object with some properties and method. Don't use Moose for this exercise.
Create the same as above but instead of a virtual machine, do it as a storage.
Link these two objects so they can be displayed together, for example, the storage "sto1" is associated with virtual machine "vm1". If "vm1" is deleted, the storage "sto1" will be disassociated and be available to be attached to "vm2".
Create unit test for the created module.
Note: it's important to separate the module and the script to call the module because the module will have to be used by another application. Hint: think about MVC (model view controller)
Perl exercises for Perl developers part 2
Now that you have created the module, install apache.
Create a web application that uses the created module.
Add some CSS styling
Notes and hints
Object properties
    Properties of a storage object: name, capacity
        also add a primary key and create/update timestamp columns
    Properties of a server object: name, operating system, storage, checksum
    also add a primary key and create/update timestamp columns
    operating system should be a set of pre-defined values
    checksum should contain a md5 hash of relevant server object properties
    every server can only have a single related storage object but one storage can be related to multiple servers
Implementation
    Use plain Perl OOP, do not use libraries like Moose
    Do not use ORMs like DBIx::Class, but you can and should use database abstraction layers like DBI
    Implement database access via a single global database handler
    Learn about the MVC pattern and try to implement its basic concepts in your code (e.g. you could implement controller object(s) to handle and route all the incoming HTTP requests)
    Utilize a template system (HTML::Template, Template Toolkit)
    Try to validate at least one element of a form and show error messages instead of inserting faulty data into database
    Write at least one unit test to test parts of your code(Test::More)
    Use Git to keep your code under version control
```
