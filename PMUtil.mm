//
//  PMUtil.m
//  TestSocket
//
//  Created by 杨振 on 15/5/29.
//  Copyright (c) 2015年 杨振. All rights reserved.
//

#import "PMUtil.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation PMUtil
///**
// * 将16进制范围的字母或数字的字符转换成对应的整数， 0－9 a－f｜A－F则转换成10－15
// *
// * @param ch
// * @return
// */
//private static char char2Int(char ch) {
//    if (ch >= '0' && ch <= '9')
//        return (char) (ch - '0');
//    if (ch >= 'a' && ch <= 'f')
//        return (char) (ch - 'a' + 10);
//    if (ch >= 'A' && ch <= 'F')
//        return (char) (ch - 'A' + 10);
//    return ' ';
//}
//
///**
// * 将两个字符转换成一个字节表示
// *
// * @param str
// * @return
// */
//private static byte str2Bin(char[] str) {
//    byte chn;
//    char[] tempWord = new char[2];
//    
//    tempWord[0] = char2Int(str[0]); // make the B to 11 -- 00001011
//    tempWord[1] = char2Int(str[1]); // make the 0 to 0 -- 00000000
//    
//    chn = (byte) ((tempWord[0] << 4) | tempWord[1]); // to change the BO to
//    // 10110000
//    
//    return chn;
//}
//
///**
// * 将32长度的字符数组压缩生成标准的16位字节数组的MD5
// *
// * @param md5chs32len
// *            32长度的MD5字符串的字符数组
// * @return
// */
//public static byte[] compress(char[] md5chs32len) {
//    char[] tem = new char[2];
//    byte[] sDst = new byte[md5chs32len.length / 2];
//    int j = 0;
//    for (int i = 0; i + 1 < md5chs32len.length; i += 2) {
//        tem[0] = md5chs32len[i];
//        tem[1] = md5chs32len[i + 1];
//        sDst[j++] = (byte) (str2Bin(tem));
//    }
//    return sDst;
//}
/**
 * 将16进制范围的字母或数字的字符转换成对应的整数， 0－9 a－f｜A－F则转换成10－15
 *
 * @param ch
 * @return
 */
+(char)char2Int:(char)ch {
    if (ch >= '0' && ch <= '9')
        return (char) (ch - '0');
    if (ch >= 'a' && ch <= 'f')
        return (char) (ch - 'a' + 10);
    if (ch >= 'A' && ch <= 'F')
        return (char) (ch - 'A' + 10);
    return ' ';
}

/**
 * 将两个字符转换成一个字节表示
 *
 * @param str
 * @return
 */
+(Byte)str2Bin:(char*)str{
    Byte chn;
    char* tempWord = new char[2];
    
    tempWord[0] = [self char2Int:str[0]]; // make the B to 11 -- 00001011
    tempWord[1] = [self char2Int:str[1]]; // make the 0 to 0 -- 00000000
    
    chn = (Byte) ((tempWord[0] << 4) | tempWord[1]); // to change the BO to
    // 10110000
    
    return chn;
}

/**
 * 将32长度的字符数组压缩生成标准的16位字节数组的MD5
 *
 * @param md5chs32len
 *            32长度的MD5字符串的字符数组
 * @return
 */
+(Byte*)compress:(const char*)md5chs32len{
    char* tem = new char[2];
    Byte* sDst = new Byte[16];
    int j = 0;
    for (int i = 0; i + 1 < 32; i += 2) {
        tem[0] = md5chs32len[i];
        tem[1] = md5chs32len[i + 1];
        sDst[j++] = (Byte) ([self str2Bin:tem]);
    }
    return sDst;
}

//+ (NSString *)decodeWithText:(NSString *)sText key:(NSString *)key
//{
//    
//    key = [key md5];
//    Byte* byte = [self compress:[key cStringUsingEncoding:NSASCIIStringEncoding]];
//    
//    const void *dataIn;
//    size_t dataInLength;
//    
//    NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    dataInLength = [decryptData length];
//    dataIn = (const void *)[decryptData bytes];
//    
//    CCCryptorStatus ccStatus;
//    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
//    size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
//    size_t dataOutMoved = 0;
//    
//    dataOutAvailable = (dataInLength + kCCKeySizeDES) & ~(kCCKeySizeDES - 1);
//    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
//    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
//    
//    //    Byte b[] = {1,2,3,4,5,6,7,8};
//    const void *vkey = (const void *)[key UTF8String];
//    //    const void *iv = (const void *)b;
//    
//    ccStatus = CCCrypt(kCCDecrypt,//  加密/解密
//                       kCCAlgorithmAES,//  加密根据哪个标准（des，3des，aes。。。。）
//                       kCCOptionPKCS7Padding|kCCOptionECBMode,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
//                       vkey,  //密钥    加密和解密的密钥必须一致
//                       kCCKeySizeAES128,//   DES 密钥的大小（kCCKeySizeDES=8）
//                       nil, //  可选的初始矢量
//                       dataIn, // 数据的存储单元
//                       dataInLength,// 数据的大小
//                       (void *)dataOut,// 用于返回数据
//                       dataOutAvailable,
//                       &dataOutMoved);
//    
//    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved] encoding:NSUTF8StringEncoding];
//    
//    return result;
//}

@end
