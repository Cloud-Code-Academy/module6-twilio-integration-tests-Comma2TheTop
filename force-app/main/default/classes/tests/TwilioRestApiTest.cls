/**
 * TwilioRestApiTest - Test class for TwilioRestApi
 * @see TwilioRestApi
 * 
 * TODO: Implement test methods to verify the functionality of the TwilioRestApi class
 */
@IsTest
private class TwilioRestApiTest {
    
    /**
     * Test handleIncomingSMS method with standard SMS parameters
     * 
     * TODO: Implement this test method to verify handling of standard SMS webhooks
     */
    @IsTest
    static void testHandleIncomingSMSStandard() {
        // TODO: Setup mock REST request with standard SMS parameters
        // - Create RestRequest and RestResponse objects
        RestRequest request = new RestRequest();
        //RestResponse response = new RestResponse();
        // - Set requestURI (e.g., '/services/apexrest/twilio/sms')
        request.requestURI = '/services/apexrest/twilio/sms';
        // - Set httpMethod to 'POST'
        request.httpMethod = 'POST';
        // - Add required parameters (MessageSid, AccountSid, From, To, Body, etc.)
        request.requestBody = Blob.valueOf(
            'MessageSid=SM123&AccountSid=AC456&From=%2B15558675309&To=%2B14155552671&Body=Hello+Jason&NumMedia=0'
        );
        
        // TODO: Set the mock request/response objects in RestContext
        RestContext.request = request;
        RestContext.response = new RestResponse();
        
        // TODO: Execute the test
        // - Call TwilioRestApi.handleIncomingSMS()
        Test.startTest();
        String result = TwilioRestApi.handleIncomingSMS();
        Test.stopTest();
        
        // TODO: Verify results
        // - Verify response XML is not null
        System.assertNotEquals(null, result,'Expected a null result here');
    
        //System.Assert.areEqual(
            //'<Response></Response>',);
        // - Verify response contains expected TwiML elements
        System.assert(result.contains('<Response>'),'Expected <Response> element in response');
        System.Assert(result.contains('</Response>'),'Expected </Response> element in response');
    }
    
    /**
     * Test handleIncomingSMS method with media attachments
     * 
     * TODO: Implement this test method to verify handling of SMS with media
     */
    @IsTest
    static void testHandleIncomingSMSWithMedia() {
        // TODO: Setup mock REST request with media parameters
        // - Create RestRequest and RestResponse objects
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        // - Set requestURI and httpMethod
            request.requestURI = '/services/apexrest/twilio/sms';
            request.httpMethod = 'POST';

        // - Add required parameters
            //request.requestUri = '/services/apexrest/twilio/sms';
            //request.httpMethod = 'POST';
            request.addParameter('MessageSid', 'SM1234567890');
            request.addParameter('AccountSid', 'AC1234567890');
            request.addParameter('From', '+15556667777');
            request.addParameter('To', '+14443332222');
            request.addParameter('Body', 'Here is a file');
            request.addParameter('NumMedia', '1');
            request.addParameter('MediaUrl0', 'https://demo.twilio.com/owl.png');
            request.addParameter('MediaContentType0', 'image/png');
        // - Add media attachment parameters (NumMedia, MediaUrl0, MediaContentType0, etc.)
        
        // TODO: Set the mock request/response objects in RestContext
        RestContext.request = request;
        RestContext.response = new RestResponse();
        System.debug('**DEBUG Request: ' + request);
        System.debug('**DEBUG Response: ' + RestContext.response);
        
        // TODO: Execute the test
        // - Call TwilioRestApi.handleIncomingSMS()
        Test.startTest();
        String result = TwilioRestApi.handleIncomingSMS();
        Test.stopTest();
        // TODO: Verify results
        // - Verify response XML is not null
        System.debug('**DEBUG Result**: ' + result);
        // - Verify response contains expected TwiML elements
        System.assertNotEquals(null, result,'Expected a null result here');
        System.Assert(result.contains('<Response>'), 'Expected <Response> element in response');
        System.Assert(result.contains('</Response>'),'Expected </Response> element in response');

        //System.Assert(result.contains('<Media>'), 'Oops no media to display');
    }
    
