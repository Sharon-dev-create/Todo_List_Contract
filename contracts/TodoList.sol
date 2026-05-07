//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TodoList {
    struct Task {
        address creator;
        string description;
        bool completed;
    }

    mapping(uint256 => Task) private tasks;
    uint256 private taskCount;
    

    function createTask(string memory _description) public {
         require(bytes(_description).length > 0, "Description cannot be empty");
         tasks[taskCount] = Task({
                creator: msg.sender,
                description: _description,
                completed: false
         });

         taskCount++;
    }

    function markTaskAsComplete(uint256 _id) public {
            require(tasks[_id].creator == msg.sender, "Only the creator can mark this task as complete");
             tasks[_id].completed = true;
    }

    function deleteTask(uint256 _id) public {
            require(tasks[_id].creator == msg.sender, "Only the creator can delete this task");
            delete tasks[_id];  
    }

    function viewTask(uint256 _id) public view returns(string memory description, bool completed) {
            return ("Sample Task", false);
    }
}