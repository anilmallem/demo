import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class TelstraSubmitAccountRecord extends LightningElement {
    meetingRooms = [
        { name: 'A-10', capacity: '10' },
        { name: 'A-20', capacity: '6' },
        { name: 'A-30', capacity: '15' },
        { name: 'B-10', capacity: '12' },
        { name: 'B-20', capacity: '6' }
    ];
    @track result;
    @track Num1;
    @track Num2;
    @track Num3;
    handleInputChange(event) {
        var temdata = [];
        this.meetingRooms.forEach(element => {
            var contdat = {};

            contdat.name = element.name;
            console.log('name>>>' + contdat.name);
            contdat.capacity = element.capacity;
            
            if (event.target.name == element.name) {

                var ip = event.target.value;
                var strip = ip.toString();
                console.log("length" + strip.length);
                var firstVal;
                var lastVal;
                if (strip.length == 1) {
                    firstVal = event.target.value;
                    lastVal = null;
                }
                else {
                    firstVal = strip.substring(0, strip.length - 1);

                    lastVal = strip.substring(strip.length - 1, strip.length);
                }
                console.log("1 value" + firstVal);
                console.log('2 value' + lastVal);
                var temp = "";
                var temp2 = (firstVal);                       //input box value
                var input = (lastVal);                          //input key in value
                temp = parseInt(temp2.replace(/\D/g, '')); //replace the specail char 
                console.log('check temp' + temp);
                var finalVal = temp + input;                // add like string and format it
                console.log('check final value' + finalVal);
                console.log('check name>>>>' + event.target.name);
                this.result = (finalVal / 100).toFixed(2);
                console.log("Formatted: " + finalVal / 100); // 12.34
                contdat.value = this.result;

            }
            else{
                contdat.value = element.value;
            }
            

            temdata.push(contdat);

        });
        this.meetingRooms = temdata;
        console.log("check meeting rooms" +JSON.stringify (this.meetingRooms));


    }
    handleEvent() {
        var temp = "";
        var temp2 = "12";                       //input box value
        var input = "4";                          //input key in value
        temp = parseInt(temp2.replace(/\D/g, '')); //replace the specail char 
        var finalVal = temp + input;                // add like string and format it
        console.log("Formatted: " + finalVal / 100); // 12.34
        if (this.Num1 != null) {
            console.log("submit button");

        }
        console.log('length>>>' + this.meetingRooms.length);
        let val = [];
        for (var i = 0; i <= this.meetingRooms.length; i++) {
            console.log('inside for');
            let inputName = this.template.querySelector("." + this.meetingRooms[i].name);
            console.log('Check inputname>>>>>>' + inputName);

            val[i] = inputName.value;
            console.log("check value>>>>>>." + val[i])
            console.log("check value>>>>>>." + val[i]);

            if (val[i] != null && val[i] != '') {
                console.log('check value of' + i + "is" + val[i]);
                console.log('inside first if');
                break;
            }
            console.log('check size>>' + val.length);
            console.log('check length2' + this.meetingRooms.length);
            console.log('check value of' + i + "is" + val[i]);
            if (val.length == this.meetingRooms.length) {
                console.log('inside 2 if');
                const event = new ShowToastEvent({
                    title: 'Toast message',
                    message: 'Toast Message',
                    variant: 'Error',
                    mode: 'dismissable'
                });
                this.dispatchEvent(event);

            }

        }
        console.log('After for loop');


    }
}