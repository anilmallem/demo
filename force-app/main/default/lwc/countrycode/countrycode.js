import { LightningElement } from 'lwc';

export default class Countrycode extends LightningElement {
   
    get options() {
        
        return [
                
                 { label: 'India', value: '+91' },
                 { label: 'Afghanistan', value: '+93' },
                 { label: 'Albania', value: '+355' },
                 { label: 'Algeria', value: '+213' },
                 { label: 'American Samoa', value: '+1-684' },
               ];
    }
    value = 'new';
    handleChange(event) {
            this.value = event.detail.value;
         }
        
}