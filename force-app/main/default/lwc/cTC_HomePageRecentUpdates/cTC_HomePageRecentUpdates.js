import { LightningElement,track,wire } from 'lwc';
import getLoanstatusFromFeed from '@salesforce/apex/BrokerFieldTracking.getLoanstatusFromFeed';
export default class CTC_HomePageRecentUpdates extends LightningElement {
   @track feedItems;
   @track error;
   @track isLoaded = false;
   connectedCallback() {
       this.isLoaded = true;
    getLoanstatusFromFeed().then(result =>{
        console.log('result' + result);
        this.feedItems = result;
        this.isLoaded = false;
    })
    .catch(error =>{
        console.log('error' + error);
        this.error = error;
        this.isLoaded = false;
    })
}
 
}
