pragma circom 2.0.3;

template Main() {
  signal output out;
  signal input balances[3];
  signal input votes[3];
  signal input aggregation;
  

  signal int0 <== balances[0] * votes[0];
  signal int1 <== balances[1] * votes[1];
  signal int2 <== balances[2] * votes[2];

  out <== int0 + int1 + int2;
  out === aggregation;
}

component main {public [balances, votes, aggregation]} = Main();