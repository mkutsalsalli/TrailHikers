public class AccountTriggerHandler {
    
    public static void createOppForAccount(Map<Id,Account> accNewMap){ //to store Id's in keyset

    List<Opportunity> oppList = new List<Opportunity>();
    // Add an opportunity for each account if it doesn't already has one.
    // Iterate over accounts that are in this trigger but that don't have opportunities.
    // keySet() method returns a set that contains all of the keys (id) in the map. 
        
    for (Account a : [SELECT Id,Name, 
                            (SELECT Id FROM Opportunities) 
                                FROM Account
                                WHERE Id IN :accNewMap.keySet()]) {
        
             if (a.Opportunities.isEmpty()){//if true, there is no opp and must create a new one 
         
                // Add a default opportunity for this account    
        oppList.add(new Opportunity(Name=a.Name + ' Opportunity',
                                   StageName='Prospecting',
                                   CloseDate=System.today().addMonths(1),   
                                   AccountId=a.Id)); 
             }                
    }//if there is no opp in account, I created a new one for each account records without opp!
        
    System.debug('Merge Test');
        if (!oppList.isEmpty()) {
            insert oppList;
        }
    }
}

/*0. git init
1. We do: git config --global user.name "anyName"
2. We do: git config --global user.email "github email"
3. Go to the source control: click on 3 dots and select remote>add remote>add from github
4. And select your previously created new repository from github rep list
5. Now you can commit and push by typing a message with blue button...
6. You can create branches in repo on GitHub
7. To be able to use newly created branch in vscode: first "git pull"
8. Then : "git checkout "newbranchname"
9. Do some changes: and go to source control and commit-push
10. Then go to the repository: create pull request after your friend review your change..
11. Finally you can merge your changes in your branch to the Main
*/
