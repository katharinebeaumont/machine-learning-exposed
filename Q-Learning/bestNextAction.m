% If there is more than one possible best next action, it returns an array.
function next_action = bestNextAction(current_state, Q)
    rewards = Q(current_state,:);
    next_action = find(max(rewards) == rewards);
end