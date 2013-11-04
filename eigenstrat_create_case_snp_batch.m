%%%%
%% Abhinav Bajaj  %%%
%%%%
function [merge] = eigenstrat_create_case_snp_batch(pops,noOfIndivVar2,noOfIndivVar1,noOfIndivVar0,noOfIndivControl,caseSnpLoc,lociBatchSize,alleleVar2,alleleVar1,alleleVar0, probVar2Case,probVar1Case,probVar0Case)
    
tmpNoOfIndiv = noOfIndivVar2 + noOfIndivVar1 + noOfIndivVar0 + noOfIndivControl;
noOfPop = size(pops,1);
%disp(noOfPop);
indivVar2 = zeros(noOfPop*noOfIndivVar2,lociBatchSize);
indivVar1 = zeros(noOfPop*noOfIndivVar1,lociBatchSize);
indivVar0 = zeros(noOfPop*noOfIndivVar0,lociBatchSize);
indivControl = zeros(noOfPop*noOfIndivControl,lociBatchSize);

n2 = 0; n0 = 0; n1 = 0; nc = 0;
indivDrawn = zeros(tmpNoOfIndiv,lociBatchSize,noOfPop);
for i = 1:noOfPop
	n2 = 0; n0 = 0; n1 = 0; nc = 0; findVar2 = true; findVar1 = true; findVar0 = true; findControl = true;
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
					n2 = n2+1;
					indivVar2((i-1)*noOfIndivVar2+n2,:) = indivDrawn(j,:,i);
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
                                        n1 = n1+1;
                                        indivVar1((i-1)*noOfIndivVar1+n1,:) = indivDrawn(j,:,i);
                                        status = true;
                                end
                                if (n1 >= noOfIndivVar1)
                                        findVar1 = false;disp('done with Var1');
                                end
                        
			elseif (findVar0 & tmpSnpDrawn == alleleVar0)
                                % do a coin toss with probability of alleleVar0
				%disp('var0');
                                if (rand(1,1) <= probVar0Case)
                                        n0 = n0+1;
					%disp('success toss');
                                        indivVar0((i-1)*noOfIndivVar0+n0,:) = indivDrawn(j,:,i);
                                        status = true;
                                end
                                if (n0 >= noOfIndivVar0)
                                        findVar0 = false;disp('done with Var0');
                                end
                	end

			if (findControl & ~status) % indiv is not a case, so add to control
                                nc = nc+1;
                                indivControl((i-1)*noOfIndivControl+nc,:) = indivDrawn(j,:,i);
                                if (nc >= noOfIndivControl)
                                        findControl = false;
                                end

			end

		end % end of for loop
		% if all variants are done for this population then break
		if (~findVar2 & ~findVar1 & ~findVar0 & ~findControl)
			break;
		end

	end % end of infinite while

end % end for all outermost loop, snapled for all populations

merge = [indivVar2' indivVar1' indivVar0' indivControl'];
disp(size(merge));
