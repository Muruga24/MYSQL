create database event_management_system;
use event_management_system;

create table Event_details(Event_id int primary key auto_increment,
Event_name varchar(250),
Event_date date,
Location varchar(250),  
Descriptions text);

insert into Event_details values(1,"Madras week","2024-10-2","Chennai,Tamilnadu","A week along celebration focusing on the history and heritage of chennai");
insert into Event_details values(2,"International Film Festival of India","2024-10-15","goa,India","Held annually in goa showcasing international and indian films");
insert into Event_details values(3,"India Art fair","2024-11-3","New Delhi,India","An annual art fair in delhi showcasing contemproary art from india");
insert into Event_details values(4,"Chennai music season","2024-12-18","Chennai,India","A major event in chennai showcasing classical music and dance perfornmances");
insert into Event_details values(5,"Marathon And Runs","2025-1-2","Mumbai,India","various city marathons and fun runs");
insert into Event_details values(6,"Sunburn Festival","2025-1-15","Goa,India","High energy outdoor festival celebrating summer with live music");
insert into Event_details values(7,"workshop series","2025-1-20","Trichy,India","community centers,educational instituition or co-working spaces with meeting rooms");
insert into Event_details values(8,"Music Of India","2025-2-5","kerala,India","An evening featuring performances by renowned indian musicians");

select * from event_details;

Create table Ticket(Ticket_id int primary key,
Ticket_Type varchar(100),
Price int,
Seat_no int,
Status_of_Ticket varchar(100));

insert into Ticket values(1,"Standard",150,10,"Booked");
insert into Ticket values(2,"Premium",250,2,"used");
insert into Ticket values(3,"Standard",120,9,"Booked");  
insert into Ticket values(4,"Strandard",90,20,"cancelled");
insert into Ticket values(5,"Premium",290,1,"Booked");
insert into Ticket values(6,"Standard",110,15,"Booked");  
insert into Ticket values(7,"premium",350,3,"used");
insert into Ticket values(8,"premium",300,5,"cancelled");
select * from ticket;

create table Attendee(Attendee_id int primary key,
First_name varchar(100),
Last_name varchar(100),
Email Varchar(250),
Phone_no Varchar(15));

insert into Attendee values(1,"S","Muruga","MurugaBharathi@gmail.com","8072001769");
insert into Attendee values(2,"v","arun","Arunkumar@gmail.com","9987654567");
insert into Attendee values(3,"H","Ajith","Ajith@gmail.com","8675903453");
insert into Attendee values(4,"S","Vijay","VIjay@gmail.com","6754568806");
insert into Attendee values(5,"V","Virat","Viratkohli@gmail.com","7896543567");
insert into Attendee values(6,"Ms","Dhoni","Msd@gmail.com","765890435");
insert into Attendee values(7,"S","Surya","Surya@gmail.com","8907654678");
insert into Attendee values(8,"s","Vikram","Vikram@gmail.com","9876780765");

select * from attendee;

create table Sponsors(Sponsors_id int primary key,
Sponsors_name Varchar(200),
Contribution_amount int,
Sponsor_Level Varchar(50),
Contact_info Varchar(15));

insert into Sponsors values(1,"ITC limited",50000,"silver","6789054678");
insert into Sponsors values(2,"Netflix",100000,"Gold","8769045678");
insert into Sponsors values(3,"Tcs",200000,"gold","9870987698");
insert into Sponsors values(4,"Music Academy",80000,"silver","7890878656");
insert into Sponsors values(5,"Nike",30000,"Bronze","7890678675");
insert into Sponsors values(6,"Hdfc",100000,"Gold","6789876567");
insert into Sponsors values(7,"Tech Innovators",60000,"silver","876906764");
insert into Sponsors values(8,"Music Academy",20000,"Bronze","7890678654");

select * from sponsors;
use event_management_system;
Create table Payment(Payment_id int primary key,
Amount int,
Transaction_id Varchar(50), 
Payment_mode Varchar(20),
Status_of_Payment Varchar(50));

insert into Payment values(1,150,"xy2345234zZ","Gpay","Recieved");
insert into Payment values(2,250,"ab23456782Z","Phonepe","Recieved");
insert into Payment values(3,120,"a8765489bc2","Paytm","Recieved");
insert into Payment values(4,90,"xy76676767z","Gpay","Not Recieved");
insert into Payment values(5,290,"xy7543784zZ","phonepe","Recieved");
insert into Payment values(6,110,"xy3146365zZ","Gpay","Recieved");
insert into Payment values(7,350,"xy2345675zZ","Paytm","Recieved");
insert into Payment values(8,300,"xy4564324zZ","phonepe","Not Recieved");

select * from payment;

select a.Event_id,a.Event_name,a.Event_date,a.Location,b.Ticket_type,b.Price,c.First_name,c.Last_name,c.Phone_no,d.Transaction_id,d.Payment_mode,
e.Sponsors_name,e.Contribution_Amount,e.Sponsor_Level
from Event_details as a
inner join Ticket as b on
a.Event_id=b.Ticket_id
inner join Attendee as c on  
b.Ticket_id=c.Attendee_id
inner join Payment as d on  
c.Attendee_id=d.Payment_id
inner join Sponsors as e on
d.Payment_id=e.Sponsors_id;

-- using select and where  conditions
select * from event_details where event_name="india art fair" and location="new delhi,india";
-- finding top spending attendee
select l.last_name,sum(a.amount) as total_spent
from attendee l
join payment a on 
l.attendee_id = a.payment_id
group by l.last_name
order by total_spent desc;

-- find upcoming events
select event_id,event_name,event_date
from event_details where event_date>current_date;

-- events attended by specific attendee
select e.event_name,e.event_date
from event_details e 
join attendee a on
e.event_id = a.attendee_id
where a.attendee_id=3;

-- using subquery
select event_name,event_date
from event_details
where event_id in (select ticket_id from ticket where status_of_ticket="booked");
