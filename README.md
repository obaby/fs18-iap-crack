#  模拟农场18 IAP CRACK  

破解方法比较简单，现在这种本地验证内购结果的APP应该非常少见了，破解的方法也比较简单，直接hook回调函数即可：  
```javascript
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
```
破解效果：  
![iap crack](screen_shots/s_720.gif)  
该破解同样适用于模拟农场16，最新的模拟农场20可用，使用方法自己摸索，会导致游戏崩溃  

> obaby@mars  
> http://www.h4ck.org.cn  
> http://www.obaby.org.cn  
> http://findu.co
