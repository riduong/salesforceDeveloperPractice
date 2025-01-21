public with sharing class VisualforceExtensions {
    ApexPages.standardSetController sd;
    public VisualforceExtensions() {
 
    }
    public VisualforceExtensions(ApexPages.StandardSetController controller) {
        sd = controller;
        sd.setPageSize(1);
    }
 
}