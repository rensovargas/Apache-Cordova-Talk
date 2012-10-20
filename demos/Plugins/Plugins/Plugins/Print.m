//
//  CDVPrint.m
//  Gulfstream
//
//  Created by Renso Vargas on 10/14/12.
//
//

#import "Print.h"
#import "AppDelegate.h"

@implementation Print

-(void)print:(CDVInvokedUrlCommand*)command{

    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1024.0, 1024.0)];
    UIGraphicsBeginImageContext(imageView.bounds.size);
    [app.viewController.webView.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *myData = UIImageJPEGRepresentation(imageView.image, 100);
    
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    
    if ( pic && [UIPrintInteractionController canPrintData: myData] ) {
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = @"Print Plugin";
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        
        pic.printInfo = printInfo;
        pic.showsPageRange = YES;
        pic.printingItem = myData;
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
            if (!completed && error) {
                NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
            }
        };
        
        [pic presentAnimated:YES completionHandler:completionHandler];
    }
}

@end
