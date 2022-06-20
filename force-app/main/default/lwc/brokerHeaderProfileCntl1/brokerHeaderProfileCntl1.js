import { api, LightningElement,track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import communityBasePath from '@salesforce/community/basePath';
import feedbackUrl from '@salesforce/label/c.Broker_Feedback_URL';
import logOutUrl from '@salesforce/label/c.Broker_logout_URL';


// import Broker_Feedback_Icon from '@salesforce/resourceUrl/Broker_Feedback_Icon';

export default class BrokerHeaderProfileCntl extends NavigationMixin(LightningElement) {
    label = {
        feedbackUrl
    };

   @track Open=false;
    @track selectedOption;
    @track isModalOpen;
    @track dropdownlist = false;
    @api dropdownlist;
    @track options = ['Home','My Profile','My Settings','Logout'];
    @track userInfo=String;
    // Broker_Feedback_Iconurl = Broker_Feedback_Icon;
    
    
    drop(event){  
        console.log('in drop>>>>>>>>>>>');
        if(this.Open==false) {
            this.Open=true;
        } 
        else{
            this.Open=false;
        }
    }

    openModel(event) {
        // for Display Model,set the "isOpen" attribute to "true"
        component.set("v.isOpen", true);
    }
    
    closeModel( event) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
        component.set("v.isOpen", false);
    }
    onClick( event) {
        var id = event.target.dataset.menuItemId;
        if (id) {
            component.getSuper().navigate(id);   
        }
        if(id == undefined){
            var elements = document.getElementsByClassName("showDropDown");
            if(component.get("v.showRCTab")){
                elements[0].style.display = 'none';
                component.set("v.showRCTab", false);
            }else{
                elements[0].style.display = 'block';
                component.set("v.showRCTab", true);
                
            }
        }
    }
    onClickParent(event) {
        var id = event.target.dataset.menuItemId;
        if (id) {
            component.getSuper().navigate(id);   
        }
    }
    openSearchModel( event) {
        console.log('Id>>>>>openSearchModel>>>>');
        component.set("v.openSearchBar", true);
        
    }
    closeSearchModel ( event ) {
        component.set("v.openSearchBar", false);
        
    }
    onClickIcon (event) {        
        console.log('>>>>onClickIcon value>>>>',event.currentTarget.getAttribute("data-attriVal"));
        var tabName = event.currentTarget.getAttribute("data-attriVal")
        var navEvt = A.get('e.force:navigateToURL');
        if(tabName =='Dashboard'){
            navEvt.setParams({url: '/'});
        }else if(tabName =='deal'){
            navEvt.setParams({url: '/deal-list'});
        } 
            else if(tabName =='messageCentre'){
                navEvt.setParams({url: '/messageCentre'}); 
            }
                else if(tabName =='ContactUs'){
                    navEvt.setParams({url: '/contact-us'}); 
                }
        navEvt.fire();
    }

    handleClick(event) {
        console.log('inside of function');
        console.log("base url"+ communityBasePath);
        let targetId = event.target.dataset.targetId;
        console.log('get name ' +targetId );
        // this[NavigationMixin.Navigate]({
        //     type: 'standard__objectPage',
        //     attributes: {
        //         objectApiName: 'Account',
        //         actionName: 'new'
        //     },
        // });
        if(targetId == 'Home'){
            this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                    url : communityBasePath + '/'
                },
            });
        }
        if(targetId == 'Logout'){
            console.log('get logout url'+window.location.hostname);
            window.location.replace(logOutUrl);
            // this[NavigationMixin.Navigate]({
            //     type: 'standard__webPage',
            //     attributes: {
            //         url : communityBasePath + '/logout'
            //     },
            // });
        }
        // if(targetId == 'Feedback'){
        //     this[NavigationMixin.Navigate]({
        //         type: 'standard__webPage',
        //         attributes: {
        //             url : feedbackUrl
        //         },
        //     });
        // }

        // this[NavigationMixin.Navigate]({
        //     type: 'standard__webPage',
        //     attributes: {
        //         url : communityBasePath + '/deal'
        //     },
        // });
        // var userId =event.get("SObjectType.CurrentUser.Id");
        // var source = event.getSource();
        // var label = source.get("label");
        // console.log('label'+label);
        // if(label=="Home"){
        //     var navEvt = event.get('e.force:navigateToURL');
        //     navEvt.setParams({url: '/'});
        //     navEvt.fire();
        // } else if(label=="My Profile"){
        //     var urlEvent = event.get("e.force:navigateToURL");
        //     urlEvent.setParams({ "url": "/user-profile/" });
        //     urlEvent.fire();
        // }else if(label=="My Settings"){
        //     var navEvt = event.get('e.force:navigateToURL');
        //     navEvt.setParams({url: '/settings/'+userId});
        //     navEvt.fire();
        // }else if(label=="Logout"){
        //     let hostname = window.location.hostname;
		// 	console.log('window.location.hostname',window.location.hostname);
        //    // window.location.replace('https://preprod-questrade.cs123.force.com/BrokersPortal/secur/logout.jsp?retUrl=https%3A%2F%2Fpreprod-questrade.cs123.force.com%2FBrokersPortal%2FBrokerlogin');
        //     window.location.replace(event.get("Label.c.Broker_logout_URL"));
        //     //window.location.replace("https://questrade.force.com/BrokersPortal/secur/logout.jsp?retUrl=https%3A%2F%2Fquestrade.force.com%2FBrokersPortal%2F%2FBrokerlogin");
        //     //window.location.replace('https://ctcstage-questrade.cs14.force.com/BrokersPortal/secur/logout.jsp?retUrl=https%3A%2F%2Fctcstage-questrade.cs14.force.com%2FBrokersPortal%2FBrokerlogin');
        // }
        
    }
}