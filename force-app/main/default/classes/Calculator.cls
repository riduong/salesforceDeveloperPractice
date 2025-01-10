public with sharing class Calculator {
    public static Decimal Calculator(String input) {
        //Removing White Space
        String input_list = input.replaceAll(' ','');
        
        List<String> string_list = new List<String>();

        //Evaluate Input
        return evaluateStringFunction(input);
    }

    // Recursively evaluate parentheses first
    public static Decimal evaluateStringFunction(String input) {
        System.debug('evaluateStringFunction: ' + input);
        while(input.contains('(')) {
            Integer startIndex = input.lastIndexOf('('); //Gets last '('
            Integer endIndex = input.indexOf(')', startIndex); //Gets first occurence of ')' from starting point

            // Getting the Substring of the inner most parentheses
            // IE. ((3 * (4 + 2) - 8) + 10) / 2 = 10 -> ((3*6 -8)+10)/2 -> ((18-8)+10)/2 -> ((10)+10)/2 -> (20)/2 -> 10
            String parenthesesExpression = input.substring(startIndex + 1, endIndex);
            //Checking for Multiplication and Division within parentheses (Higher prio than Addition and Subtraction)
            Decimal parenthesesResult = processMultiplyAndDivide(parenthesesExpression);

            input = input.substring(0,startIndex) + parenthesesResult + input.substring(endIndex + 1);
        }
        return processMultiplyAndDivide(input);
    }

    //Process multiplication and divison then sends to addition and subtraction
    private static Decimal processMultiplyAndDivide(String input) {
        input = input.replace('(','');
        input = input.replace(')','');
        input = input.replace(' ','');
        System.debug('multipy&Divide: ' + input);

        System.debug('CreateStringList:  ' + createStringList(input));

        List<String> parsedStringList = createStringList(input);
        // List to add/process results of multiplication & division then send to add & subtract
        List<String> resultList = new List<String>();

        for(Integer i = 0; i < parsedStringList.size(); i++) {
            System.debug('list size in Multi: ' + parsedStringList.size());
            String currentVal = parsedStringList.get(i);
            System.debug('current Val in Multi: ' + currentVal);
            System.debug('In : ' + i);
            if(currentVal == '*') {
                System.debug('decValue: ' + Decimal.valueOf(parsedStringList.get(i+1)));
                //Taking the previous element and doing multiplication with the next element. Then adding it into result list
                //resultList.add(''+Multiply(Decimal.valueOf(resultList.remove(resultList.size()-1)), Decimal.valueOf(input.substring(i+1,i+2))));
                resultList.add(''+ Multiply(Decimal.valueOf(resultList.remove(resultList.size()-1)), Decimal.valueOf(parsedStringList.get(i+1))));
                i++; // Incrementing i because we have already taken the next element
                System.debug('resultList Multi:  ' + resultList.get(0));
            }
            else if(currentVal == '/') {
                //Taking the previous element and doing divison with the next element. Then adding it into result list
                resultList.add(''+ Divide(Decimal.valueOf(resultList.remove(resultList.size()-1)), Decimal.valueOf(parsedStringList.get(i+1))));
                i++; // Incrementing i because we have already taken the next element
            }
            else {
                resultList.add(currentVal);
            }
            //Adding last element in the list
            if(i == input.length() - 1) {
                System.debug('input length:current length: ' + input.length() + 'curr length' + i);
                resultList.add(currentVal);
            }
        }
        return processAddAndSubtract(resultList);
    }

    public static Decimal processAddAndSubtract(List<String> input) {
        System.debug('add&Sub: ' + input);
        List<Decimal> resultList = new List<Decimal>();
        String currNum = '';
        for(Integer i = 0; i < input.size(); i++) {
            String currentVal = input.get(i);
            System.debug('Add Curr Val: ' + currentVal);
            System.debug('input size: ' + input.size());
            System.debug('current input i:  ' + i);
            if(currentVal.isNumeric() || currentVal == '.' || isDecimalNumeric(currentVal)) {
                System.debug('IN IS NUMERIC:  '+currentVal);
                currNum += currentVal;
            }
            else {
                if(currNum != '') {
                    System.debug('IN ELSE STATEMENT currNum: ' + currNum);
                    resultList.add(Decimal.valueOf(currNum));
                    currNum = '';
                }
            }
            if(currentVal == '+') {
                System.debug('IN ADDITION');
                resultList.add(Add(resultList.remove(0),Decimal.valueOf(input.get(i+1))));
                i++;
            }
            else if(currentVal == '-') {
                System.debug('IN SUBTRACTION: ' + input.get(i));
                System.debug('Sub current input i:  ' + i);

                resultList.add(Add(resultList.remove(0),(-1*Decimal.valueOf(input.get(i+1)))));
                i++;
            }
        }
        if(resultList.isEmpty()) {
            resultList.add(Decimal.valueOf(currNum));
        }
        System.debug('RETURNING   IN ADD   : ' + resultList.get(0));
        return resultList.remove(0);
    }
    
    public static Decimal Add(Decimal num1, Decimal num2) {
        return num1 + num2;
    }

    public static Decimal Multiply(Decimal num1, Decimal num2) {
        Decimal multiplySum = 0;
        for(Integer i = 0 ; i < num2; i++) {
            multiplySum = Add(multiplySum,num1);
            System.debug('multiSum: '+multiplySum);
        }
        return multiplySum;
    }

    public static Decimal Divide(Decimal num1, Decimal num2) {
        Decimal remainder = num1;
        Decimal divideCount = 0;

        //Checking if the divisor is 0
        if(num2 == 0) {
            return 0;
        }

        //Divide Function when divisor is not 0
        while(remainder >= num2) {
            remainder -= num2;
            divideCount = Add(divideCount,1);
        }
        return divideCount;
    }

    public static Decimal Mod(Decimal num1, Decimal num2) {
        Decimal remainder = num1;

        //Checking if the divisor is 0
        if(num2 == 0) {
            return 0;
        }

        //Divide Function when divisor is not 0
        while(remainder >= num2) {
            remainder -= num2;
        }
        return remainder;
    }

    public static Boolean isDecimalNumeric(String value) {
        try {
            Decimal.valueOf(value);  // Try to parse as Decimal
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public static List<String> createStringList(String input) {
        List<String> resultList = new List<String>();
        String currNum = '';
        for(Integer i = 0; i < input.length(); i++) {
            String currentVal = input.substring(i,i+1);
            if(currentVal.isNumeric() || currentVal == '.') {
                currNum += currentVal;
            }
            else {
                if(currNum != '') {
                    resultList.add(currNum);
                    currNum ='';
                }
            }
            if (currNum == '') {
                resultList.add(currentVal);
            }
            //Checking if we reached the end of the string
            else if (i == input.length() - 1) {
                resultList.add(currNum);
                currNum ='';
            }
        }
        return resultList;
    }

}