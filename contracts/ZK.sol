// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.11;

import "./InitVerifier.sol";

contract ZK is Verifier {
    uint256[] public balances = [150, 100, 210];
    uint256[] public votes = [1, 0, 1];
    uint256 public aggVote;

    address public owner;

    event UpdateAggVote(address updater, uint256 newAggVote);

    constructor() public {
        owner = msg.sender;
    }

    function updateWithProof(
        uint256[2] memory a,
        uint256[2] memory b_0,
        uint256[2] memory b_1,
        uint256[2] memory c,
        uint256[1] memory inputs // public inputs
    ) external returns (bool) {
        uint256[8] memory publicInputs = [
            inputs[0],
            balances[0],
            balances[1],
            balances[2],
            votes[0],
            votes[1],
            votes[2],
            inputs[0]
        ];
        require(verifyProof(a, [b_0, b_1], c, publicInputs), "invalid proof");
        _updateAggregateVotes(inputs[0]);
    }

    function _updateAggregateVotes(uint256 _aggVote) private {
        aggVote = _aggVote;
        emit UpdateAggVote(msg.sender, aggVote);
    }
}
