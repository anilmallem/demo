import { LightningElement } from 'lwc';
import myResourceActive from '@salesforce/resourceUrl/video';

export default class VideoPlayer extends LightningElement {
    video = myResourceActive;
    connectedCallback(){
        console.log(System.URL.getOrgDomainUrl().toExternalForm());
    }
}