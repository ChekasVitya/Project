import { LightningElement, track, wire } from 'lwc';
import relatedOrder from '@salesforce/apex/UserController.relatedOrder';

export default class orderForUser extends LightningElement {
    @track currentName;
    @track searchName;

    handleChange(event){
        this.currentName = event.target.value;
    }

    handleUserSearch(){
        this.searchName = this.currentName;
    }

    @track records;
    @track error;

    @wire (relatedOrder,{keySearch:'$searchName'})
    wireRecord({data,error}){
        if(data){
            this.records = data;
            console.log(`Data returned: + ${this.records}`);
        }else{
            this.error = error;
        }
    }
}