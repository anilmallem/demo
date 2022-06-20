import { LightningElement,track,api } from 'lwc';

export default class BrokerHeaderProfileCntl extends LightningElement {
    @track selectedOption;
    @track isModalOpen;
    @track dropdownlist = false;
    @api dropdownlist;
    @track listofmenu = ["Home","My Profile", "My Settings", "Logout"]
    
    @api
    dropdown(){
        if(this.dropdownlist == false){ 
            console.log('drop in>>>>>>>>>>>>');
            console.log(this.dropdownlist);
            this.template.querySelector('[data-id="mydiv"]').classList.remove('remove');
            this.template.querySelector('[data-id="mydiv"]').classList.add('drop');
            this.template.querySelector('[data-id="mydiv"]').classList.add('dropdown');
            this.dropdownlist=true;
        }
        else{
            console.log('drop remove>>>>>>>>>>>>');
            console.log(this.dropdownlist);
           this.template.querySelector('[data-id="mydiv"]').classList.remove('drop');
            this.template.querySelector('[data-id="mydiv"]').classList.add('remove');
            this.dropdownlist=false;
        }
        
    }
}