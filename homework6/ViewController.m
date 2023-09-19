//
//  ViewController.m
//  homework6
//
//  Created by Алекс Фитнес on 19.09.2023.
//


#import "ViewController.h"
#import "Robot.h"

@interface ViewController ()

@property (weak, nonatomic) UITextField *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *savedRobotData = [defaults objectForKey:@"Robot"];
    Robot *savedRobot = [NSKeyedUnarchiver unarchiveObjectWithData:savedRobotData];

    self.textView.text = [NSString stringWithFormat:@"Name: %@, Coordinates: (%ld, %ld)", savedRobot.name, (long)savedRobot.x, (long)savedRobot.y];
    NSLog(@"Name: %@, Coordinates: (%ld, %ld)", savedRobot.name, (long)savedRobot.x, (long)savedRobot.y);
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Robot *robot = [[Robot alloc] init];
        robot.x = 10;
        robot.y = 20;
        robot.name = @"R2-D2";

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *robotData = [NSKeyedArchiver archivedDataWithRootObject:robot];
        [defaults setObject:robotData forKey:@"robot"];
        [defaults synchronize];

        NSData *savedRobotData = [defaults objectForKey:@"robot"];
        Robot *savedRobot = [NSKeyedUnarchiver unarchiveObjectWithData:savedRobotData];

        NSLog(@"Name: %@, Coordinates: (%ld, %ld)", savedRobot.name, (long)savedRobot.x, (long)savedRobot.y);
        
        NSString *fileName = [NSString stringWithFormat:@"%@.txt", savedRobot.name];
        NSString *filePath = [NSString stringWithFormat:@"/homework6/%@", fileName];
        NSString *robotInfo = [NSString stringWithFormat:@"Name: %@, Coordinates: (%ld, %ld)", savedRobot.name, (long)savedRobot.x, (long)savedRobot.y];
        [robotInfo writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        NSLog(@"%@", fileContent);
    }
    return 0;
}

@end
