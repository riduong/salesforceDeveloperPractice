// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);

System.debug(Calculator.add(1,2));
System.debug(Calculator.multiply(4,2));
System.debug(Calculator.divide(8,2));
System.debug(Calculator.divide(9,2));
System.debug(Calculator.mod(9,2));
System.debug(Calculator.mod(14,3));

System.debug('Accounts Count: ' + ChallengesSOQL.NumAccounts());
System.debug('Hot Accounts Count: ' + ChallengesSOQL.NumHot());
System.debug('& Accounts Count: ' + ChallengesSOQL.NumComplex());
System.debug('Annual Revenue: ' + ChallengesSOQL.BigFive());
System.debug('Last Big Opportunity: ' + ChallengesSOQL.LastBigOpportunity());
System.debug('Major Players: ' + ChallengesSOQL.MajorPlayers());
System.debug('Most Popular Account: ' + ChallengesSOQL.MostPopularAccount());