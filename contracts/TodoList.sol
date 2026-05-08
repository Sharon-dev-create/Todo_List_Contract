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

    event TaskCreated(uint256 indexed id, address indexed creator, string description);
    event TaskCompleted(uint256 indexed id);
    event TaskDeleted(uint256 indexed id);

    mapping(uint256 => Task) private tasks;
    uint256 private taskCount;
    

    function createTask(string memory _description) public {
         require(bytes(_description).length > 0, "Description cannot be empty");
         tasks[taskCount] = Task({
                creator: msg.sender,
                description: _description,
                status: Status.InProgress
         });

         emit TaskCreated(taskCount, msg.sender, _description);

         taskCount++;

    }

    function markTaskAsComplete(uint256 _id) public {
            require(tasks[_id].status != Status.Empty, "Task does not exist");
            require(tasks[_id].creator == msg.sender, "Only the creator can mark this task as complete");

            tasks[_id].status = Status.Completed;

            emit TaskCompleted(_id);
    }

    function deleteTask(uint256 _id) public {
            require(tasks[_id].status != Status.Empty, "Task does not exist");
            require(tasks[_id].creator == msg.sender, "Only the creator can delete this task");

            delete tasks[_id];

            emit TaskDeleted(_id);
    }

    function viewTask(uint256 _id) public view returns(address creator, string memory description, Status status) {
            require(tasks[_id].status != Status.Empty, "Task does not exist");

            Task memory task = tasks[_id];

            return (task.creator, task.description, task.status);
    }
}
