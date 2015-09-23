//
//  ViewController.m
//  AttributeStringDemo
//
//  Created by mmy on 7/22/15.
//  Copyright (c) 2015 mmy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (nonatomic, strong)   NSMutableArray *    dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITableView *   tableView   = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource        = self;
    tableView.delegate          = self;
    tableView.contentInset              = UIEdgeInsetsMake(20, 0, 0, 0);
    tableView.scrollIndicatorInsets     = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Accessor methods

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
        NSDictionary *  rowDict;
        NSDictionary *  attributesDict;
        // 设置字体大小
        attributesDict  = @{
                            NSFontAttributeName:    [UIFont systemFontOfSize:30]
                            };
        rowDict         = @{
                            @"desc":    @"设置字体大小",
                            @"attr":    attributesDict
                            };
        [_dataSource addObject:rowDict];
        // 设置为斜体
        attributesDict  = @{
                            NSObliquenessAttributeName: @(1)
                            };
        rowDict         = @{
                            @"desc":    @"设置为斜体",
                            @"attr":    attributesDict
                            };
        [_dataSource addObject:rowDict];
        // 设置字体颜色
        attributesDict  = @{
                            NSForegroundColorAttributeName: [UIColor redColor],
                            NSBackgroundColorAttributeName: [UIColor blackColor]
                            };
        rowDict         = @{
                            @"desc":    @"设置字体颜色",
                            @"attr":    attributesDict
                            };
        [_dataSource addObject:rowDict];
        // 设置删除线
        attributesDict  = @{
                            NSStrikethroughStyleAttributeName:  @(5),
                            NSStrikethroughColorAttributeName:  [UIColor yellowColor]
                            };
        rowDict         = @{
                            @"desc":    @"设置删除线",
                            @"attr":    attributesDict
                            };
        [_dataSource addObject:rowDict];
        // 设置下划线
        attributesDict  = @{
                            NSUnderlineStyleAttributeName:  @(NSUnderlineStyleSingle),
                            NSUnderlineColorAttributeName:  [UIColor redColor]
                            };
        rowDict         = @{
                            @"desc":    @"设置下划线",
                            @"attr":    attributesDict
                            };
        [_dataSource addObject:rowDict];
        // 设置URL
        attributesDict  = @{
                            NSLinkAttributeName:  @"点击我",
                            };
        rowDict         = @{
                            @"desc":    @"设置URL链接",
                            @"attr":    attributesDict
                            };
        [_dataSource addObject:rowDict];
        // 设置URL可以点击
        attributesDict  = @{
                            NSLinkAttributeName:  @"http://www.baidu.com",
                            };
        rowDict         = @{
                            @"desc":    @"设置URL链接",
                            @"attr":    attributesDict,
                            @"option":  @"UITextView"
                            };
        [_dataSource addObject:rowDict];
        // 设置行间距
        NSMutableParagraphStyle *   ps  = [[NSMutableParagraphStyle alloc] init];
        ps.lineSpacing                  = 15;
        attributesDict  = @{
                            NSParagraphStyleAttributeName:  ps
                            };
        rowDict         = @{
                            @"desc":    @"设置行间距 设置行间距 设置行间距 设置行间距 设置行间距",
                            @"attr":    attributesDict
                            };
        [_dataSource addObject:rowDict];
        // 设置字间距
        attributesDict  = @{
                            NSKernAttributeName:    @(10)
                            };
        rowDict         = @{
                            @"desc":    @"设置字间距",
                            @"attr":    attributesDict
                            };
        [_dataSource addObject:rowDict];
        // 计算文字所占区域
        attributesDict  = @{
                            NSFontAttributeName:    [UIFont systemFontOfSize:12],
                            NSKernAttributeName:    @(10)
                            };
        rowDict         = @{@"desc":    @"计算文字所占区域 计算文字所占区域 计算文字所占区域 计算文字所占区域",
                            @"attr":    attributesDict,
                            @"option":  @"textSize"
                            };
        [_dataSource addObject:rowDict];
    }
    return _dataSource;
}

#pragma mark -
#pragma mark TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * kCell = @"identifierCell";
    UITableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:kCell];
    if (!cell) {
        cell    = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCell];
        cell.textLabel.numberOfLines    = 0;
    }
    
    if (self.dataSource[indexPath.row][@"option"]) {
        NSString * option = self.dataSource[indexPath.row][@"option"];
        if ([option isEqualToString:@"UITextView"]) {
            for (UIView * subview in [cell.contentView subviews]) {
                if([subview isKindOfClass:NSClassFromString(@"UITextView")]) {
                    [subview removeFromSuperview];
                }
            }
            UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 88)];
            textView.scrollEnabled = NO;
            textView.editable = NO;
            textView.textContainer.lineFragmentPadding = 0;
            textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
            textView.delegate = self;
            textView.attributedText = [[NSAttributedString alloc] initWithString:self.dataSource[indexPath.row][@"desc"]
                                                                      attributes:self.dataSource[indexPath.row][@"attr"]];
            [cell.contentView addSubview:textView];
        }
        else {
            NSMutableAttributedString *    msg = [[NSMutableAttributedString alloc] initWithString:self.dataSource[indexPath.row][@"desc"]
                                                                          attributes:self.dataSource[indexPath.row][@"attr"]];
            cell.textLabel.attributedText   = msg;

        }
    }
    else {
        NSAttributedString *    msg = [[NSAttributedString alloc] initWithString:self.dataSource[indexPath.row][@"desc"]
                                                                      attributes:self.dataSource[indexPath.row][@"attr"]];
        cell.textLabel.attributedText   = msg;

    }
    return cell;
}

#pragma mark -
#pragma mark TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44 + 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource[indexPath.row][@"option"] isEqualToString:@"textSize"]) {
        UITableViewCell *       cell    = [tableView cellForRowAtIndexPath:indexPath];
        NSAttributedString *    attrStr = cell.textLabel.attributedText;    // assume string exists
        CGSize                  txtSize;
        txtSize = [attrStr boundingRectWithSize:CGSizeMake(cell.textLabel.bounds.size.width, MAXFLOAT)
                                        options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                        context:nil].size;
        UIAlertView *   alertV  = [[UIAlertView alloc] initWithTitle:@"文本的所占区域"
                                                             message:[NSString stringWithFormat:@"width:%f, height%f", txtSize.width, txtSize.height]
                                                            delegate:self
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil];
        [alertV show];
    }
}

#pragma mark - UITextView delegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)url inRange:(NSRange)characterRange {
    return YES;
}

@end
