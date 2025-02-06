import { createElement } from 'lwc';
import Lwc8 from 'c/lwc8';
import getContact from '@salesforce/apex/LWCHelper.getContact';
import { registerApexTestWireAdapter } from '@salesforce/sfdx-lwc-jest';

const getContactAdapter = registerApexTestWireAdapter(getContact);

describe('c-lwc8', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        jest.clearAllMocks();
    });

    it('renders contact details when data is available', async () => {
        const element = createElement('c-lwc8', {
            is: Lwc8
        });
        document.body.appendChild(element);

        const mockContact = { Id: '003', Name: 'Alice Smith', Email: 'alice.smith@example.com' };
        getContactAdapter.emit(mockContact);

        return Promise.resolve().then(() => {
            const nameParagraph = element.shadowRoot.querySelector('p:nth-of-type(1)');
            expect(nameParagraph.textContent).toBe('Name: Alice Smith');

            const emailParagraph = element.shadowRoot.querySelector('p:nth-of-type(2)');
            expect(emailParagraph.textContent).toBe('Email: alice.smith@example.com');
        });
    });

    it('renders nothing when no contact data is available', async () => {
        const element = createElement('c-lwc8', {
            is: Lwc8
        });
        document.body.appendChild(element);

        getContactAdapter.emit(undefined);

        return Promise.resolve().then(() => {
            const nameParagraph = element.shadowRoot.querySelector('p:nth-of-type(1)');
            expect(nameParagraph).toBeNull();

            const emailParagraph = element.shadowRoot.querySelector('p:nth-of-type(2)');
            expect(emailParagraph).toBeNull();
        });
    });
});
