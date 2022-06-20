import { LightningElement,track } from 'lwc';

export default class StylingAcrossShodowDom extends LightningElement {
    
    @track inputValue = 10;

    customValue(event){
       this.inputValue =  event.target.value;
        
    }
    get custom(){
        return `width:${this.inputValue}%`
    }
    renderedCallback(){
        const style = document.createElement('style');
        style.innerText = `c-styling-across-shodow-dom .slds-button{
            color: blue;
            background : yellow;
        }
        `
        this.template.querySelector('lightning-button').appendChild(style);
    }
}