function w5 = pd625917(~,input5)

	if input5 == 1 % If in the previous turn, the other player coorporated
		w5 = 1; % Then I will coorporate this turn
		
	else % If in the previous turn, the other player was hostile
		w5 = 0; % Then in this turn, I will be hostile
	end  

end 