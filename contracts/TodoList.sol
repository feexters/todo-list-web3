// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

contract Owned {
    address payable owner;

    constructor() public {
        owner = payable(msg.sender);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }
}

contract TodoList is Owned {
    uint public taskCount = 1;

    struct Task {
        uint id;
        string content;
        bool isCompleted;
    }

    mapping(uint => Task) public tasks;

    function createTask(string memory content) public onlyOwner {
        tasks[taskCount] = Task(taskCount, content, false);

        taskCount++;
    }

    function completeTask(uint id) public onlyOwner {
        require(tasks[id].id > 0, "Task not exist");

        tasks[id].isCompleted = true;
    }

    function deleteTask(uint id) public onlyOwner {
        require(tasks[id].id > 0, "Task not exist");

        delete tasks[id];
    }

    function editTask(uint id, string memory content) public onlyOwner {
        require(tasks[id].id > 0, "Task not exist");

        tasks[id].content = content;
    }

    function destroy() public onlyOwner {
        selfdestruct(owner);
    }
}