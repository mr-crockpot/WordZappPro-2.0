//
//  HighScoresViewController.m
//  WordZappPro 2.0
//
//  Created by Adam Schor on 8/12/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "HighScoresViewController.h"
#import "UserDefaults.h"


@interface HighScoresViewController ()

@end

@implementation HighScoresViewController

- (void)viewDidLoad {
    
    _segmentHighScores.selectedSegmentIndex = 0;
    _level = @"easyList";
    
    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBarHidden = NO;
    
    [self loadArrayofScores];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadArrayofScores{
    
    _arrayTopScores = [[NSMutableArray alloc] initWithArray:[UserDefaults getDataForKey:_level]];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrayTopScores.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    
    NSString *score;
    
    score = [NSString stringWithFormat:@"%@",_arrayTopScores[indexPath.row]];
    cell.textLabel.text = score;
    
    return cell;
    
}





- (IBAction)segmentHighScoresChanged:(id)sender {
    
    switch (_segmentHighScores.selectedSegmentIndex) {
        case 0:
            _level = @"easyList";
            break;
        case 1:
            _level = @"mediumList";
            break;
        case 2:
             _level = @"hardList";
            break;
        default:
            break;
    }
    
    [self loadArrayofScores];
    [_tblViewHighScores reloadData];
    
    NSLog(@"The array of scores is %@",_arrayTopScores);
    
}





@end
