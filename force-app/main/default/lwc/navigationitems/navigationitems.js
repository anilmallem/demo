import { LightningElement, track } from 'lwc';
 
export default class LwcVerticalNavigation extends LightningElement {
   
    @track currentContent = 'home';
    
    @track homeValue = true;    
    @track dealsValue = false;
    @track resourcecenterValue = false;
    @track instashareValue = false;
    @track ratesandcompValue = false;
    @track guidanddocValue = false;
    @track selected;
 
    changeHandleAction(event) {
        console.log("name"+event.detail.name);
         this.selected = event.detail.name; 
         console.log("this.selected"+this.selected);
            
 
        this.currentContent = this.selected;
 
        if (this.selected == 'home'){
            this.homeValue = true;
        }else{
            this.homeValue = false;
        }
 
        if (this.selected == 'deals'){
            this.dealsValue = true;
        }else{
            this.dealsValue = false;
        }
 
        if (this.selected == 'resourcecenter'){
            this.resourcecenterValue = true;
        }else{
            this.resourcecenterValue = false;
        }
 
        if (this.selected == 'instashare'){
            this.instashareValue = true;
        }else{
            this.instashareValue = false;
        }
 
        if (this.selected == 'ratesandcomp'){
            this.ratesandcompValue = true;
        }else{
            this.ratesandcompValue = false;
        }
 
        if (this.selected == 'guidanddoc'){
            this.guidanddocValue = true;
        }else{
            this.guidanddocValue = false;
        }
 
    }
}