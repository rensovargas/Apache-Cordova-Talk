//
//  EmailComposer.h
//  Gulfstream
//
//  Created by Renso Vargas on 10/13/12.
//
//

#import <MessageUI/MFMailComposeViewController.h>
#import <Cordova/CDV.h>

@interface EmailComposer : CDVPlugin <MFMailComposeViewControllerDelegate>

- (void)showEmailComposer:(CDVInvokedUrlCommand*)command;

@end
