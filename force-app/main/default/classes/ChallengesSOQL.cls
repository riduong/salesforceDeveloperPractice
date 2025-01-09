public with sharing class ChallengesSOQL {
    public static Integer NumAccounts() {
        return [SELECT Count() FROM Account];
    }

    public static Integer NumHot() {
        return [SELECT COUNT() FROM Account WHERE Rating = 'Hot'];
    }

    public static Integer NumComplex() {
        return [SELECT COUNT() FROM Account WHERE Name LIKE '%&%'];
    }

    public static List<Account> BigFive() {
        return [SELECT Name, AnnualRevenue FROM Account ORDER BY AnnualRevenue DESC NULLS LAST LIMIT 5];
    } 
    
    public static Opportunity LastBigOpportunity() {
        return [SELECT CloseDate FROM Opportunity WHERE Amount > 100000 Order BY CloseDate DESC Limit 1];
    }

    public static List<Contact> MajorPlayers() {
        return [Select Id,NAME FROM Contact WHERE Account.Rating = 'HOT'];
    }

    public static List<AggregateResult> MostPopularAccount() {
        return [SELECT Account.Name, Count(Id) FROM Contact GROUP BY Account.Name Order By Count(Id) DESC Limit 1];
    }
}