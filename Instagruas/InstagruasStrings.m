//
//  InstagruasStrings.m
//  Instagruas
//
//  Created by NARSUN-MAC-01 on 20/12/2016.
//  Copyright © 2016 NARSUN-MAC-01. All rights reserved.
//

#import "InstagruasStrings.h"
#import "AppDelegate.h"
@implementation InstagruasStrings
+(NSString *)getLoginString{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.isSpanishLanguage) {
        return @"INICIAR SESIÓN";
    }else{
        return @"LOG IN";
    }
}
+(NSString *)getSingUpString{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.isSpanishLanguage) {
        return @"REGÍSTRATE";
    }else{
        return @"SIGN UP";
    }
}

+(NSString *)getDontHaveAccountString{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.isSpanishLanguage) {
        return @"¿NO TIENES UNA CUENTA AÚN? REGÍSTRATE";
    }else{
        return @"DON'T HAVE AN ACCOUNT YET? SIGN UP";
    }
}
+(NSString *)getLoginWithFacebookString{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.isSpanishLanguage) {
        return @"INICIAR SESIÓN CON FACEBOOK";
    }else{
        return @"LOG IN WITH FACEBOOK";
    }
}
+(NSString *)getLoginWithGoogleString{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.isSpanishLanguage) {
        return @"INICIARSE CON GOOGLE";
    }else{
        return @"LOG IN WITH GOOGLE";
    }
}

+(NSString *)getForgotPasswordString{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.isSpanishLanguage) {
        return @"¿SE TE OLVIDÓ TU CONTRASEÑA?";
    }else{
        return @"FORGOT PASSWORD?";
    }
}

+(NSString *)getEmailString{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.isSpanishLanguage) {
        return @"CORREO ELECTRÓNICO";
    }else{
        return @"E-MAIL";
    }
}

+(NSString *)getPasswordString{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.isSpanishLanguage) {
        return @"CONTRASEÑA";
    }else{
        return @"PASSWORD";
    }
}

+(NSString *)getNameString{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.isSpanishLanguage) {
        return @"NOMBRE";
    }else{
        return @"NAME";
    }
}

+(NSString *)getPhoneNumberString{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.isSpanishLanguage) {
        return @"NÚMERO DE TELÉFONO";
    }else{
        return @"PHONE NUMBER";
    }
}
+(NSString *)getConfirmPasswordString{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.isSpanishLanguage) {
        return @"CONFIRMAR CONTRASEÑA";
    }else{
        return @"CONFIRM PASSWORD";
    }
}
/*
 +(NSString *)getSingUpString;
+(NSString *)getDontHaveAccountString;
 +(NSString *)getLoginString;
 +(NSString *)getLoginWithGoogleString;
 +(NSString *)getLoginWithFacebookString;
 +(NSString *)getForgotPasswordString;
 +(NSString *)getEmailString;
 +(NSString *)getPasswordString;
 +(NSString *)getConfirmPasswordString;
 +(NSString *)getPhoneNumberString;
 +(NSString *)getNameString;
*/
@end
