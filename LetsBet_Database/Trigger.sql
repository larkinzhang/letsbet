DELIMITER $$


/*
CREATE TRIGGER UpdateBetStatus1
AFTER UPDATE ON User_has_Bets  
FOR EACH ROW 
BEGIN
	If (old.Userconfirm = 0 And new.UserConfirm != 0) then
		update Bets SET Confirm = Confirm + 1 where idBets = new.Bets_idBets;
	End if;
	
	if (old.Vote != new.Vote) then
		if (old.Vote = 1) then
			update Bets SET VoteA = VoteA - 1 where idBets = new.Bets_idBets;
		else if (old.Vote = 2) then
				update Bets SET VoteA = VoteA - 1 where idBets = new.Bets_idBets;
			end if;
		end if;
		if (new.Vote = 1) then
			update Bets SET VoteA = VoteA + 1 where idBets = new.Bets_idBets;
		else if (new.Vote = 2) then
				update Bets SET VoteA = VoteA + 1 where idBets = new.Bets_idBets;
			end if;
		end if;
	
	end if;
END$$	
CREATE TRIGGER UpdateBetStatus2
AFTER UPDATE ON Bets  
FOR Each row
begin
	if new.finish = 0 And new.VoteA + new.VoteB = new.Sum then
		update Bets SET finish = 1;
	end if;
end$$*/
CREATE TRIGGER SumAcc
AFTER Insert on User_has_Bets  
FOR EACH ROW 
BEGIN
	update Bets SET Sum = Sum + 1 where idBets = new.Bets_idBets;
END$$

