public with sharing class VFChallenge10Controller {
    public String filterKeyword { get; set; }

    public VFChallenge10Controller() {
        filterKeyword = '';
    }

    public PageReference redirectToFilteredPage() {
        PageReference pageRef = new PageReference('/apex/visualforceCodingChallenge?filter=' + EncodingUtil.urlEncode(filterKeyword, 'UTF-8'));
        pageRef.setRedirect(true);
        return pageRef;
    }
}
