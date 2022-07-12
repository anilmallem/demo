public with sharing class NavMenuController {
    @AuraEnabled(cacheable=true)
    public static List<NavigationMenuItem> getNavItems(){   
        List<NavigationMenuItem> navigationItems = [SELECT Id, Label, NavigationLinkSetId, Type, Target, Status FROM NavigationMenuItem];
        return navigationItems; 
     }
}