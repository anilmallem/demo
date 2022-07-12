public with sharing class BrokerFieldTracking {
    @AuraEnabled(cacheable=true)
    public static List<FeedItem> getLoanstatusFromFeed()
    {
        System.debug('inside method 1111');
        //list to store the feedItem with body This deal has changed from
        List<FeedItem> feedItemList = new List<FeedItem>();
        //get the loggedIn user Id
        Id brokerId = UserInfo.getUserId();
        System.debug('brokerId>>>>>>>>>>'+brokerId);
        //get the user deatail of loggedin User
        User user = [select Id,ContactId from user where Id =: brokerId];
        System.debug('user.ContactId>>>>>...'+user.ContactId);
        //get the feedItem which belongs to loggedIn user
        for(FeedItem feedItemObj : [SELECT ID, Title, Body, NetworkScope,ParentId,CreatedDate
                                    FROM FEEDItem
                                    WHERE ParentId IN (SELECT Id FROM Residential_Mortgage__c )
                                    AND Type ='TextPost' AND NetworkScope = 'AllNetworks' ORDER BY CreatedDate DESC])
        {
            //check the feedItem Body
            System.debug('feedItemObj>>>>>>>>>>>>>'+feedItemObj);
            System.debug('feedItemObj>>>>>>>>>>>>>+feedItemObj');
            if(feedItemObj.Body.contains('This deal has changed from'))
            {
                System.debug('size>>>>>>>>>>>'+feedItemList.size());
                if(feedItemList.size()>= 3){
                    break;
                }else{
                    feedItemList.add(feedItemObj);
                }
            }
        }
        if(feedItemList.size()>0){
             System.debug(feedItemList);
             return feedItemList;
        }
        else{
            return null;
        }
    }
}