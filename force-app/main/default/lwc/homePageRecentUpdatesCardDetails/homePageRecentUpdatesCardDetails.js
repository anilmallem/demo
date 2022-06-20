import { LightningElement, api, track } from 'lwc';

export default class HomePageRecentUpdatesCardDetails extends LightningElement {
   
    @api item;
    @track custombody;
    @track updateddate;

    connectedCallback() {
        this.custombody = this.item.Body.substring(this.item.Body.indexOf('Update') + 27);
        //console.log('>>>>>>>>>>',localizationService.formatDate(this.date, " DD MMMM YYYY, hh:mm:ss a"));
        //let dateValueFormat = $A.localizationService.formatDate(dateValue, " DD MMMM YYYY");
        let dt = new Date(this.item.CreatedDate);
        const dtf = new Intl.DateTimeFormat('en', {
            year: 'numeric',
            month: 'long',
            day: '2-digit'
        })
        const [{ value: mo }, , { value: da }, , { value: ye }] = dtf.formatToParts(dt);

        let formatedDate = `${da} ${mo} ${ye}`;
        console.log('formatedDate ===> ' + formatedDate);
        this.updateddate = formatedDate;
    }
    get parentid() {
        console.log('>>>>>>>>>>>>..'+this.item.ParentId);
        if(this.item.ParentId == null)
        return true;
        else{
            return false;
        }
    
    }

}