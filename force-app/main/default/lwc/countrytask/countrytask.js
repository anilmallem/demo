import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class CountryCode extends LightningElement {
    value = 'Country-Code';
    get options() {
        return [
                {label:"Norway (+47)" ,value: "+47"},
                {label:"UK (+44)" , value: "+44"},
                {label:"Algeria (+213)" , value:"+213"},
                {label:"Andorra (+376)" , value: "+376"},
                {label:"Angola (+244)" , value: "+244"},
                {label:"Anguilla/Barbuda (+1264)" , value: "+1264"},
                {label:"Argentina (+54)" , value: "+54"},
                {label:"Armenia (+374)" , value: "+374"},
                {label:"Aruba (+297)" , value: "+297"},
                {label:"Australia (+61)" , value: "+61"},
                {label:"Austria (+43)" , value: "+43"},
                {label:"Azerbaijan (+994)" , value: "+994"},
                {label:"Bahamas (+1242)" , value: "+1242"},
                {label:"Bahrain (+973)" , value: "+973"},
                {label:"Bangladesh (+880)" , value: "+880"},
                {label:"Barbados (+1246)" , value: "+1246"},
                {label:"Belarus (+375)" , value: "+375"},
                {label:"Belgium (+32)" , value: "+32"},
                {label:"Belize (+501)" , value: "+501"},
        ];
    }
    handleChange(event) {
        this.value = event.detail.value;
    }
   
    strName;
    strFirstName;
    strLastName;
    strEmail;
    strCountryCode;
    strPhone;
    firstnameChangedHandler(event){
        this.strFirstName = event.target.value;
    }
    lastnameChangedHandler(event){
        this.strLastName = event.target.value;
    }
    emailChangedHandler(event){
        this.strEmail = event.target.value;
    }
    countryCodeChangedHandler(event){
        this.strCountryCode = event.target.value;
    }
    phoneChangedHandler(event){
        this.strPhone = event.target.value;
    }
    save(event){
        this.strName = this.strFirstName + " " + this.strLastName;
        this.strPhone= this.strCountryCode +" " + this.strPhone;
        console.log('<<<<<<<strPhone>>>>>>>');
        console.log(this.strPhone);
        // Creating mapping of fields of Account with values
        var fields = {'Name' : this.strName, 'Email__c' : this.strEmail,'Country_Code__c' : this.strCountryCode, 'Phone' : this.strPhone};
        // Record details to pass to create method with api name of Object.
        var objRecordInput = {'apiName' : 'Account', fields};
        console.log('<<<<<test>>>>>>');
        console.log('<<<<<<objRecordInput>>>>>>>>>>',objRecordInput);
        // LDS method to create record.
      
        
        createRecord(objRecordInput).then(response => {
           // alert('Records Save Successfully: ' +response.id);
           const event = new ShowToastEvent({
            title: 'Success',
            message:
                'Record Saved Successfully',
            variant:'success'
        });
        this.dispatchEvent(event);
            this.strName=null;
            this.strFirstName=null;
            this.strLastName=null;
            this.strCountryCode=null;
            this.strEmail = null;
            this.strPhone = null;
        }).catch(error => {
            alert('Error: ' +JSON.stringify(error));
        });
        
    }
}