//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TodoList {
    struct Task {
        uint id;
        string description;
        bool completed;
    }


    function createTask(string memory _description) public {
         require(bytes(_description).length > 0, "Description cannot be empty");
    }

    function markTaskAsComplete(uint256 _id) public {
            require(_id > 0, "Invalid task ID");
    }

    function deleteTask(uint256 _id) public {
            require(_id > 0, "Invalid task ID");
    }

    function viewTask(uint256 _id) public view returns(string memory description, bool completed) {
            require(_id > 0, "Invalid task ID");
            return ("Sample Task", false);
    }
}