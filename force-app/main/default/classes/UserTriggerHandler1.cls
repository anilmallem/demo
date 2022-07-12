public class UserTriggerHandler1 {
    public static void getUser(List<user> users){
       // List<User> oldUsers = [SELECT CommunityNickname FROM User WHERE ID IN : usersId];
          for(User u  : users){
           u.CommunityNickname= u.FirstName.subString(0,1) + u.LastName.subString(0,1);
           User oldUser = (User) Trigger.oldMap.get(u.Id); 
          }
         
         
         
    }
}