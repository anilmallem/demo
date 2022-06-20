import { LightningElement,wire,api,track } from 'lwc';

import communityId from '@salesforce/community/Id';
import communityBasePath from '@salesforce/community/basePath';


//import getNavItems from '@salesforce/apex/NavMenuController.getNavItems';
import getConnectNavigationItems from '@salesforce/apex/NavMenuController1.getConnectNavigationItems';

export default class CTC_CommunityNavigation extends LightningElement {
    @api recordId;
    @track menuItems;
    @track error;
    @track communityId = Network.getNetworkId();
    currentcommunityId;
    currentcommunityBasePath;
    @track menuName = 'Default_Navigation6';
    connectedCallback() {
        console.log('inside conctcallback');
        this.currentcommunityBasePath = communityBasePath;
        this.currentcommunityId = communityId;

    }
    
    @wire(getConnectNavigationItems, {
        menuName: '$menuName',
        communityId: '$currentcommunityId'
      })
      wiredNavigationItems({ error, data }) {
        if (data) {
          this.menuItems = data.menuItems;
        } else if (error) {
          this.error = error;
        }
      }
//       connectedCallback() {
//         this.currentcommunityId = communityId;
//         this.currentcommunityBasePath = communityBasePath;
//         console.log('errrrrrrrrrrrrrrrrro');
       
//         getConnectNavigationItems({menuName:this.menuName,communityId:'D0DB5j00000003Jq'}).then(result =>{
//          console.log('result>>>>>>>' + result);
//          this.menuItems = result;
       
//      })
//      .catch(error =>{
//          console.log('error' + error);
//          this.error = error;
     
//      })
//  }
 navigateToItem(event) {
    // Get the menu item's label from the target
    let selectedLabel = event.currentTarget.dataset.label;
   

    // Filter the menu items for the selected item
    let item = this.menuItems.filter(
      menuItem => menuItem.label === selectedLabel
    )[0];
    
    // Distribute the action to the relevant mechanisim for navigation
    if (item.urlType === "ExternalLink") {
      this.navigateToExternalPage(item);
    } else if (item.urlType === "InternalLink") {
      this.navigateToInternalPage(this.baseUrl, item);
    }
  }
  navigateToInternalPage(item) {
    // Use the basePath from the Summer '20 module to construct the URL
    const pageName = this.currentcommunityBasePath+ item.url;
    this[NavigationMixin.Navigate]({
      type: "standard__webPage",
      attributes: {
        url: pageName
      }
    });
  }
}