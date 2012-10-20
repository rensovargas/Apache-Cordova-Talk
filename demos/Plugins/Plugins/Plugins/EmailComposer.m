//
// EmailComposer.m
//
//
// Created by Jesse MacFadyen on 10-04-05.
// Copyright 2010 Nitobi. All rights reserved.
//

#import "EmailComposer.h"
#import <Cordova/CDV.h>

@implementation EmailComposer{
    NSString *cid;
}

//- (void) showEmailComposer:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
- (void)showEmailComposer:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", [command arguments]);
    //NSUInteger argc = [arguments count];
    cid = [NSString stringWithString:command.callbackId];
    
    NSString* toRecipientsString = [[command arguments] valueForKey:@"toRecipients"];
    NSString* ccRecipientsString = [[command arguments] valueForKey:@"ccRecipients"];
    NSString* bccRecipientsString = [[command arguments] valueForKey:@"bccRecipients"];
    NSString* subject = [[command arguments] valueForKey:@"subject"];
    NSString* body = [[command arguments] valueForKey:@"body"];
    NSString* isHTML = [[command arguments] valueForKey:@"bIsHTML"];
    NSMutableDictionary *pdfSettings = [[command arguments] valueForKey:@"pdfSettings"];
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    // Set subject
    if(subject != nil)
        [picker setSubject:subject];
    // Set body
    if(body != nil)
    {
        if(isHTML != nil && [isHTML boolValue])
        {
            [picker setMessageBody:body isHTML:YES];
        }
        else
        {
            [picker setMessageBody:body isHTML:NO];
        }
    }
    
    // Set recipients
    if(toRecipientsString != nil)
    {
        [picker setToRecipients:[ toRecipientsString componentsSeparatedByString:@","]];
    }
    if(ccRecipientsString != nil)
    {
        [picker setCcRecipients:[ ccRecipientsString componentsSeparatedByString:@","]];
    }
    if(bccRecipientsString != nil)
    {
        [picker setBccRecipients:[ bccRecipientsString componentsSeparatedByString:@","]];
    }
    
    //To attach this PDF to an email, simply do:
    if(pdfSettings != nil)
    {
        //Attach an image to the email
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSData *data = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[pdfSettings objectForKey:@"document"]]];
        [picker addAttachmentData:data mimeType:@"application/pdf" fileName:[[pdfSettings objectForKey:@"document"] lastPathComponent]];
    }
    
    if (picker != nil) {
        [self.viewController presentModalViewController:picker animated:YES];
    }
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    // Notifies users about errors associated with the interface
    int webviewResult = 0;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            webviewResult = 0;
            break;
        case MFMailComposeResultSaved:
            webviewResult = 1;
            break;
        case MFMailComposeResultSent:
            webviewResult =2;
            break;
        case MFMailComposeResultFailed:
            webviewResult = 3;
            break;
        default:
            webviewResult = 4;
            break;
    }
    
    [self.viewController dismissModalViewControllerAnimated:YES];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[NSString stringWithFormat:@"%d", webviewResult]];
    NSString *javascript = [pluginResult toSuccessCallbackString:cid];

    [self writeJavascript:javascript];
    
}

@end