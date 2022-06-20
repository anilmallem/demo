import { LightningElement, track, api, wire } from 'lwc';
import getPromoBanner from '@salesforce/apex/CTCHomePageBannersController.getPromoBanner';

export default class Pagination extends LightningElement {
    @track value = 'next';
    autoScroll = true;
    scrollDuration = 5000;
    @track banners;
    @track error;
    @track desktopBannerLength;
    @track pageSize = 1;
    @track startPage;
    @track endPage;
    @track dektopBannerList;
    @track autoRotate = true;
    @track stopNext = false;
    @track stopPrevious = true;
    @track desktopBannerSize;
    @track bannerIntervals;
    @track desktopList;
    @track progress = 5000;
    // connectedCallback()
    // {
    //     this._interval = setInterval(() => {
    //         var i=0;
    //         if ( i < this.banners.desktopBannerId.length  ) {
    //             this.desktopList = this.banners.desktopBannerId;
    //             console.log(' this.desktopList', this.desktopList);
    //             this.startPage= i;
    //             console.log(' startPage', this.startPage);
    //             this.endPage = i;
    //             console.log(' endPage', this.endPage);
    //             this.dektopBannerList =desktopList[i];
    //             console.log(' this.dektopBannerList', this.dektopBannerList);
    //             this.progress = this.progress + 5000;
    //             console.log(' this.progress', this.progress);
    //             i++;
    //         }else{
    //             i=0;
    //         this.desktopList = this.banners.desktopBannerId;
    //         this.startPage= i;
    //         this.endPage = i;
    //         this.dektopBannerList =desktopList[i];
    //         console.log(' this.dektopBannerList', this.dektopBannerList);
    //         }
    //             clearInterval(this._interval);
    //         },this.progress);
    //         console.log(' this.progressprogress', this.progress);
    // }
    @wire(getPromoBanner)
    promoBannerList({ error, data }) {
        console.log('Banners>>>>>', data);
        
        if (data) {
            this.banners = data;
            this.desktopBannerSize = this.banners.desktopBannerId.length;
            if (this.banners.desktopBannerId.length > 1) {
                this.desktopBannerLength = true;
            }
            else {
                this.desktopBannerLength = false;
            }
            this.startPage = 0;
            this.endPage = this.pageSize - 1;
            var PagList = [];
            var i = 0;
            if (this.banners.desktopBannerId.length > i) {
                for (var i = 0; i < this.pageSize; i++) {
                    PagList.push(this.banners.desktopBannerId[i]);
                }
                this.dektopBannerList = PagList;
            }
           
            this.error = undefined;
        } else if (error) {
            this.error = error;
            console.log('error>>>>>', error);
            this.banners = undefined;
        }
    }
    // handleSlideSelection(index){
    //     if (index > this.slides.length) {
    //         this.slideIndex = 1;
    //       } else if (index < 1) {
    //         this.slideIndex = this.slides.length;
    //       } else {
    //         this.slideIndex = index;
    //       }
      
    //       this.slides = this.slides.map((slide) => {
    //         if (this.slideIndex === slide.index) {
    //           return {
    //             ...slide,
    //             slideClass: 'fade slds-show',
    //             dotClass: 'dot active'
    //           };
    //         }
    //         return {
    //           ...slide,
    //           slideClass: 'fade slds-hide',
    //           dotClass: 'dot'
    //         };
    //       });

    // }
    connectedCallback() {
        if(this.value == 'next'){
            if (this.autoScroll) {
                this.timer = window.setInterval(() => {
                  this.next();
                }, Number(this.scrollDuration));
              }
        }
        else if(this.value == 'previous'){
            if (this.autoScroll) {
                this.timer = window.setInterval(() => {
                  this.previous();
                }, Number(this.scrollDuration));
              }
        }
       
      }
      disconnectedCallback() {
        if (this.autoScroll) {
          window.clearInterval(this.timer);
        }
        
      }
    previous() {
        console.log('inside previous');
        var desktopList = this.banners.desktopBannerId;
        var end = this.endPage;
        var start = this.startPage;
        var pageSize = this.pageSize;
        console.log(pageSize);
        var PagList = [];
        var counter = 0;
        for (var i = start - pageSize; i < start; i++) {
            if (i > -1) {
                PagList.push(desktopList[i]);
                counter++;
            } else {
                start++;
            }
        }
        start = start - counter;
        console.log(start);
        end = end - counter;
        console.log(end);
        this.startPage = start;
        this.endPage = end;
        this.dektopBannerList = PagList;
        if (this.endPage + 1 <= this.desktopBannerSize) {
            this.stopNext = false;
        }
        if (this.startPage == 0) {
            this.stopPrevious = true;
            this.value = 'next';
            this.disconnectedCallback();
            this.connectedCallback();

        }
        else {
            this.stopPrevious = false;
        }
    }
    next() {
        console.log('inside next');
        var desktopList = this.banners.desktopBannerId;
        var end = this.endPage;
        var start = this.startPage;
        var pageSize = this.pageSize;
        console.log(pageSize);
        var PagList = [];
        var counter = 0;
        for (var i = end + 1; i < end + pageSize + 1; i++) {
            if (desktopList.length > i) {
                PagList.push(desktopList[i]);
            }
            console.log('pagList', PagList);
            counter++;
        }
        start = start + counter;
        end = end + counter;
        this.startPage = start;
        this.endPage = end;
        this.dektopBannerList = PagList;
        console.log('EndPAge>>>', this.endPage);
        if (this.endPage + 1 >= this.desktopBannerSize) {
            this.stopNext = true;
            this.value = 'previous';
            this.disconnectedCallback();
            this.connectedCallback();
            
        }
        if (this.startPage == 0) {
            this.stopPrevious = true;
        }
        else {
            this.stopPrevious = false;
        }
    }
    // autoRotate(indexNumber) {
    //     var desktopList = this.banners.desktopBannerId;
    //     this.startPage = indexNumber;
    //     this.endPage = indexNumber;
    //     this.dektopBannerList = desktopList[indexNumber];
    // }
    // buttonClick() {
    //     console.log('>>>><<<<')
    //     const index = Number(div.getAttribute('indx'));
    //     console.log('index>>>',index);
    //     i=index;
    //     this.desktopList = this.banners.desktopBannerId;
    //     this.startPage= i;
    //     this.endPage = i;
    //     this.dektopBannerList =desktopList[i];
    //     const divs = this.template.querySelectorAll('slds-button');
    //     console.log('divs length' + divs.length);
    //     Array.from(divs).forEach((div) => {
    //       const index = Number(div.getAttribute('indx'));
    //       console.log('index>>>',index);
    //     });
    // }
}