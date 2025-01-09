public with sharing class Calculator {
    public Calculator(String input) {
        //Removing White Space
        String input_list = input.replaceAll(' ','');

        //
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