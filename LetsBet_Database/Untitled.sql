DELIMITER $$

CREATE TRIGGER User_has_Bets 
BEFORE UPDATE ON Bets 
FOR EACH ROW 
BEGIN
	If (old.Userconfirm = 0 And new.Userconfirm != 0) then
		update Bets SET confirm = confirm + 1 where idBets = new.Bets_idBets;
	
		
	update Video SET Click=Click+1 
	Where idVideo = NEW.Video_idVideo;
END$$