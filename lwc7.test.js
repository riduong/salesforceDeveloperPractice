import { createElement } from 'lwc';
import ApexImperativeMethod from 'c/lwc7';
import searchContact from '@salesforce/apex/LWCHelper.searchContact';

jest.mock(
    '@salesforce/apex/LWCHelper.searchContact',
    () => ({
        default: jest.fn(),
    }),
    { virtual: true }
);

describe('c-lwc7', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        jest.clearAllMocks();
    });

    it('updates search term and calls Apex method on input change', () => {
        const element = createElement('c-lwc7', {
            is: ApexImperativeMethod
        });
        document.body.appendChild(element);

        searchContact.mockResolvedValue({ Id: '001', Name: 'John Doe', Email: 'john.doe@example.com' });

        const input = element.shadowRoot.querySelector('lightning-input');
        input.value = 'John';
        input.dispatchEvent(new CustomEvent('change'));

        return Promise.resolve().then(() => {
            expect(searchContact).toHaveBeenCalledWith({ searchTerm: 'John' });
        });
    });

    it('renders contact details when Apex method returns data', () => {
        const element = createElement('c-lwc7', {
            is: ApexImperativeMethod
        });
        document.body.appendChild(element);

        searchContact.mockResolvedValue({ Id: '002', Name: 'Jane Doe', Email: 'jane.doe@example.com' });

        const input = element.shadowRoot.querySelector('lightning-input');
        input.value = 'Jane';
        input.dispatchEvent(new CustomEvent('change'));

        return Promise.resolve().then(() => Promise.resolve()).then(() => {
            const nameParagraph = element.shadowRoot.querySelector('p strong');
            expect(nameParagraph.textContent).toBe('Jane Doe');

            const emailParagraph = element.shadowRoot.querySelector('p:nth-of-type(2)');
            expect(emailParagraph.textContent).toBe('Email: jane.doe@example.com');
        });
    });

    it('clears contact details when input is empty', () => {
        const element = createElement('c-lwc7', {
            is: ApexImperativeMethod
        });
        document.body.appendChild(element);

        const input = element.shadowRoot.querySelector('lightning-input');
        input.value = 'Jane';
        input.dispatchEvent(new CustomEvent('change'));

        return Promise.resolve().then(() => {
            input.value = '';
            input.dispatchEvent(new CustomEvent('change'));

            return Promise.resolve();
        }).then(() => {
            const contactDetails = element.shadowRoot.querySelector('p strong');
            expect(contactDetails).toBeNull();
        });
    });
});
