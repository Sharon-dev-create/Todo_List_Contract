//SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {TodoList} from "../contracts/TodoList.sol";

contract TodoListTest is Test {
    TodoList private todoList;

    function setUp() public {
        todoList = new TodoList();
    }

    function testCreateTask() public {
        string memory description = "Test Task";
        todoList.createTask(description);

        (address creator, string memory desc, TodoList.Status status) = todoList.viewTask(0);
        assertEq(creator, address(this));
        assertEq(desc, description);
        assertEq(uint(status), uint(TodoList.Status.InProgress));
    }

    function testMarkTaskAsComplete() public {
        string memory description = "Test Task";
        todoList.createTask(description);
        todoList.markTaskAsComplete(0);

        (, , TodoList.Status status) = todoList.viewTask(0);
        assertEq(uint(status), uint(TodoList.Status.Completed));
    }

    function testDeleteTask() public {
        string memory description = "Test Task";
        todoList.createTask(description);
        todoList.deleteTask(0);

        vm.expectRevert("Task does not exist");
        todoList.viewTask(0);
    }
}