trigger emailDomain on Contact (before insert, before update) {
    Set<Id> accId = new Set<Id>();
    Map<Id, Set<String>> accEmailDomain = new Map<Id, Set<String>>();

    for (Contact c: Trigger.new) {
        if(c.Email != NULL && c.AccountId != NULL) {
            accId.add(c.AccountId);
        }
    }

    for (Contact c : [SELECT Email, AccountId FROM Contact WHERE AccountId IN :accId]) {
        if (c.Email != NULL && c.AccountId != NULL) {
            String domain = c.Email.split('@')[1];
            if(!accEmailDomain.containsKey(c.AccountId)) {
                accEmailDomain.put(c.AccountId, new Set<String>());
            }
            accEmailDomain.get(c.AccountId).add(domain);
            }
    }

    for (Contact c : Trigger.new) {
        if (c.Email != NULL && c.AccountId != NULL) {
            String newDomain = c.Email.split('@')[1];
            Set<String> existingDomain = accEmailDomain.get(c.AccountId);

            if(existingDomain != NULL && existingDomain.size() > 0 && !existingDomain.contains(newDomain)) {
                c.addError('Email domain must match');
            }
            else {
                existingDomain.add(newDomain);
            }
        }
    }
}