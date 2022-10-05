import {LightningElement, track, wire} from "lwc";
import getUser from '@salesforce/apex/UserController.getUser';

export default class allUser extends LightningElement {

    @track userData;
    @track error;

    @wire (getUser) wiredUser({data,error}){
        if (data) {
            this.userData = data;
            this.error = undefined;
            console.log(`Data returned: + ${this.userData}`);
        } else if (error) {
            this.error = error;
            this.userData = undefined;
        }
    }
}