import { LightningElement, wire } from 'lwc';
import getBands from '@salesforce/apex/LWCHelper.getBands';

export default class Challenge5Parent extends LightningElement {
    bands = [];
    selectedBandId = '';
    selectedBand = null;
    selectedDescription = '';
    bandOptions = [];
    isSidebarVisible = false;


    @wire(getBands)
    wiredBands(result) {
        if (result.data) {
            this.bands = result.data;

            this.bandOptions = this.bands.map(band => ({
                label: band.Name,
                value: band.Id
            }));
        } else if (result.error) {
            console.error(result.error);
        }
    }


    handleBandSelection(event) {
        const selectedId = event.target.value;
        this.selectedBandId = selectedId;

        this.selectedBand = this.bands.find(band => band.Id === selectedId);
        this.isSidebarVisible = false;
    }

    handleLearnMore() {
        const selectedBand = this.bands.find(band => band.Id === this.selectedBandId);
        if (selectedBand) {
            this.selectedDescription = selectedBand.Description__c;
            this.isSidebarVisible = true;
        }
    }
}
