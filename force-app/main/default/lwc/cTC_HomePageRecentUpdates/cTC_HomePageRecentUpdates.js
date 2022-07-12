import { LightningElement, track, wire } from 'lwc';
import getLoanstatusFromFeed from '@salesforce/apex/BrokerFieldTracking.getLoanstatusFromFeed';
export default class CTC_HomePageRecentUpdates extends LightningElement {
    @track feedItems = [];
    @track error;
    @track isLoaded = false;
    connectedCallback() {
        this.isLoaded = true;
        getLoanstatusFromFeed().then(result => {
            console.log('result' + result);
            var results = [];
            result.forEach(element => {
                
                var contdat = {};
                let dt = new Date(element.CreatedDate);
                const dtf = new Intl.DateTimeFormat('en', {
                    year: 'numeric',
                    month: 'long',
                    day: '2-digit'
                })
                const [{ value: mo }, , { value: da }, , { value: ye }] = dtf.formatToParts(dt);

                let formatedDate = `${da} ${mo} ${ye}`;
                console.log('formatedDate ===> ' + formatedDate);
                this.updateddate = formatedDate;
                contdat.Title = element.Title;
                console.log('check first>>>>>>>'+ contdat.Title);
                contdat.Body = element.Body.substring(element.Body.indexOf('Update') + 27);
                console.log('check first body>>>>>>>'+ contdat.Body);
                contdat.CreatedDate =  this.updateddate;
                results.push(contdat);
                    
                // this.feedItems = result;
                
            });
           
            this.feedItems = results;
            console.log('>>>>>>>>>>>>>>>>>>>>'+JSON.stringify(this.feedItems));
            this.isLoaded = false;
            })
        
                .catch(error => {
                    console.log('error' + error);
                    this.error = error;
                    this.isLoaded = false;
                })
            
        }
// this.custombody = this.item.Body.substring(this.item.Body.indexOf('Update') + 27);
//         //console.log('>>>>>>>>>>',localizationService.formatDate(this.date, " DD MMMM YYYY, hh:mm:ss a"));
//         //let dateValueFormat = $A.localizationService.formatDate(dateValue, " DD MMMM YYYY");
//         let dt = new Date(this.item.CreatedDate);
//         const dtf = new Intl.DateTimeFormat('en', {
//             year: 'numeric',
//             month: 'long',
//             day: '2-digit'
//         })
//         const [{ value: mo }, , { value: da }, , { value: ye }] = dtf.formatToParts(dt);

//         let formatedDate = `${da} ${mo} ${ye}`;
//         console.log('formatedDate ===> ' + formatedDate);
//         this.updateddate = formatedDate;


    
    
 }


