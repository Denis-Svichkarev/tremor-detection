//
//  HTDAudioPlayer.m
//  TremorDetection
//
//  Created by Denis Svichkarev on 21.02.2021.
//

#import "HTDAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface HTDAudioPlayer() <AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;

@end

@implementation HTDAudioPlayer

+ (HTDAudioPlayer *)shared{
    static HTDAudioPlayer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        sharedInstance = [[HTDAudioPlayer alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    
    if (self) {
        [self configure];
    }
    
    return self;
}

- (void)configure {}

- (void)play {
    
    // Player
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"440hz_sound" ofType:@"mp3"];
    
    if (soundFilePath != nil) {
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        NSError *error;
   
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
        self.player.delegate = self;
        self.player.numberOfLoops = -1;
        [self.player play];
        
    } else {
        NSLog(@"No such audio file.");
    }
    
    // Recorder
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];

//    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] initWithCapacity:10];
//
//    [recordSettings setObject:[NSNumber numberWithInt: kAudioFormatMPEG4AAC] forKey: AVFormatIDKey];
//    [recordSettings setObject:[NSNumber numberWithFloat:48000.0] forKey: AVSampleRateKey];
//    [recordSettings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
//    [recordSettings setObject:[NSNumber numberWithInt:12800] forKey:AVEncoderBitRateKey];
//    [recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
//    [recordSettings setObject:[NSNumber numberWithInt: AVAudioQualityHigh] forKey: AVEncoderAudioQualityKey];

    NSDictionary *recordSettings = [[NSDictionary alloc] initWithObjectsAndKeys:
        [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
        [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
        [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
        [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
        nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/440hz_record.m4a", documentsDirectory]];

    NSError *error = nil;
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:&error];

    if ([self.audioRecorder prepareToRecord] == YES) {
        [self.audioRecorder record];
        
    } else {
        uint32_t errorCode = CFSwapInt32HostToBig((uint32_t)[error code]);
        NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char *)&errorCode);
    }
}

- (void)stop {
    [self.audioRecorder stop];
    [self.player stop];
}

- (NSData *)getLastRecord {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *filePathsArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:documentsDirectory error:nil];
    if (filePathsArray.count > 0) {
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[filePathsArray objectAtIndex:0]];
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
        return data;
        
    } else {
        NSLog(@"Saved audio data does not exist");
        return nil;
    }
}

@end
