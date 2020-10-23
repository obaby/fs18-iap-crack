//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  fs18iapDylib.m
//  fs18iapDylib
//
//  Created by obaby on 2017/8/24.
//  Copyright (c) 2017年 obaby. All rights reserved.
//

#import "fs18iapDylib.h"
#import "CaptainHook.h"
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import "CydiaSubstrate.h"
#import <StoreKit/StoreKit.h>
#import "BABYStringEncoding.h"

static __attribute__((constructor)) void entry(){
    NSLog(@"\n               🎉!!！congratulations!!！🎉\n👍----------------insert dylib success----------------👍");
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        CYListenServer(6666);
    }];
}

/*
CHDeclareClass(CustomViewController)

CHOptimizedMethod(0, self, NSString*, CustomViewController,getMyName){
    //get origin value
    NSString* originName = CHSuper(0, CustomViewController, getMyName);
    
    NSLog(@"origin name is:%@",originName);
    
    //get property
    NSString* password = CHIvar(self,_password,__strong NSString*);
    
    NSLog(@"password is %@",password);
    
    //change the value
    return @"AloneMonkey";
    
}
 */

CHDeclareClass(IOSInAppPurchase)

CHMethod2(void, IOSInAppPurchase, paymentQueue, id, que, updatedTransactions, id, trans){
    for(SKPaymentTransaction *tran in trans){
        NSLog(@"payment result:%ld",(long)tran.transactionState);
        
        
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
            {
                NSLog(@"payment result:交易完成");

            }
                break;
            case SKPaymentTransactionStatePurchasing: //
            {
                NSLog(@"payment result:商品添加进列表");
            }
                break;
            case SKPaymentTransactionStateRestored:
            {
                NSLog(@"payment result:已经购买过商品");

            }
                break;
            case SKPaymentTransactionStateFailed: //2
            {
                NSLog(@"payment result:交易失败");
                //SKPaymentTransaction * newTrans = [[SKPaymentTransaction alloc] init];
                //newTrans.transactionState = 1;
                
                //memset((uintptr_t)newTrans.transactionState, 0x1, 1);
                
                //memset(newTrans.transactionState, 0x1, 1);
                [tran setValue:[NSNumber numberWithInt:1] forKey:NSStringFromSelector(@selector(transactionState))];
                NSLog(@"payment result:buy changed");

                
                NSLog(@"payment2 result:%ld",(long)tran.transactionState);
            }
                break;
            default:
            {

            }
                break;
        }
    }
    CHSuper(2,IOSInAppPurchase, paymentQueue, que, updatedTransactions, trans);
}

NSInteger _logos_method$_ungrouped$SKPaymentTransaction$transactionState();
NSInteger _logos_method$_ungrouped$SKPaymentTransaction$transactionState()
{
    return 1LL;
}

NSInteger (*__logos_orig$_ungrouped$SKPaymentTransaction$transactionState)();


CHConstructor{
    //CHLoadLateClass(IOSInAppPurchase);
    //CHClassHook(0, CustomViewController, getMyName);
    //CHClassHook2(IOSInAppPurchase, paymentQueue, updatedTransactions);
    id hookedClass = objc_getClass("SKPaymentTransaction");
    if (hookedClass){
        MSHookMessageEx(hookedClass, @selector(transactionState), _logos_method$_ungrouped$SKPaymentTransaction$transactionState, &__logos_orig$_ungrouped$SKPaymentTransaction$transactionState);
        NSLog(@"congratulations!! hook success");
    }
    NSLog(@"congratulations!! hook finished");
}

