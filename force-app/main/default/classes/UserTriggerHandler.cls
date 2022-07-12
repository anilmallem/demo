/**
* @File Name          : UserTriggerhandler.apxc
* @Description        : To display the nickname 
* @Author             : Anil Mallem 
* @Group              : 
* @Last Modified By   : Anil Kumar
* @Last Modified On   : 28/02/2022
* @Modification Log   : 
* Ver       Date            Author      		    Modification
* 1.0    28/02/2022         Anil Mallem              Initial Version
**/
public class UserTriggerHandler {
    public static void addUser(List<User> newUsers){
        
         //Set<String> nicknames = new Set<String>();
        //Integer count = 2;
        for(User u  :newUsers){
           u.CommunityNickname= u.FirstName.subString(0,1) + u.LastName.subString(0,1); 
          // nicknames.add(u.CommunityNickname);
           String s = '%' + u.CommunityNickname + '%' ;
           List<User> getDuplicates = [SELECT CommunityNickname FROM User WHERE CommunityNickname LIKE : s];
           if(getDuplicates.size()>0){
               u.CommunityNickname = u.CommunityNickname + '[' + getDuplicates.size() +']' ; 
              // count++ ;
              //  System.debug(count);
           }
           System.debug(getDuplicates);
           System.debug(getDuplicates.size());
          //  System.debug(count);
           
        }
       
        
    }
}