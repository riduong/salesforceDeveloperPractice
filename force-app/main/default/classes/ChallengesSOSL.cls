public with sharing class ChallengesSOSL {
    public static List<List<SObject>> namedTom() {
        return [FIND 'Tom*' IN NAME FIELDS RETURNING Contact(Name), Lead(Name)];
    }

    public static List<List<sObject>> accountsWithAandO() {
        return [FIND 'a* AND o*' IN ALL FIELDS RETURNING Account(Name)];
    }

    public static List<List<SObject>> phoneEndingIn1000() {
        return [FIND '*1000' IN PHONE FIELDS RETURNING Account(Name), Contact(Name), Lead(Name)];
    }

 
}