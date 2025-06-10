/**
 * TwilioServiceTest - Test class for TwilioService
 * @see TwilioService
 * 
 * TODO: Implement test methods to verify the functionality of the TwilioService class
 */
@IsTest
private class TwilioServiceTest {
    
    /**
     * Test the sendSMS method with a valid request
     * 
     * TODO: Implement this test method to verify that sending an SMS works correctly
     */
    @IsTest
    static void testSendSMS() {
        // TODO: Setup test data
        // - Create test phone number and message body
        String fakePhone = '+18777804236';
        String messageBody = 'Test message';
        

        
        // TODO: Setup mock callout response
        String responseJSON = '{"sid":"SM123","status":"queued","body":"Test message"}';
        // - Use TwilioCalloutMock to simulate a successful response
        TwilioCalloutMock mock = new TwilioCalloutMock(201, responseJSON);
        Test.setMock(HttpCalloutMock.class, mock);         
            
        
        // TODO: Execute the test
        // - Call TwilioService.sendSMS() method
        Test.startTest();
        TwilioResponse response = TwilioService.sendSMS(fakePhone, messageBody);
        Test.stopTest();
        
        // TODO: Verify results
        // - Verify that response is successful
        // - Verify status code is correct
        // - Verify response body contains expected values (sid, status, etc.)
        System.assertEquals(true, response.success,'Very nice...response was successful');
        System.assertEquals(201, response.statusCode,'Also, nice....response was 201');
        System.assertNotEquals(null, response.getBodyAsJson(),'Expected the body to contain a JSON object');
        System.assertEquals('queued', response.getBodyAsJson().get('status'),'Expected the status to be "queued"');
        System.assertEquals('Test message', response.getBodyAsJson().get('body'),'Expected the body to contain the message "Test message"');
    }
    
    /**
     * Test the sendSMS method with an error response
     * 
     * TODO: Implement this test method to verify error handling in sendSMS
     */
    @IsTest
    static void testSendSMSError() {
        // TODO: Setup test data
        // - Create test phone number and message body
        String fakePhone = '+18777804236';
        String messageBody = 'Test message';
        
        // TODO: Setup mock callout response
        // - Use TwilioCalloutMock to simulate an error response
        String errorJSON = '{"message":"Invalid Phone"}';
        TwilioCalloutMock mock = new TwilioCalloutMock(500, errorJSON);
        Test.setMock(HttpCalloutMock.class, mock); 
        
        // TODO: Execute the test
        // - Call TwilioService.sendSMS() method
        Test.startTest();
        TwilioResponse response = TwilioService.sendSMS(fakePhone, messageBody);
        Test.stopTest();
        
        // TODO: Verify results
        // - Verify that response is not successful
        // - Verify error status code is correct
        // - Verify error message is extracted correctly
        System.assertNotEquals(null, response, 'Expected something not null dude!');
        System.assertEquals(false, response.success, 'Expected success to be false');
        System.assertEquals(500, response.statusCode, 'Expected status code to be 500');
        System.assertEquals('Invalid Phone', response.getErrorMessage(),'Expected error message to be "Invalid Phone"');
    }
    
    /**
     * Test the getMessages method
     * 
     * TODO: Implement this test method to verify the getMessages functionality
     */
    @IsTest
    static void testGetMessages() {
        // TODO: Setup mock callout response
        // - Use TwilioCalloutMock to simulate a successful response with message list
        String responseJson = '{"messages":[{"sid":"SM1","body":"Hello"},{"sid":"SM2","body":"World"}]}';
        
        TwilioCalloutMock mock = new TwilioCalloutMock(200, responseJson);

        Test.setMock(HttpCalloutMock.class, mock);
        // TODO: Execute the test
        // - Call TwilioService.getMessages() method with an appropriate limit
        Test.startTest();
        TwilioResponse result = TwilioService.getMessages(2);
        Test.stopTest();
        
        // TODO: Verify results
        // - Verify that response is successful
        // - Verify status code is correct
        // - Verify response body contains expected messages data
        System.assertEquals(true, result.success, 'Very nice...great success');
        System.assertEquals(200, result.statusCode, 'Error...expected a 200 return code');
        
        System.assertNotEquals(null, result.getBodyAsJson(), 'Contained no JSON object');
    }
    
    /**
     * Test the getMessages method with null/invalid limit
     * 
     * TODO: Implement this test method to verify handling of edge cases
     */
    @IsTest
    static void testGetMessagesWithInvalidLimit() {
        // TODO: Setup mock callout response
        // - Use TwilioCalloutMock to simulate a successful response
        String responseJson = '{"messages":[{"sid":"SM1","body":"Hello"},{"sid":"SM2","body":"Null Jason Towers"}]}';
        Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(200, responseJson));
        
        // TODO: Execute the test with null limit
        // - Call TwilioService.getMessages() method with null
        TwilioResponse nullLimitresult = TwilioService.getMessages(null);
        System.assertEquals(true, nullLimitResult.success,'Nice, it was a success');
        System.assert(nullLimitResult.body.contains('Null Jason Towers'),'Nice, it contained the message we were looking for');
        
        // TODO: Execute the test with 0 limit');
        
        // TODO: Execute the test with negative limit
        // - Call TwilioService.getMessages() method with a negative number
        String negativeJson = '{"messages":[{"sid":"SM1","body":"Hello"},{"sid":"SM2","body":"Negative Jazon Toyers"}]}';
        Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(200, negativeJson));
        TwilioResponse negativeLimitResult = TwilioService.getMessages(-1);
        // TODO: Verify results
        // - Verify that both responses are successful
        System.assertEquals(true, negativeLimitResult.success,'Nice, it was a success');
        // - Verify that the service handles these edge cases correctly
        System.assert(negativeLimitResult.body.contains('Negative Jazon Toyers'),'Nice, it contained the message we were looking for');
        
        // TODO:);
    }
    
    /**
     * Test exception handling in makeHttpRequest
     * 
     * TODO: Implement this test method to verify exception handling
     */
    @IsTest
    static void testMakeHttpRequestException() {
        // TODO: Setup mock that throws exception
        // - Use TwilioCalloutMock.createExceptionMock()
        Test.setMock(HttpCalloutMock.class, TwilioCalloutMock.createExceptionMock());

        //TwilioResponse result = TwilioService.sendSMS('+15551111111', 'Should fail');
        Test.startTest();
        TwilioResponse result = TwilioService.sendSMS('+15551111111', 'Should fail');
        Test.stopTest();

        System.assertEquals(false, result.success, 'Should be unsuccessful');
        System.assertEquals(500, result.statusCode,'Should be a 500 status code');
        System.debug('Result body: ' + result.body);
        System.assert(result.body.contains('TwilioCalloutMock: Exception thrown for test.'), 'Expected simulated exception message');
    }
        
        // TODO: Execute the test
        // - Call a TwilioService method that will use the mock
        
        // TODO: Verify results
        // - Verify that response indicates failure
        // - Verify that status code is set to 500 (or appropriate error code)
        // - Verify that error message is set correctly
    }
 