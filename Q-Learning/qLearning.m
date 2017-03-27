%%%% Q LEARNING %%%%%
% States and Actions:
%        3   <-> 6  <---- 6 = GOAL STATE
%        ^       ^
%        |       |
%        \/      \/ 
%  1 <-> 2  <->   5
%        ^
%        |
%        \/
%        4
%
%  Reward table (-1 means no action possible):
%  R =
%              Action
% State    1  2  3  4  5  6
%     1   -1  0 -1 -1 -1 -1  
%     2    0 -1  0  0  0 -1
%     3   -1  0 -1 -1 -1 100
%     4   -1  0 -1 -1 -1 -1
%     5   -1  0 -1 -1 -1 100
%     6   -1 -1  0 -1  0 100
%  

R = [-1  0 -1 -1 -1 -1;0 -1  0  0  0 -1;-1  0 -1 -1 -1 100;-1  0 -1 -1 -1 -1;-1  0 -1 -1 -1 100;-1 -1  0 -1  0 100];
Q = zeros(size(R));
gamma = 0.8;
goal_state = size(R,2);

learning_complete = false;
fprintf('******Starting learning. Goal state is: %d******\n', goal_state);

% percentage of the time we explore, vs pick learned route
epsilon = 0;
iterations = 0;

while (~learning_complete)

    current_state = ceil(rand*goal_state);
    fprintf('***Starting journey at: %d***\n', current_state);
    reward = 0;
    iterations = iterations + 1;
    moves_to_goal_state = 0;
    
    % Training stage
    while (current_state < goal_state)
       % Alternate between randomly picking the next
       % action according to epsilon, the percentage of the time we explore 
       % vs draw on learned behaviour, and picking the one known 
       % (from memory [=Q table]) as having the best outcome.
       if (rand < epsilon)
           next_action = randomNextAction(current_state, R);
           fprintf('Exploring and picking %d\n', next_action);
       else
           next_action = bestNextAction(current_state, Q);
           num_actions = length(next_action);
           fprintf('Checking memory....\n');
           if num_actions == goal_state
               next_action = randomNextAction(current_state, R);
               fprintf('No memory of best possible next action. Randomly picking %d.\n', next_action);
           elseif length(next_action) > 1
               next_action = next_action(ceil(rand*num_actions));
               fprintf('More than one best possible next action in memory. Randomly picking %d.\n', next_action);
           else
               fprintf('...Picking %d from memory.\n', next_action);
           end
       end
       
       % Pick one with the greatest reward (from memory), or, if no
       % information, at random
       Q(current_state,next_action) = R(current_state,next_action) + (gamma * max(Q(next_action,:)));
       reward = Q(current_state,next_action);
       if reward > 0 
           fprintf('Reward for moving to the next action: %d\n', reward);
       end
       current_state = next_action;
       moves_to_goal_state = moves_to_goal_state + 1;
    end
    
    fprintf('***Reached goal in %d moves.***\n', moves_to_goal_state);
    
    learning_complete = true;
    for j = 1:size(Q,2)-1
        if (max(Q(j,:)) < 1)
            learning_complete = false;
        end
    end
end

fprintf('Learning complete in %d iterations.\n', iterations);

fprintf('Finding best paths...\n');
% Once trained, print out best sequence per starting point:
all_actions = size(R,2);
for starting_state = 1:all_actions
    journey = [starting_state];
    state = starting_state;
    while state < all_actions
        best_action = find(max(Q(state,:)) == Q(state,:));
        % If there's more than one, randomly pick and make note
        if length(best_action) > 1
           disp('More than one best action for state ');
           disp(state);
           disp(best_action);
           best_action = best_action(ceil(rand * length(best_action)));
           disp('Randomly picking ');
           disp(best_action);
        end
        state = best_action;
        journey(end+1) = state;
    end
    fprintf('%3d', journey);
    fprintf('\n');
end

disp('Q table is: ');
disp(Q);
