%%%%
%% Abhinav Bajaj  %%%
%%%%
function [merge indivInfo] = eigenstrat_create_case_snp_batch(pops,caseSnpLoc,lociBatchSize,alleleVar2,alleleVar1,alleleVar0,noOfIndiv, probVar2Case,probVar1Case,probVar0Case,noOfIndivControl,probVar2Control,probVar1Control,probVar0Control)
    
tmpNoOfIndiv = noOfIndiv + noOfIndivControl;
noOfIndivVar2 = round(probVar2Case * noOfIndiv);
noOfIndivVar1 = round(probVar1Case * noOfIndiv);
noOfIndivVar0 = noOfIndiv - noOfIndivVar2 - noOfIndivVar1;

noOfIndivCVar2 = round(probVar2Control * noOfIndiv);
noOfIndivCVar1 = round(probVar1Control * noOfIndiv);
noOfIndivCVar0 = noOfIndivControl - noOfIndivCVar2 - noOfIndivCVar1;
noOfPop = size(pops,1);
indiv = zeros(noOfPop*tmpNoOfIndiv,lociBatchSize);
indivInfo = zeros(noOfPop*tmpNoOfIndiv,2);

n2 = 0; n0 = 0; n1 = 0; nc2 = 0; nc1=0; nc0 = 0;
nt = 0;
indivDrawn = zeros(tmpNoOfIndiv,lociBatchSize,noOfPop);
for i = 1:noOfPop
	n2 = 0; n0 = 0; n1 = 0; nc2 = 0; nc1=0; nc0=0; nt=0;  findVar2 = true; findVar1 = true; findVar0 = true; 
	findCVar2 = true; findCVar1 = true; findCVar0 = true;
	while true
		indivDrawn(:,:,i) = eigenstrat_cohort_sim(tmpNoOfIndiv,pops(i,:));
		for j = 1:tmpNoOfIndiv
			tmpSnpDrawn = indivDrawn(j,caseSnpLoc,i);
			%disp(tmpSnpDrawn);
			status = false;
			% check for alleleVar2
			if (findVar2 & tmpSnpDrawn == alleleVar2)
				% do a coin toss with probability of alleleVar2
				if (rand(1,1) <= probVar2Case)
					nt = nt+1;
					n2 = n2+1;
					indiv((i-1)*tmpNoOfIndiv+nt,:) = indivDrawn(j,:,i);
					indivInfo((i-1)*tmpNoOfIndiv+nt,:) = [i 1];
					status = true;
				end
				if (n2 >= noOfIndivVar2)
					findVar2 = false;disp('done with Var2');
				end
			
			elseif (findVar1 & tmpSnpDrawn == alleleVar1)
                                % do a coin toss with probability of alleleVar1
				%disp('var1');
                                if (rand(1,1) <= probVar1Case)
					%disp('success toss');
					nt=nt+1;
                                        n1 = n1+1;
                                        indiv((i-1)*tmpNoOfIndiv+nt,:) = indivDrawn(j,:,i);
					indivInfo((i-1)*tmpNoOfIndiv+nt,:) = [i 1];
                                        status = true;
                                end
                                if (n1 >= noOfIndivVar1)
                                        findVar1 = false;disp('done with Var1');
                                end
                        
			elseif (findVar0 & tmpSnpDrawn == alleleVar0)
                                % do a coin toss with probability of alleleVar0
				%disp('var0');
                                if (rand(1,1) <= probVar0Case)
					nt = nt+1;
                                        n0 = n0+1;
					%disp('success toss');
                                        indiv((i-1)*tmpNoOfIndiv+nt,:) = indivDrawn(j,:,i);
					indivInfo((i-1)*tmpNoOfIndiv+nt,:) = [i 1];
                                        status = true;
                                end
                                if (n0 >= noOfIndivVar0)
                                        findVar0 = false;disp('done with Var0');
                                end
                	end
			
			if (~status & findCVar2 & tmpSnpDrawn == alleleVar2)
                                if (rand(1,1) <= probVar2Control)
					nt = nt+1;
                                	nc2 = nc2+1;
					indiv((i-1)*tmpNoOfIndiv+nt,:) = indivDrawn(j,:,i);
					indivInfo((i-1)*tmpNoOfIndiv+nt,:) = [i 0];
					status = true;
			        end	
				if (nc2 >= noOfIndivCVar2)
					findCVar2 = false;disp('done with Control Var2');
				end
			
			elseif (~status & findCVar1 & tmpSnpDrawn == alleleVar1)
                                % do a coin toss with probability of alleleVar1
                                if (rand(1,1) <= probVar1Control)
					nt = nt+1;
	                                nc1 = nc1+1;
        	                        indiv((i-1)*tmpNoOfIndiv+nt,:) = indivDrawn(j,:,i);
					indivInfo((i-1)*tmpNoOfIndiv+nt,:) = [i 0];
                        	        status = true;
                                end
				 if (nc1 >= noOfIndivCVar1)
                                        findCVar1 = false;disp('done with Control Var1');
                                end
                        
			elseif (~status & findCVar0 & tmpSnpDrawn == alleleVar0)
                                % do a coin toss with probability of alleleVar0
                                if (rand(1,1) <= probVar0Control)
					nt = nt+1;
                	                nc0 = nc0+1;
					indiv((i-1)*tmpNoOfIndiv+nt,:) = indivDrawn(j,:,i);
					indivInfo((i-1)*tmpNoOfIndiv+nt,:) = [i 0];
                                	status = true;
				end
                                if (nc0 >= noOfIndivCVar0)
                                        findCVar0 = false;disp('done with Control Var0');
                                end
                	end

		end % end of for loop
		% if all variants are done for this population then break
		if (~findVar2 & ~findVar1 & ~findVar0 & ~findCVar2 & ~findCVar1 & ~findCVar0)
			break;
		end

	end % end of infinite while

end % end for all outermost loop, sampled for all populations
disp(n2);
disp(n1);
disp(n0);
disp(nc2);
disp(nc1);
disp(nc0);
merge = indiv';
