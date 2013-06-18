//
//  ReciveDetailViewController.m
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-14.
//
//

#import "ReciveDetailViewController.h"

#ifndef ZXQR
#define ZXQR 1
#endif

#if ZXQR
#import "QRCodeReader.h"
#endif

#ifndef ZXAZ
#define ZXAZ 0
#endif

#if ZXAZ
#import "AztecReader.h"
#endif

@interface ReciveDetailViewController ()

@end

@implementation ReciveDetailViewController

@synthesize entity;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = entity.sdName;
    self.lblEventPrice.text = entity.eventPrice;
    self.lblEventName.text = entity.couponName;
    self.lblPrice.text = [NSString stringWithFormat:@"原价 %@ 元", entity.price];
    [self.webView loadHTMLString:entity.couponIntro baseURL:nil];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    [self hideGradientBackground:self.webView];
    [self.imageUrl setFrame:CGRectMake(0, 0, 320, 237)];
    if (entity.imageUrl) {
        [self.imageUrl setImageWithURL:[NSURL URLWithString:[WEBSITE_URL stringByAppendingString:entity.imageUrl]] placeholderImage:[UIImage imageNamed:@"picture_load"]];
    } else {
        [self.imageUrl setImageWithURL:[NSURL URLWithString:[WEBSITE_URL stringByAppendingString:@"picture_load"]] placeholderImage:[UIImage imageNamed:@"picture_load"]];
    }

}

- (IBAction)showCamera:(id)sender {
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    
    NSMutableSet *readers = [[NSMutableSet alloc ] init];
    
#if ZXQR
    QRCodeReader *qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
#endif
    
#if ZXAZ
    AztecReader *aztecReader = [[AztecReader alloc] init];
    [readers addObject:aztecReader];
    
#endif
    widController.readers = readers;
    NSBundle *mainBundle = [NSBundle mainBundle];
    widController.soundToPlay =
    [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
    [self presentViewController:widController animated:YES completion:nil];
}

#pragma mark ZXingDelegateMethods
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
    NSString *retVal = @"";
    if (self.isViewLoaded) {
        NSString *type = @"";
        NSString *sdCode = @"";
        NSRange range = [result rangeOfString:@"?"];
        if (range.length > 0) {
            NSString *str = [result substringFromIndex:range.location + 1];
            NSArray *val = [str componentsSeparatedByString:@","];
            type = [val objectAtIndex:0];
            if ([@"2" isEqualToString:type]) {
                for (int i = 0; i < [val count]; i ++) {
                    type = [val objectAtIndex:0];
                    sdCode = [val objectAtIndex:1];
                }
                NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[UserKeychain load:KEY_USERID_CCODE];
                NSString *ccode = [usernamepasswordKVPairs objectForKey:KEY_CCODE];
                retVal = [CouponEntity scanBarcode:ccode withEventCode:entity.eventCode withShopCode:sdCode withIsChange:@"1"];
            }
        }
    }
    [self dismissViewControllerAnimated:YES completion:^{
        if ([@"true" isEqualToString:retVal]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"使用成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"使用失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        
    }
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) hideGradientBackground:(UIView*)theView
{
    for (UIView * subview in theView.subviews)
    {
        if ([subview isKindOfClass:[UIImageView class]])
            subview.hidden = YES;
        
        [self hideGradientBackground:subview];
    }
}

@end
