import { LightningElement,api,track } from 'lwc';
	
import myResource from '@salesforce/resourceUrl/NavigationInActiveicon';
import myResourceActive from '@salesforce/resourceUrl/NavigationActiveicon';

export default class  ChildNavigation extends LightningElement {
   
    @api item = [];
    @track customClass;
    @track customClass1;
    @track customClass2;
    @track showDropDown = true;
    dashboard = myResource + '/dashboard.png';
    contactUs = myResource + '/ContactUs.png';
    deal = myResource + '/deal.png';
    resourceCentre = myResource + '/resourceCentre.png';
    messageCentre = myResource + '/messageCentre.png';
    dashboardActive = myResourceActive + '/dashboard.png';
    contactUsActive = myResourceActive + '/ContactUs.png';
    dealActive = myResourceActive + '/deal.png';
    resourceCentreActive = myResourceActive + '/resourceCentre.png';
    messageCentreActive = myResourceActive + '/messageCentre.png';

    connectedCallback(event){
        if(this.item.active){
           this.customClass = 'slds-is-active setSubMenu';
           this.customClass1 = 'slds-is-active' ;
        }
        else{
            this.customClass = '';
            this.customClass1 = '' ;
        }
        // if(this.item.subMenu){
        //     for(let i=0; i<this.item.subMenu.length; i++){
        //         console.log('total length>>>>>>>>>>.'+this.item.subMenu.length)
        //         console.log('check error resolve'+this.item.subMenu[i].active);
        //         if(this.item.subMenu[i].active){
        //             console.log('inside if for active');
        //             this.customClass2 = 'slds-is-active';
        //             console.log(' this.customClass2', this.customClass2);
        //             // this.template.querySelector('[data-id="checkActive"]').classList.add('slds-is-active');
        //         }
        //         else{
        //             // this.template.querySelector('[data-id="checkActive"]').classList.remove('showDropDown');
        //             this.customClass2 = '';
        //             console.log(' this.customClass2', this.customClass2);
        //         }
        //     }
        // }
        
        // else if(this.item.active || this.item.subMenu[0].active){
        //     this.customClass1 = 'slds-is-active';
        // }
    }
    get labelHome(){
        if(this.item.label == 'Home')
        return true;
        else{
            return false;

        }
        
    }
    get labelDeal(){
        if(this.item.label == 'Deals')
        return true;
        else{
            return false;

        }
    }
    get labelMessagecentre() {
        if (this.item.label == 'Message centre')
        return true;
        else {
            return false;
        }
    }
    get labelContactus() {
        if (this.item.label == 'Contact us')
        return true;
        else {
            return false;
        }
    }
    get labelResourcecentre() {
        if (this.item.label == 'Resource centre')
        return true;
        else {
            return false;
        }
    }
  
    navigateToMenu(event) {
        console.log('navigatetomenuchild'+this.item.active + this.item.label);
        console.log('inside child Lwc comp');
        console.log('check param'+ event.target.dataset.menuItemId);
        var id = event.target.dataset.menuItemId;
        if(id == undefined){
            console.log('inside if of undefined');
            var elements = document.getElementsByClassName('showDropDown');
            let firstClass = this.template.querySelector(".showDropDown");
            console.log('elements>>>>>>>>>>>'+elements);
            console.log('elements>>>>>>>>>>>'+firstClass);
            if(this.showDropDown == true){
                // this.template.querySelector(".showDropDown").style.display = 'none';
                this.template.querySelector('[data-id="myDiv"]').classList.remove('showDropDown1');
                this.template.querySelector('[data-id="myDiv"]').classList.add('showDropDown');
                // firstClass[0].display= 'none';
                this.showDropDown = false;
            }
            else{
                this.template.querySelector('[data-id="myDiv"]').classList.remove('showDropDown');
                this.template.querySelector('[data-id="myDiv"]').classList.add('showDropDown1');
                // firstClass[0].display= 'block';
                this.showDropDown = true;
            }
            
            
        }
        
        this.dispatchEvent(new CustomEvent('navigateto1', {
            detail: {
                menuItemId : event.target.dataset.menuItemId  
            }
        })); 
        // if(this.item.active == true){
        //     console.log('inside if check active');
        //     this.customClass = 'slds-is-active'
        //     // this.template.querySelector('[data-id="checkActive"]').classList.add('slds-is-active');
        //     // this.template.querySelector('[data-id="checkActive"]').classList.add('setSubMenu');
        // }
        // else{
        //     console.log('inside else check active');
        //     // this.template.querySelector('[data-id="checkActive"]').classList.remove('slds-is-active');
        //     // this.template.querySelector('[data-id="checkActive"]').classList.remove('setSubMenu');
        // } 
        console.log('navigatetomenuchild'+this.item.active + this.item.label);
    }
    navigateToMenuParent(event){
        console.log('navigatetomenuparentchild'+this.item.active + this.item.label);
        
        var id = event.target.dataset.menuItemId;
        
        this.dispatchEvent(new CustomEvent('navigateto1', {
            detail: {
                menuItemId : event.target.dataset.menuItemId  
            }
        })); 
        // if(this.item.active == true) {
        //     this.customClass = 'slds-is-active'
        // }
        
            console.log('Inside if of parent to check active');
            // this.template.querySelector('[data-id="checkActive"]').classList.add('slds-is-active');
       
        // else{
        //     this.template.querySelector('[data-id="checkActive"]').classList.remove('slds-is-active');
        // }
        console.log('navigatetomenuparentchild'+this.item.active + this.item.label);

    }
    onClickIcon(event) {
        var tabName = event.currentTarget.getAttribute("data-attriVal");
        console.log('tabname>>>>>>>>>>>>>>'+tabName);
        this.dispatchEvent(new CustomEvent('navigateto1', {
            detail: {
                tabName : event.currentTarget.getAttribute("data-attriVal")
            }
        })); 

    }
}