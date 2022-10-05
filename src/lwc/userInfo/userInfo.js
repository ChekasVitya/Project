import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import {ShowToastEvent} from "lightning/platformShowToastEvent";

import OWNER_ID from '@salesforce/schema/Order.OwnerId';
import USER from '@salesforce/schema/User';
import NAME from '@salesforce/schema/User.Name';
import EMAIL from '@salesforce/schema/User.Email';
import PHONE from '@salesforce/schema/User.Phone';
import CITY from '@salesforce/schema/User.City';

const fields = [OWNER_ID];
export default class GetUserDetails extends LightningElement {
    @api recordId;

    fields = [
        NAME,
        EMAIL,
        PHONE,
        CITY,
    ]

    objectApiName = USER;

    @wire(getRecord, { recordId: '$recordId', fields})
    order;

    get getOwnerId() {
        return getFieldValue(this.order.data, OWNER_ID);
    }

    handleSubmit(){
        this.dispatchEvent(
            new ShowToastEvent({
                title : 'Successfully updated',
                variant : 'Success',
                message : 'User was successfully updated'
            })
        );
    }
}