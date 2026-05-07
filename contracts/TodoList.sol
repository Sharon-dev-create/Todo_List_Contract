//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TodoList {
    struct Task {
        address creator;
        string description;
        Status status;
    }

    enum Status {
        Empty,
        InProgress,
        Completed
    }

    mapping(uint256 => Task) private tasks;
    uint256 private taskCount;
    

    function createTask(string memory _description) public {
         require(bytes(_description).length > 0, "Description cannot be empty");
         tasks[taskCount] = Task({
                creator: msg.sender,
                description: _description,
                status: Status.InProgress
         });

         taskCount++;
    }

    function markTaskAsComplete(uint256 _id) public {
            require(tasks[_id].creator == msg.sender, "Only the creator can mark this task as complete");
            require(tasks[_id].status != Status.Empty, "Task does not exist");
             tasks[_id].status = Status.Completed;
    }

    function deleteTask(uint256 _id) public {
            require(tasks[_id].creator == msg.sender, "Only the creator can delete this task");
            require(tasks[_id].status != Status.Empty, "Task does not exist");
            delete tasks[_id];  
    }

    function viewTask(uint256 _id) public view returns(string memory description, Status status) {
            require (tasks[_id].creator != Status.Empty, "Task does not exist");

            Task storage task = tasks[_id];

            return (task.description, task.status);
    }
}