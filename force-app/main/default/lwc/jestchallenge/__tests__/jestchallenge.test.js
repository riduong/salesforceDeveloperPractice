import { createElement } from 'lwc';
import Jestchallenge from 'c/jestchallenge';

describe('c-jestchallenge', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });
    it('updates input value when user types', () => {
        const element = createElement('c-jestchallenge', {
            is: Jestchallenge
        });
        document.body.appendChild(element);

        const input = element.shadowRoot.querySelector('lightning-input');
        
        input.value = 'Hello LWC';
        input.dispatchEvent(new CustomEvent('change', { detail: { value: 'Hello LWC' } }));

        return Promise.resolve().then(() => {
            const updatedInput = element.shadowRoot.querySelector('lightning-input');
            expect(updatedInput.value).toBe(input.value);
        });
    });

    it('displays text when button is clicked', () => {
        const element = createElement('c-jestchallenge', {
            is: Jestchallenge
        });
        document.body.appendChild(element);

        const input = element.shadowRoot.querySelector('lightning-input');
        const button = element.shadowRoot.querySelector('lightning-button');

        input.value = 'Test Input';
        input.dispatchEvent(new CustomEvent('change'));

        button.click();

        return Promise.resolve().then(() => {
            const displayedText = element.shadowRoot.querySelector('p').textContent;
            expect(displayedText).toBe(input.value);
        });
    });
});
