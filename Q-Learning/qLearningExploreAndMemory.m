%%%% Q LEARNING %%%%%
% States and Actions:
%        3       6  <-> 7 <-> 8     
%        ^       ^      ^     ^
%        |       |      |     |
%        \/      \/     \/   \/
%  1 <-> 2  <->  5      9    10 <---- = GOAL STATE
%        ^              ^
%        |              |
%        \/             |
%        4 <-------------
%
%  Reward table (-1 means no action possible):
%  R =
%              Action
% State    1  2  3  4  5  6  7  8  9  10
%     1   -1  0 -1 -1 -1 -1 -1  -1 -1 -1  
%     2    0 -1  0  0  0 -1 -1  -1 -1 -1  
%     3   -1  0 -1 -1 -1 -1 -1  -1 -1 -1  
%     4   -1  0 -1 -1 -1 -1 -1  -1  0 -1  
%     5   -1  0 -1 -1 -1  0 -1  -1 -1 -1  
%     6   -1 -1 -1 -1  0 -1  0  -1 -1 -1  
%     7   -1 -1 -1 -1 -1  0 -1   0  0 -1  
%     8   -1 -1 -1 -1 -1 -1  0  -1 -1 100 
%     9   -1 -1 -1  0 -1 -1  0  -1 -1 -1 
%    10   -1 -1 -1 -1 -1 -1 -1   0 -1 100 

R = [-1  0 -1 -1 -1 -1 -1  -1 -1 -1;        %1
      0 -1  0  0  0 -1 -1  -1 -1 -1;        %2
      -1  0 -1 -1 -1 -1 -1  -1 -1 -1;       %3
      -1  0 -1 -1 -1 -1 -1  -1  0 -1;       %4  
      -1  0 -1 -1 -1  0 -1  -1 -1 -1;       %5 
      -1 -1 -1 -1  0 -1  0  -1 -1 -1;       %6
      -1 -1 -1 -1 -1  0 -1   0  0 -1;       %7
      -1 -1 -1 -1 -1 -1  0  -1 -1 100;      %8
      -1 -1 -1  0 -1 -1  0  -1 -1 -1;       %9
      -1 -1 -1 -1 -1 -1 -1  0 -1 100];      %10

Q = zeros(size(R));
gamma = 0.8;
goal_state = size(R,2);

learning_complete = false;
fprintf('******Starting learning. Goal state is: %d******\n', goal_state);

% percentage of the time we explore, vs pick learned route
epsilon = 0;
iterations = 0;
total_steps = 0;

while (~learning_complete)

    current_state = ceil(rand*goal_state);
    fprintf('***Starting journey at: %d***\n', current_state);
    reward = 0;
    iterations = iterations + 1;
    path_to_goal_state = [current_state];
    
    % Training stage
    while (current_state < goal_state)
       % Alternate between randomly picking the next
       % action according to epsilon, the percentage of the time we explore 
       % vs draw on learned behaviour, and picking the one known 
       % (from memory [=Q table]) as having the best outcome.
       if (rand < epsilon)
           % SHOULD EXPLORATION BE RANDOM? OR SHOULD IT PREFER A SEQUENCE
           % WE HAVEN'T ALREADY TRIED?
           next_action = randomNextAction(current_state, R);
           %fprintf('Exploring and picking %d\n', next_action);
       else
           next_action = bestNextAction(current_state, Q);
           num_actions = length(next_action);
           %fprintf('Checking memory....\n');
           if num_actions == goal_state
               next_action = randomNextAction(current_state, R);
               %fprintf('No memory of best possible next action. Randomly picking %d.\n', next_action);
           elseif length(next_action) > 1
               next_action = next_action(ceil(rand*num_actions));
               %fprintf('More than one best possible next action in memory. Randomly picking %d.\n', next_action);
           else
               %fprintf('...Picking %d from memory.\n', next_action);
           end
       end
       
       % Pick one with the greatest reward (from memory), or, if no
       % information, at random
       % SHOULD THIS BE OVERWRITING THE MEMORY VALUE?
       Q(current_state,next_action) = R(current_state,next_action) + (gamma * max(Q(next_action,:)));
       reward = Q(current_state,next_action);
       if reward > 0 
           fprintf('Reward for moving to the next action: %d\n', reward);
       end
       current_state = next_action;
       path_to_goal_state(end+1) = current_state;
    end
    moves_to_goal_state = length(path_to_goal_state);
    total_steps = total_steps + moves_to_goal_state;
    fprintf('***Reached goal in %d moves.***\n', moves_to_goal_state);
    fprintf('%3d',path_to_goal_state);
    fprintf('\n');
    
    learning_complete = true;
    for j = 1:size(Q,2)-1
        if (max(Q(j,:)) < 1)
            learning_complete = false;
        end
    end
end

fprintf('Learning complete in %d iterations, %d steps.\n', iterations, total_steps);

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
