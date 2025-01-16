public with sharing class CaseTriggerHandler {
    public static void main() {
        switch on Trigger.operationType {
            when BEFORE_INSERT {
                setDefaultStatus(Trigger.new);
            }
            when BEFORE_UPDATE {
                updateStatus(Trigger.new, Trigger.oldMap);
            }
        }
    }

    public static void setDefaultStatus(List<Case> cases) {
        for (Case c : cases) {
            if (String.isEmpty(c.Status)) {
                c.Status = 'New';
            }
        }
    }

    public static void updateStatus(List<Case> newCases, Map<Id, Case> oldCases) {
        for (Integer i = 0; i < newCases.size(); i++) {
            Case newCase = newCases[i];
            Case oldCase = oldCases.get(newCase.Id);

            if (newCase.Comments != oldCase.Comments && newCase.Status == 'New') {
                newCase.Status = 'Working';
            }
        }
    }


}