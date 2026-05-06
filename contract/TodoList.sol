//SPDX-License-Identifier:MIT

pragma solidity ^0.8.26;

contract TodoList {
    // State variables
    uint256 public taskCount;

    struct Task {
        string description;
        bool isComplete;
    }

    mapping(address => Task[]) public tasks;

    event TaskAdded(address indexed user, uint256 indexed taskId, string description);
    event TaskCompleted(address indexed user, uint256 indexed taskId);
    event TaskDeleted(address indexed user, uint256 indexed taskId);

    //Functions
    function addTask(string memory _task) public {
        require(bytes(_task).length > 0, "Task description cannot be empty");
        tasks[msg.sender].push(Task({description: _task, isComplete: false}));
        taskCount++;
        emit TaskAdded(msg.sender, tasks[msg.sender].length - 1, _task);
    }

    function markTaskComplete(uint256 taskId) public {
        require(taskId < tasks[msg.sender].length, "Invalid task ID");
        require(!tasks[msg.sender][taskId].isComplete, "Task already complete");
        tasks[msg.sender][taskId].isComplete = true;
        emit TaskCompleted(msg.sender, taskId);
    }

    function deleteTask(uint256 taskId) public {
        uint256 userTaskCount = tasks[msg.sender].length;
        require(taskId < userTaskCount, "Invalid task ID");
        for (uint256 i = taskId; i + 1 < userTaskCount; i++) {
            tasks[msg.sender][i] = tasks[msg.sender][i + 1];
        }
        tasks[msg.sender].pop();
        taskCount--;
        emit TaskDeleted(msg.sender, taskId);
    }

    function viewTask(uint256 taskId) public view returns (string memory, bool) {
        require(taskId < tasks[msg.sender].length, "Invalid task ID");
        Task memory task = tasks[msg.sender][taskId];
        return (task.description, task.isComplete);
    }

    function getMyTaskCount() public view returns (uint256) {
        return tasks[msg.sender].length;
    }
}
