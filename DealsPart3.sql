# Indicate that we are using the deals database
USE deals;  

#Adding Foregin Keys to existing tables 

ALTER TABLE `DealTypes`  
  ADD FOREIGN KEY (`TypeCode`)
    REFERENCES `TypeCodes` (`TypeCode`);
    
ALTER TABLE `DealTypes`  
  ADD FOREIGN KEY (`DealID`)
    REFERENCES `Deals` (`DealID`);

ALTER TABLE `DealParts`  
  ADD FOREIGN KEY (`DealID`)
    REFERENCES `Deals` (`DealID`);
    
ALTER TABLE `Players`  
  ADD FOREIGN KEY (`CompanyID`)
    REFERENCES `Companies` (`CompanyID`);

ALTER TABLE `Players`  
  ADD FOREIGN KEY (`DealID`)
    REFERENCES `Deals` (`DealID`);
    
ALTER TABLE `Players`  
  ADD FOREIGN KEY (`RoleCode`)
    REFERENCES `RoleCodes` (`RoleCode`);

ALTER TABLE `PlayerSupports`  
  ADD FOREIGN KEY (`PlayerID`)
    REFERENCES `Players` (`PlayerID`);
    
ALTER TABLE `PlayerSupports`  
  ADD FOREIGN KEY (`FirmID`)
    REFERENCES `Firms` (`FirmID`);
    
ALTER TABLE `PlayerSupports`  
  ADD FOREIGN KEY (`SupportCodeID`)
    REFERENCES `SupportCodes` (`SupportCodeID`);