    /**
     * Test handleIncomingSMS method with location data
     * 
     * TODO: Implement this test method to verify handling of SMS with location data
     */
    @IsTest
    static void testHandleIncomingSMSWithLocation() {
        // TODO: Setup mock REST request with location parameters
        // - Create RestRequest and RestResponse objects
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        // - Set requestURI and httpMethod
        request.requestURI = '/services/apexrest/twilio/sms';
        request.httpMethod = 'POST';
        // - Add required parameters
        request.addParameter('MessageSid', 'SM1234567890');
        request.addParameter('AccountSid', 'AC1234567890');
        request.addParameter('From', '+15556667777');
        request.addParameter('To', '+14443332222');
        request.addParameter('Body', 'Here is a file');
        // - Add location parameters (FromCity, FromState, FromZip, FromCountry, etc.)
        request.addParameter('FromCity', 'Saint Louis');
        request.addParameter('FromState', 'MO');
        request.addParameter('FromZip', '63385');
        request.addParameter('FromCountry', 'US');
        request.addParameter('ToCity', 'Kansas City');
        request.addParameter('ToState', 'MO');
        request.addParameter('ToZip', '64111');
        request.addParameter('ToCountry', 'US');
        // TODO: Set the mock request/response objects in RestContext
        
        RestContext.request = request;
        RestContext.response = new RestResponse();
        
        // TODO: Execute the test
        // - Call TwilioRestApi.handleIncomingSMS()
        Test.startTest();
        String result = TwilioRestApi.handleIncomingSMS();
        Test.stopTest();
        
        // TODO: Verify results
        // - Verify response XML is not null
        // - Verify response contains expected TwiML elements
        System.assertNotEquals(null, result,'Expected a null result here');
        System.Assert(result.contains('<Response>'), 'Expected <Response> element in response');
        System.Assert(result.contains('</Response>'),'Expected </Response> element in response');
    }
    
    /**
     * Test handleIncomingSMS method with WhatsApp parameters
     * 
     * TODO: Implement this test method to verify handling of WhatsApp messages
     */
    @IsTest
    static void testHandleIncomingSMSWithWhatsApp() {
        // TODO: Setup mock REST request with WhatsApp parameters
        // - Create RestRequest and RestResponse objects
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        // - Set requestURI and httpMethod
        request.requestURI = '/services/apexrest/twilio/sms';
        request.httpMethod = 'POST';
        // - Add required parameters with WhatsApp format (e.g., From: 'whatsapp:+15551234567')
        request.addParameter('MessageSid', 'SM1234567890');
        request.addParameter('AccountSid', 'AC1234567890');
        request.addParameter('From', '+15556667777');
        request.addParameter('To', '+14443332222');
        request.addParameter('Body', 'Here is a WhatsApp message');

        // - Add WhatsApp specific parameters (ProfileName, WaId, etc.)
        request.addParameter('ProfileName', 'jasontowers');
        request.addParameter('WaId', '14017122661');
        request.addParameter('Forwarded', 'false');
        request.addParameter('FrequentlyForwarded', 'false');
        request.addParameter('ButtonText', 'Jason Button');
        // - Add WhatsApp location data if applicable
        request.addParameter('Latitude', '39.9599');
        request.addParameter('Longitude', '-75.1610');
        request.addParameter('Address', '21 Jump St., Wentzville, MO 63385');
        request.addParameter('Label', 'Jump St');

        
        // TODO: Set the mock request/response objects in RestContext
        
        RestContext.request = request;
        RestContext.response = new RestResponse();
        
        // TODO: Execute the test
        // - Call TwilioRestApi.handleIncomingSMS()
        Test.startTest();
        String result = TwilioRestApi.handleIncomingSMS();
        Test.stopTest();
        
        // TODO: Verify results
        // - Verify response XML is not null
        // - Verify response contains expected TwiML elements
        System.assertNotEquals(null, result,'Expected a null result here');
        System.Assert(result.contains('<Response>'), 'Expected <Response> element in response');
        System.Assert(result.contains('</Response>'),'Expected </Response> element in response');
    }
} 