function next_action = randomNextAction(current_state, R)
   % Get the row of actions for the state
   actions = R(current_state,:);
   % What are the possible actions we can take?
   %Have to add an initial, empty value so can add to the end of possible_actions
   possible_actions = zeros(1,1); 
   for i = 1:length(actions)
       if (actions(i) > -1)
            possible_actions(end+1) = i;
       end
   end
   % Remove first (empty) element of possible_actions
   possible_actions = possible_actions(2:end);
   next_action = possible_actions(ceil(rand*length(possible_actions)));
end