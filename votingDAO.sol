//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/// @title This is a voting contract.
/// @notice Three candidates are to be voted for at any instance.
/// @notice MasterAdmin is the Owner 
contract VotingDAO is ERC20 {

    address public MasterAdmin;
    uint256 public TotalVotes;

    enum VoteTimer {
        start,
        end
    }

    VoteTimer voteTimer;

    constructor() {
        MasterAdmin = msg.sender;
    }
/// @notice balances maps token balance to accounts
    //mapping (address => uint256) balances;
    mapping (address => uint256) votesPerCandidate;
    mapping(address => bool) public Voted;

    address[] contenders;
    address[] votedAccounts;

    event VotingStatus(string message);


    modifier onlyOwner() {
        require(MasterAdmin == msg.sender, "Unauthorized operation");
        _;
    }

/// @notice start voting process
    function startVoting() public onlyOwner{
        require(contenders.length == 3, "Contenders must be at least 3");
        voteTimer = VoteTimer.start;
        emit VotingStatus("Voting has started.");
    }

    function endVoting() public onlyOwner {
        voteTimer = VoteTimer.end;
        emit VotingStatus("Voting has ended");
    }

    function requireCandidateISRegistered(address _candidate) private view returns(bool){
        bool registered = false;
        size = contenders.length;
        for (uint i = 0; i < size; i++){
            if(contenders[i] == _candidate) {
                registered = true;
                break;
            }
        }
    }

    function castVote(address _voter, address _candidate) public returns(bool success) {
        require(voteTimer == VoteTimer.start, "Voting Closed");
        requireCandidateISRegistered(_candidate);
        //require (contenders[_candidate], "Candidate must be registered");
        require(address(_voter).balance >= 10);
        require(!Voted[_voter], "Only ONE vote is allowed");
        votesPerCandidate[_candidate] = votesPerCandidate[_candidate] + 1;
        Voted[_voter] = true;
        votedAccounts.push(_voter);
        TotalVotes = TotalVotes + 1;
    }

    function returnWinner() public view returns (address winner) {
        for(uint i = 0; )
    }

}