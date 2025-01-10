public with sharing class Calculator {
    public static Integer Calculator(String input) {
        //Removing White Space
        String input_list = input.replaceAll(' ','');

        //Evaluate Input
        return evaluateStringFunction(input);
    }

    // Recursively evaluate parentheses first
    public static Integer evaluateStringFunction(String input) {
        System.debug('evaluateStringFunction: ' + input);
        while(input.contains('(')) {
            Integer startIndex = input.lastIndexOf('('); //Gets last '('
            Integer endIndex = input.indexOf(')', startIndex); //Gets first occurence of ')' from starting point

            // Getting the Substring of the inner most parentheses
            // IE. ((3 * (4 + 2) - 8) + 10) / 2 = 10 -> ((3*6 -8)+10)/2 -> ((18-8)+10)/2 -> ((10)+10)/2 -> (20)/2 -> 10
            String parenthesesExpression = input.substring(startIndex + 1, endIndex);
            //Checking for Multiplication and Division within parentheses (Higher prio than Addition and Subtraction)
            Integer parenthesesResult = processMultiplyAndDivide(parenthesesExpression);

            input = input.substring(0,startIndex) + parenthesesResult + input.substring(endIndex + 1);
        }
        return processMultiplyAndDivide(input);
    }

    //Process multiplication and divison then sends to addition and subtraction
    private static Integer processMultiplyAndDivide(String input) {
        input = input.replace('(','');
        input = input.replace(')','');
        input = input.replace(' ','');
        System.debug('multipy&Divide: ' + input);

        // List to add/process results of multiplication & division then send to add & subtract
        List<String> resultList = new List<String>();
        String currNum = ''; //Holds the current string of integer

        for(Integer i = 0; i < input.length(); i++) {
            String currentVal = input.substring(i,i+1);
            System.debug('currentVal Multi  : ' + currentVal);
            if(currentVal.isNumeric()) {
                System.debug('isNumeric Multi');
                currNum += currentVal;
            }
            else {
                if(currNum != '') {
                    resultList.add(currNum);
                    currNum ='';
                }
            }
            if(currentVal == '*') {
                //Taking the previous element and doing multiplication with the next element. Then adding it into result list
                resultList.add(''+Multiply(Integer.valueOf(resultList.remove(resultList.size()-1)), Integer.valueOf(input.substring(i+1,i+2))));
                i++; // Incrementing i because we have already taken the next element
            }
            else if(currentVal == '/') {
                //Taking the previous element and doing divison with the next element. Then adding it into result list
                resultList.add(''+Divide(Integer.valueOf(resultList.remove(resultList.size()-1)), Integer.valueOf(input.substring(i+1,i+2))));
                i++; // Incrementing i because we have already taken the next element
            }
            else if(currentVal == '+' || currentVal == '-'){
                resultList.add(currentVal);
            }
            if(i == input.length() -1 && currNum != '') {
                System.debug('input length:current length: ' + input.length() + 'curr length' + i);
                resultList.add(currNum);
            }
        }
        return processAddAndSubtract(resultList);
    }

    public static Integer processAddAndSubtract(List<String> input) {
        System.debug('add&Sub: ' + input);
        List<Integer> resultList = new List<Integer>();
        String currNum = '';
        for(Integer i = 0; i < input.size(); i++) {
            String currentVal = input.get(i);
            System.debug('Add Curr Val: ' + currentVal);
            if(currentVal.isNumeric()) {
                System.debug('IN IS NUMERIC:  '+currentVal);
                currNum += currentVal;
            }
            else {
                if(currNum != '') {
                    System.debug('IN ELSE STATEMENT currNum: ' + currNum);
                    resultList.add(Integer.valueOf(currNum));
                    currNum = '';
                }
            }
            if(currentVal == '+') {
                System.debug('IN ADDITION');
                resultList.add(Add(Integer.valueOf(resultList.remove(0)),Integer.valueOf(input.get(i+1))));
                i++;
            }
            else if(currentVal == '-') {
                resultList.add(Add(Integer.valueOf(resultList.remove(0)),(-1*Integer.valueOf(input.get(i+1)))));
                i++;
            }
        }
        if(resultList.isEmpty()) {
            resultList.add(Integer.valueOf(currNum));
        }
        System.debug('RETURNING   IN ADD   : ' + resultList.get(0));
        return resultList.remove(0);
    }
    
    public static Integer Add(Integer num1, Integer num2) {
        return num1 + num2;
    }

    public static Integer Multiply(Integer num1, Integer num2) {
        Integer multiplySum = 0;
        for(Integer i = 0 ; i < num2; i++) {
            multiplySum = Add(multiplySum,num1);
        }
        return multiplySum;
    }

    public static Integer Divide(Integer num1, Integer num2) {
        Integer remainder = num1;
        Integer divideCount = 0;

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

    public static Integer Mod(Integer num1, Integer num2) {
        Integer remainder = num1;

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

}