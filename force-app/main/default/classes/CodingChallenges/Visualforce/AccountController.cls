public class AccountController {
    public Account fixedAccount { get; set; }

    public AccountController() {
        String fixedAccountId = '001Ru00000OjmIoIAJ';
        fixedAccount = [SELECT Name FROM Account WHERE Id = :fixedAccountId LIMIT 1];
    }
}

