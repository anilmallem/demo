import {LightningElement,api,wire,track } from 'lwc';
import getPromoBanner from '@salesforce/apex/CTCHomePageBannersController.getPromoBanner';

const CARD_HIDDEN_CLASSES = 'slds-hide'
const DOT_HIDDEN_CLASSES = 'dot'
const CARD_VISIBLE_CLASSES = 'slds-show'
const DOT_VISIBLE_CLASSES = 'dot active'

export default class Banner extends LightningElement {

    @track slideIndex = 1;
    
     PageList = [];
   
    @track banners;

    @track slides = [];
   
    @track desktopBannerSize;

    @track data = [];


    


    @wire(getPromoBanner)
    promoBannerList({ error, data }) {
        console.log('Banners>>>>>',JSON.stringify(data));
        if (data) {
            this.banners = data;
            this.desktopBannerSize = this.banners.desktopBannerId.length;
            console.log('check length>>>>>>>'+this.banners.desktopBannerId.length);
            for (var i = 0; i < this.desktopBannerSize; i++) {
              this.PageList.push(this.banners.desktopBannerId[i]);
          }
          console.log('check data length'+JSON.stringify(this.PageList));
         
        //   this.slides = this.PageList.map((item,index)=>{
        //       return index === 0 ? {
        //           ...item,
        //           slideIndex : index+1,
        //           cardClasses:CARD_VISIBLE_CLASSES,
                 

        //       }:{
        //           ...item,
        //           slideIndex : index+1,
        //           cardClasses:CARD_HIDDEN_CLASSES,
                

        //       }
        //   })
           
          
        } else if (error) {
            this.error = error;
            console.log('error>>>>>', error);
            this.banners = undefined;
        }
        //eval("$A.get('e.force:refreshView').fire();");
    }
    
   

    // backSlide(){
    //     let slideIndex = this.slideIndex - 1;
    //     this.slideSelectionHandler(slideIndex); 
    // }
    // forwardSlide(){
    //     let slideIndex = this.slideIndex + 1;
    //     this.slideSelectionHandler(slideIndex); 
    // }
    // slideSelectionHandler(id){
    //     if(id > this.slides.length){
    //         this.slideIndex = 1;
    //     }
    //     else if(id < 1){
    //         this.slideIndex = this.slides.length;
    //     }
    //     else{
    //         this.slideIndex = id;
    //     }
    //     this.slides = this.slides.map(item=>{
    //         return this.slideIndex === item.slideIndex ? {
    //             ...item,
    //             cardClasses:CARD_VISIBLE_CLASSES,
    //             dotClases : DOT_VISIBLE_CLASSES
                

    //         }:{
    //             ...item,
    //             cardClasses:CARD_HIDDEN_CLASSES,
    //             dotClases : DOT_HIDDEN_CLASSES
                

    //         }
    //     })

    // }
  

  
}