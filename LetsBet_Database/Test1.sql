
#Insert into User Set UserName = '阿啊啊';

#Select * From Bets;
#Insert into User Value(1,2,3,4);
/*
Select * From
	User as A Inner join User_has_Bets as B On A.Name = B.User_Name
	Inner join Bets As C On B.Bets_idBets = C.idBets;
*/


#call QueryBets('9',0,1);
/*
Create temporary table tmptable as 
	Select * From
	(User as A Inner join User_has_Bets as B On A.UserName = B.User_Name
	Inner join Bets As C On B.Bets_idBets = C.idBets) Where finish = 0;
#select * from tmptable;
select * from tmptable where UserName != '9';*/
#drop table tmptable;
#call QueryBets('9;',1,1);

#Update User_has_Bets SET Vote = 1 Where Bets_idBets = 3;
#Insert into User_has_Bets SET User_Name = '3222', Bets_idBets = 1;
#Update Bets SET Confirm = 0 Where idBets = 2;
#call UpdateConfirm(1,'9',2);
#call UpdateVote(1,'9',2);
#call QueryBets('9',0,1);
insert into User Value('testUser','1','dayinhahaha@163.com', '123123');
insert into User Value('testUser1','1','dayinhahaha@163.com', '123123');
insert into User Value('testUser2','1','dayinhahaha@163.com','123123');
call CreateBet('边老师何时下课','1分钟后','10分钟后','无',1,'啊呀，我的人生输了','啊呀我的人生真是悲惨','testUser');
#insert into User Value('testUser1','1','wing19921013@163.com','123123');
call CreateBet('马林大神今晚回不回','回来','不回来','无',1,'我是傻逼','我是逗逼','testUser1');

call CreateBet('人生艰难么？','废话','真是废话','无',1,'我真是迷路了','我迷路了','testUser2');
Insert into User_has_Bets SET User_Name = 'testUser1', Bets_idBets = 3;
call UpdateVote(2,'testUser1',3);
#SELECT * Fom User_has_Bets where User_Name = 'testUser2' And Bets_idBets = 3;
#call RenRenFa(1);
#SELECT * From Bets;
SELECT * From User_has_Bets;
SELECT * From Bets;
#select * from user;
#call UpdateVote(2,'1',1);
#insert into user value('1','2','dayinhahaha@163.com','123123');
#Insert into User_has_Bets value('1', 1, 1, 0, 0);
#Update Bets SET RRS = 1 where idBets = 1; 
/*select * from Bets where exists (
			select * from User_has_Bets 
			where idBets = Bets_idBets And User_Name = 'testUser' And Finish = 0);*/
#call RenRenFa(1);
Select * from User where UserName in (select User_Name from User_has_Bets 
		where Bets_idBets = 1  And Party = 1);